package chart 
{
	import chart.series.BaseLine;
	import chart.series.BasePoint;
	import coords.ScreenCoordsBase;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/**
	 * 画区显示对象集合
	 * TODO: 增加缓存对象
	 * @author maoxiajun
	 */
	public class SpriteCollection {
		//动态组件容器
		private var dynamicItems:Array;
		
		public function SpriteCollection(items:Array = null) {
			dynamicItems = items != null ? items : [];
		}
		
		/**
		 * 获取画区X坐标最小值，此类中存放的为子画区，例如一条曲线，
		 * 此方法在于从所有子曲线中查找X坐标最小值，比较每一个子画区中的X坐标最小值
		 * @return
		 */
		public function get minX():Number {
			var min:Number = Number.MAX_VALUE;
			for each(var item:BaseGraphic in dynamicItems) {
				min = Math.min(min, item.minX);
			}
			return min;
		}
		
		/**
		 * 获取画区X坐标最大值
		 * @return
		 */
		public function get maxX():Number {
			var max:Number = Number.MIN_VALUE;
			for each(var item:BaseGraphic in dynamicItems) {
				max = Math.max(max, item.maxX);
			}
			return max;
		}
		
		/**
		 * 查找最近点
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function closest(x:Number, y:Number):BasePoint {
			//简化处理，返回第一个图表对象中的最近点
			return (dynamicItems[0] as BaseGraphic).closest(x, y);
		}
		
		/**
		 * 查找包含在矩形框内部的对象索引
		 * @param	rect
		 * @return
		 */
		public function contains(rect:Rectangle):Array {
			var selectedItems:Array = [];
			for each(var item:BaseGraphic in dynamicItems) {
				if (item is BaseLine) {
					selectedItems.push((item as BaseLine).findPointsByRect(rect));
				}
			}
			return selectedItems;
		}
		
		/**
		 * 画区重绘
		 * @param	coord
		 */
		public function resize(coord:ScreenCoordsBase):void {
			/*for each(var item:Resizable in cachedItems) {
				item.resize(coord);
			}*/
			for each(var item:BaseGraphic in dynamicItems) {
				item.resize(coord);
			}
		}
		
		/**
		 * 动态组件
		 */
		public function get dynamics():Array {
			return dynamicItems;
		}
		
		/**
		 * 添加动态组件至容器
		 * @param	itemectSet
		 */
		public function addDynamic(item:BaseGraphic):void {
			dynamicItems.push(item);
		}
		
		/**
		 * 销毁动态组件
		 */
		public function destroy():void {
			for each(var item:BaseGraphic in dynamicItems) {
				item.destroy();
			}
		}
	}

}