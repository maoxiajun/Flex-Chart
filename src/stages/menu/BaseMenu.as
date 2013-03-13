package stages.menu 
{
	import coords.ScreenCoordsBase;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * 菜单
	 * @author maoxiajun
	 */
	public class BaseMenu extends Resizable {
		protected var _callbackList:Array;
		protected var _height:int;
		
		private var _borderCss:Array = [];
		private var _bgColor:uint = 0xf9f9f9;
		
		public function BaseMenu(json:Object) {
			var style:Object = {
				border: ThemeCss.menuBorderCss,//"1px 0 1px 0 #000000"
				bgColor: ThemeCss.menuBgColor,
				height: ThemeCss.menuHeight
			};
			var props:Object = ObjectUtil.merge(json, style);
			_bgColor = ParseUtil.toColor(props.bgColor);
			_borderCss = (props.border as String).split(String.fromCharCode(32));
			_height = props.height;
		}
		
		/**
		 * 绘制菜单
		 * @param	coord
		 * @param	begin
		 * @param	range
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number = NaN, range:Number = NaN):void {
			graphics.clear();
			graphics.beginFill(_bgColor);
			//graphics.lineStyle(_borderWitdth, _borderColor);
			graphics.drawRect(0, 0, coord.stageWidth,  _height);
			graphics.endFill();
			drawMenuBorder(coord);
		}
		
		/**
		 * 菜单单击响应事件
		 */
		public function addClickHandler(type:String, callback:Function):void {
			if (_callbackList == null) {
				_callbackList = [];
			}
			_callbackList.push([type, callback]);
		}
		
		/**
		 * 绘制菜单边界
		 */
		private function drawMenuBorder(coord:ScreenCoordsBase):void {
			var color:uint = ParseUtil.toColor(_borderCss[4]);
			if (_borderCss[0] != "0") {
				graphics.lineStyle(ParseUtil.toPixel(_borderCss[0]), color);
				graphics.moveTo(0, 0);
				graphics.lineTo(coord.stageWidth, 0);
			}
			var rightBorderStroke:int = ParseUtil.toPixel(_borderCss[1]);
			if (rightBorderStroke != 0) {
				graphics.lineStyle(rightBorderStroke, color);
				graphics.moveTo(coord.stageWidth - rightBorderStroke, 0);
				graphics.lineTo(coord.stageWidth - rightBorderStroke, _height);
			}
			if (_borderCss[2] != "0") {
				graphics.lineStyle(ParseUtil.toPixel(_borderCss[2]), color);
				graphics.moveTo(coord.stageWidth, _height);
				graphics.lineTo(0, _height);
			}
			if (_borderCss[3] != "0") {
				graphics.lineStyle(ParseUtil.toPixel(_borderCss[3]), color);
				graphics.moveTo(0, _height);
				graphics.lineTo(0, 0);
			}
		}
		
		/**
		 * gc
		 */
		override public function destroy():void {
			super.destroy();
			_borderCss = null;
			_callbackList = null;
		}
	}
	
}