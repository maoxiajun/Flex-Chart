package stages 
{
	import flash.display.Sprite;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * 图表背景，包括坐标系、网格等。
	 * @author maoxiajun
	 */
	public class BackGround extends Sprite
	{
		private var _color:uint;
		private var _padding:String;
		private var _paddingTop:int;
		private var _paddingBottom:int;
		private var _paddingLeft:int;
		private var _paddingRight:int;
		
		public function BackGround(json:Object)
		{
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
		 * 窗口重绘，实际用途为绘制背景
		 */
		public function resize():void {
			graphics.beginFill(_color);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
		
		/**
		 * gc
		 */
		public function destroy():void {
			graphics.clear();
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}
	}

}