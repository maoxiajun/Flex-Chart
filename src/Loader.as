package  
{
	import chart.series.BasePoint;
	import chart.series.point.PointCollection;
	import flash.geom.Rectangle;
	import util.ObjectUtil;
	/**
	 * 异步数据加载基类，每个异步加载类都必须继承此类并覆盖process方法
	 * @author maoxiajun
	 */
	public class Loader {
		/**
		 * 图表初始化对象
		 */
		protected var _props:Object;
		
		/**
		 * 复位对象，存储折线图初次加载时的完整数据
		 */
		protected var _origin:Object;
		
		/**
		 * 资源定位符
		 */
		protected var _uris:Array;
		
		public function Loader(json:Object) {
			var template:Object = {
				"background": { },
				"xaxis": { },
				"yaxis": { },
				"chart": {
					"chartData": [{
						"data": [0.11, 0.12, 0.121, 0.215, 0.13, 0.23, 0.1, 0.09, 0.102, 0.15, 0.16, 0.195,
							0.145, 0.135, 0.155, 0.132, 0.142, 0.156, 0.168, 0.121],
						"yscale": { },
						"xscale": {
							"data": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
						}
					}]
				},
				"tooltip": { },
				"menu": { }
			};
			_props = ObjectUtil.merge(json, template);
			_uris = [];
		}
		
		/**
		 * 获取初始参数
		 */
		public function get props():Object {
			return _props;
		}
		
		/**
		 * 复位对象
		 */
		public function reset():void {
			_props = ObjectUtil.copy(_origin);
		}
		
		/**
		 * 图表数据
		 */
		public function get uris():Array {
			return _uris;
		}
		
		/**
		 * 处理异步加载的json数据，返回bool型表示是否已完成所有数据的加载
		 * @param	json
		 * @return
		 */
		public function process(json:Object):Boolean { return false; }
		
		/**
		 * 重载数据
		 * @param	json
		 */
		public function reload(json:Object):void {
			if (json != null) {
				_origin = ObjectUtil.mergeOverride(_origin, json);
			}
			//拷贝原始数据
			reset();
		}
		
		/**
		 * 根据矩形框范围重新组织选中的数据，用于框选放大，此方法待改善
		 * @param	rect
		 * @return
		 */
		public function belongTo(selected:Array):Object {
			//深度复制对象，否则复制的是props的地址引用
			for each (var item:Object in selected) {
				var subpt:PointCollection = item['points'] as PointCollection;
				if (subpt.points.length < 2) {
					continue;
				}
				//根据index获取对应的数据集
				var tmpData:Array = _props['chart']['chartData'][item['index']]['data'];
				var tmpXScale:Array = _props['chart']['chartData'][item['index']]['xscale']['data'];
				var newData:Array = [], newXScale:Array = [];
				for (var i:int = 0; i < tmpData.length; i++ ) {
					if (i > (subpt.points[0] as BasePoint).tipPositon.x - 1 && 
						i < (subpt.points[subpt.length - 1] as BasePoint).tipPositon.x + 1) {
						newData.push(tmpData[i]);
						newXScale.push(tmpXScale[i]);//标注与数据应一致
					}
				}
				_props['chart']['chartData'][item['index']]['data'] = newData;
				_props['chart']['chartData'][item['index']]['xscale']['data'] = newXScale;
			}
			return _props;
		}
		
		/**
		 * gc
		 */
		public function destroy():void {
			_props = null;
			_uris = null;
		}
	}

}