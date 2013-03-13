package stages 
{
	import coords.ScreenCoordsBase;
	import flash.geom.Rectangle;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * 图表背景，包括坐标系、网格等。
	 * @author maoxiajun
	 */
	public class BackGround extends Resizable {
		private var _color:uint;
		private var _padding:String;
		
		private var _paddingTop:int;
		private var _paddingBottom:int;
		private var _paddingLeft:int;
		private var _paddingRight:int;
		
		private var _stageW:int = 0;
		private var _stageH:int = 0;
		
		public function BackGround(json:Object) {
			var style:Object = {
				color : ThemeCss.bgColor,
				padding : ThemeCss.bgPaddding
			};
			var props:Object = ObjectUtil.merge(json, style);
			_color = ParseUtil.toColor(props.color);
			setPadding(props.padding);
		}
		
		/**
		 * 设置背景与坐标系之间的padding
		 * @param	padding
		 */
		private function setPadding(padding:String):void {
			//按空格分隔
			var paddings:Array = padding.split(String.fromCharCode(32));
			_paddingTop = ParseUtil.toPixel(paddings[0]);
			_paddingRight = ParseUtil.toPixel(paddings[1]);
			_paddingBottom = ParseUtil.toPixel(paddings[2]);
			_paddingLeft = ParseUtil.toPixel(paddings[3]);
		}
		
		public function get paddingTop():int {
			return _paddingTop;
		}
		
		public function get paddingRight():int {
			return _paddingRight;
		}
		
		public function get paddingBottom():int {
			return _paddingBottom;
		}
		
		public function get paddingLeft():int {
			return _paddingLeft;
		}
		
		/**
		 * 判断点是否在背景内
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function covers(x:Number, y:Number):Boolean {
			//以0,0为原点，故矩形内省略了减0的部分
			return new Rectangle(0 + _paddingLeft, 0 + _paddingTop,
				_stageW - _paddingRight - _paddingLeft - 0, _stageH - _paddingBottom - _paddingTop).contains(x, y);
		}
		
		/**
		 * 窗口重绘，实际用途为绘制背景
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number = NaN, range:Number = NaN):void {
			graphics.beginFill(_color);
			graphics.drawRect(0, 0, coord.stageWidth, coord.stageHeight);
			graphics.endFill();
			_stageW = coord.stageWidth;
			_stageH = coord.stageHeight;
		}
		
	}

}