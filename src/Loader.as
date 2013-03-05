package  
{
	import util.ObjectUtil;
	/**
	 * 异步数据加载基类，每个异步加载类都必须继承此类并覆盖process方法
	 * @author maoxiajun
	 */
	public class Loader 
	{
		/**
		 * 图表初始化对象
		 */
		protected var _props:Object;
		
		/**
		 * 资源定位符
		 */
		protected var _uris:Array;
		
		public function Loader(json:Object) 
		{
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
		public function process(json:Object):Boolean {
			return false;
		}
		
		/**
		 * gc
		 */
		public function destroy():void {
			_props = null;
		}
	}

}