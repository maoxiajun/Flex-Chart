package chart.series.point 
{
	import chart.series.BasePoint;
	import coords.ScreenCoordsBase;
	import flash.display.BlendMode;
	import theme.RandomColor;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * 点，先画点而后画其他
	 * @author maoxiajun
	 */
	public class Point extends BasePoint
	{
		//private var _color:uint;
		private var _stroke:int;
		//private var _x:Number;
		//private var _y:Number;
		
		public function Point(json:Object) 
		{
			var style:Object = {
				color: RandomColor.randomColor(),
				stroke: ThemeCss.pointStroke,
				x:0,
				y:0
			};
			var props:Object = ObjectUtil.merge(json, style);
			_color = ParseUtil.toColor(props.color);
			_stroke = props.stroke;
			_x = props.x;
			_y = props.y;
			//可以被上层sprite擦除
			//blendMode = BlendMode.ERASE;
			attachEvents();
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
		override public function resize(coord:ScreenCoordsBase, begin:Number=NaN, range:Number=NaN):void {
			//rest数组中存储了纵坐标值信息，用于根据数据值定位在坐标系中的高度
			super.resize(coord, begin, range);
			graphics.clear();
			graphics.beginFill(_color);
			graphics.drawCircle(0, 0, _stroke);
			//trace(x + "," + y);
			graphics.endFill();
		}
	}

}