package chart.series.point 
{
	import chart.series.BasePoint;
	import coords.ScreenCoordsBase;
	/**
	 * 点，先画点而后画其他
	 * @author maoxiajun
	 */
	public class Point extends BasePoint {
		//private var _color:uint;
		//private var _stroke:int;
		
		public function Point(json:Object) {
			super(json);
			//可以被上层sprite擦除
			//blendMode = BlendMode.ERASE;
		}
		
		/**
		 * 返回数值
		 */
		override public function get toolTip():String {
			return _y.toString();
		}
		
		/**
		 * 窗口重绘
		 * @param	coord
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number=NaN, range:Number=NaN):void {
			//rest数组中存储了纵坐标值信息，用于根据数据值定位在坐标系中的高度
			super.resize(coord, count, begin, range);
			graphics.clear();
			graphics.beginFill(_color);
			graphics.drawCircle(0, 0, _stroke);
			//trace(x + "," + y);
			graphics.endFill();
		}
	}

}