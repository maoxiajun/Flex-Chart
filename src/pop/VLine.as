package pop 
{
	import coords.ScreenCoordsBase;
	import theme.ThemeConst;
	import theme.ThemeCss;
	import util.ObjectUtil;
	/**
	 * 竖标示线
	 * @author maoxiajun
	 */
	public class VLine extends Resizable
	{
		private var _color:uint;
		private var _limit:Number;
		private var _limitWidth:Number;
		private var _type:String;
		//private var _scale:Object;
		private var _stroke:int;
		private var _alpha:Number;
		
		public function VLine(json:Object) 
		{
			var style:Object = {
				color: ThemeCss.tipColor,
				type: 'dash',
				stroke: 1,
				alpha: 0.8,
				limit: undefined
				//scale: null
			};
			var props:Object = ObjectUtil.merge(json, style);
			_color = props.color;
			_type = props.type;
			//_scale = props.scale;
			_limit = props.limit;
			_stroke = props.stroke;
			_alpha = props.alpha;
		}
		
		/**
		 * 画虚线
		 */
		private function drawDashLine(coord:ScreenCoordsBase):void {
			var dashLineHeight:int = coord.heightYTop;
			var height:int = coord.axisHeight + dashLineHeight;
			//_limit = _limit ? coord.getYFromVal(_limit, _scale['begin'], _scale['range']) : 0;
			graphics.moveTo(_limitWidth, height);
			while (dashLineHeight > coord.heightYTop) {
				graphics.lineTo(_limitWidth, height - dashLineHeight - ThemeConst.limitLineDashOn);
				dashLineHeight -= ThemeConst.limitLineDashOn + ThemeConst.limitLineDashOff;
				graphics.moveTo(_limitWidth, dashLineHeight);
			}
		}
		
		/**
		 * 画实线
		 * @param	coord
		 */
		private function drawSolidLine(coord:ScreenCoordsBase):void {
			graphics.moveTo(_limitWidth, coord.heightYTop);
			graphics.lineTo(_limitWidth, coord.heightYTop + coord.axisHeight);
		}

		/**
		 * 设置阈值并返回自身
		 * @param	val
		 * @return
		 */
		public function limit(val:Number):VLine {
			_limit = val;
			return this;
		}
		
		/**
		 * 定位超标提示线并重绘
		 * @param	coord
		 * @param	limit
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number = NaN, range:Number = NaN):void {
			if (isNaN(_limit)) {
				graphics.clear();
				return;
			}
			_limitWidth = coord.getXFromVal(_limit, begin, range);
			graphics.clear();
			graphics.lineStyle(_stroke, _color, _alpha);
			switch (_type) {
				case 'dash': drawDashLine(coord); break;
				case 'solid': drawSolidLine(coord); break;
			}
		}
		
	}

}