package pop 
{
	import chart.series.BasePoint;
	import coords.ScreenCoordsBase;
	import flash.display.BlendMode;
	import flash.filters.DropShadowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * 鼠标跟随窗口
	 * @author ...
	 */
	public class ToolTip extends Resizable
	{
		//private var style:Object;//css
		private var _color:uint;
		private var _borderStroke:int;
		//private var _bgcolor:uint;
		//private var _alpha:Number;
		private var _attachedPt:BasePoint;
		private var _width:int;
		private var _height:int;
		
		//private var showTip:Boolean;
		private var _tipMouse:int;
		
		public static const CLOSEST:int = 0;
		public static const PROXIMITY:int = 1;
		public static const NORMAL:int = 2;
		
		public function ToolTip(json:Object) {
			var style:Object = {
				shadow: false,
				//rounded: ThemeCss.tipRounded,
				stroke: ThemeCss.tipStroke,
				color: ThemeCss.tipColor,
				//background: ThemeCss.tipBgColor,
				width: ThemeCss.tipWindowW,
				height: ThemeCss.tipWindowH,
				border: ThemeCss.tipWindowBorder,
				alpha: ThemeCss.tipWindowAlpha,
				mouse: ToolTip.CLOSEST
			};
			var props:Object = ObjectUtil.merge(json, style);
			_color = ParseUtil.toColor(props.color);
			//_bgcolor = ParseUtil.toColor(props.background);
			_width = props.width;
			_height = props.height;
			_borderStroke = props.border;
			_tipMouse = props.mouse;
			
			mouseEnabled = false;
			alpha = props.alpha;//= _alpha
			//showTip = false;
			if (props.shadow) {
				var shadow:DropShadowFilter = new DropShadowFilter();
				shadow.blurX = 4;
				shadow.blurY = 4;
				shadow.distance = 4;
				shadow.angle = 45;
				shadow.quality = 2;
				shadow.alpha = 0.5;
				super.filters = [shadow];
			}
			//blendMode = BlendMode.ALPHA;
		}
		
		/**
		 * 吸附最近点，显示提示窗
		 * @param	pt
		 * @param	coord
		 */
		public function closestPoint(pt:BasePoint, coord:ScreenCoordsBase):void {
			if (pt == null) {
				destroy();
				return;
			}
			_attachedPt = pt;
			_color = pt.toolTipColor;
			resize(coord);
		}
		
		/**
		 * 窗口重绘
		 * @param	coord
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number = NaN, range:Number = NaN):void {
			var tx:Number, ty:Number;
			tx = _attachedPt.x + 5;
			ty = _attachedPt.y + 2;
			if (tx + _width > coord.widthXLeft + coord.axisWidth) {
				tx = _attachedPt.x - _width - 5;
			}
			if (ty + _height > coord.heightYTop + coord.axisHeight) {
				ty = _attachedPt.y - _height - 2;
			}
			graphics.clear();
			while (numChildren > 0) {
				removeChildAt(0);
			}
			drawRectTip(tx, ty);
		}
		
		/**
		 * 控制提示窗显示位置，使其不会超出边界
		 * @param	pt
		 * @param	coord
		 */
		private function drawRectTip(tx:Number, ty:Number):void {
			graphics.beginFill(0xffffff);//白底
			graphics.lineStyle(_borderStroke, _color, 0.8);
			graphics.drawRect(tx, ty, _width, _height);
			var txtFmt:TextFormat = new TextFormat();
			txtFmt.color = _color;
			txtFmt.size = ThemeCss.tipStroke;
			var txt:TextField = new TextField();
			txt.text = _attachedPt.toolTip;
			txt.setTextFormat(txtFmt);//设置文本内容之后设置TextFormat，否则失效
			txt.x = tx + 2;
			txt.y = ty + 2;
			//txt.antiAliasType = AntiAliasType.ADVANCED;
			addChild(txt);
			graphics.endFill();
		}
		
		/**
		 * 获取鼠标跟随事件类型
		 * @return
		 */
		public function get tipMouse():int {
			return _tipMouse;
		}
		
		/**
		 * gc
		 */
		override public function destroy():void {
			super.destroy();
			if (_attachedPt != null) {
				_attachedPt.destroy();
				_attachedPt = null;
			}
		}
	}

}