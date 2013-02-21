package chart 
{
	import chart.series.BasePoint;
	import coords.ScreenCoordsBase;
	import flash.display.Sprite;
	/**
	 * 画区显示的底层组成部分
	 * @author ...
	 */
	public class BaseGraphic extends Resizable {
		//private var _key:String;//unknown，可能用于标识元素的键
		//private var _fontSize:int;
		//private var _axis:int;//unknown
		
		//protected var _colors:Array = [];//存放线的颜色
		protected var _color:uint;
		protected var _lineWidth:int;
		//protected var _circleSize:int;
		
		//private var _elementVals:Array;//存储对象的值，例如坐标等用于确定显示位置
		
		/**
		 * 返回颜色
		 * @return
		 */
		/*public function get color():uint {
			return _color;
		}*/
		
		/**
		 * 未知用途，待确定
		 * @return
		 */
		/*public function getKeyValues():Object {
			var tmp:Array = [];
			
			if (fontSize > 0 && key != null) {
				tmp.push( {
					"text": key,
					"font-size": fontSize,
					"color": color
				});
			}
			return tmp;
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
		 * 接口函数，待子类实现
		 * @param	coords
		 */
		//override public function resize(coord:ScreenCoordsBase):void { }
		
		/**
		 * 检索最近点
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function closest(x:Number, y:Number):Object {
			var shortest:Number = Number.MAX_VALUE;
			var closest:BasePoint, dx:Number;
			
			for (var i:int = 0; i < numChildren; i++ ) {
				if (getChildAt(i) is BasePoint) {
					var pt:BasePoint = getChildAt(i) as BasePoint;
					//element.toolTipShow = false;
					
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
			return { pt:closest, dx:shortest, dy:dy };
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