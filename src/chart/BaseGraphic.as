package chart 
{
	import chart.series.BasePoint;
	/**
	 * 画区显示的底层组成部分
	 * @author maoxiajun
	 */
	public class BaseGraphic extends Resizable {
		protected var _color:uint;
		protected var _lineStroke:int;
		
		/**
		 * 返回颜色
		 * @return
		 */
		/*public function get color():uint {
			return _color;
		}*/
		
		/**
		 * 获取对应的坐标轴，Y坐标
		 * @param	data
		 * @param	me
		 * @return
		 */
		/*protected function getAttachedAxis(data:Array, me:Number):int {
			if (data["showY2"] != undefined) {
				if (data["showY2"] != false) {
					if (data["y2Lines"] != undefined) {
						var tmp:Array = data.y2Lines.split(",");
						var pos:int = tmp.indexOf(me.toString());
						
						if (pos == -1) {
							return 1;
						}
						return 2;
					}
				}
			}
			return 1;
		}*/
		
		/**
		 * 获取X坐标最大值
		 * @return
		 */
		public function get maxX():Number {
			var max:Number = Number.MIN_VALUE;
			
			for (var i:int = 0; i < numChildren; i++ ) {
				if (getChildAt(i) is BasePoint) {
					var pt:BasePoint = getChildAt(i) as BasePoint;
					max = Math.max(max, pt.tipPositon.x);
				}
			}
			return max;
		}
		
		public function get minX():Number {
			var min:Number = Number.MAX_VALUE;
			
			for (var i:int = 0; i < numChildren; i++ ) {
				if (getChildAt(i) is BasePoint) {
					var pt:BasePoint = getChildAt(i) as BasePoint;
					min = Math.min(min, pt.tipPositon.x);
				}
			}
			return min;
		}
		
		/**
		 * 检索最近点
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function closest(x:Number, y:Number):BasePoint {
			var shortest:Number = Number.MAX_VALUE;
			var closest:BasePoint, dx:Number;
			
			for (var i:int = 0; i < numChildren; i++ ) {
				if (getChildAt(i) is BasePoint) {
					var pt:BasePoint = getChildAt(i) as BasePoint;
					
					dx = Math.abs(x - pt.x);
					if (dx < shortest) {
						shortest = dx;
						closest = pt;
					}
				}
			}
			
			var dy:Number = 0;
			if (closest) {
				dy = Math.abs(y - closest.y);
			}
			return closest;//{ pt:closest, dx:shortest, dy:dy };
		}
		
		/**
		 * gc
		 */
		override public function destroy():void {
			graphics.clear();
			for (var i:int = 0; i < numChildren; i++ ) {
				if (getChildAt(i) is BasePoint) {
					var pt:BasePoint = getChildAt(i) as BasePoint;
					pt.destroy();
				}
			}
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}
	}

}