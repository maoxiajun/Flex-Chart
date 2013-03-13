package stages.axis
{
	import coords.ScreenCoordsBase;
	import theme.ThemeConst;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	
	/**
	 * 绘制横坐标轴
	 * @author maoxiajun
	 */
	public class XAxis extends Resizable
	{
		//private var _count:int;
		private var _color:uint;
		private var _width:int;
		//private var _length:int;
		
		//private var _scale:XScale;
		
		public function XAxis(json:Object)
		{
			var style:Object = {
				//count : ThemeConst.xAxisCount,
				color : ThemeCss.axisColor,
				width : ThemeConst.axisWidth//,
				//length : ThemeConst.scaleLength
			};
			var props:Object = ObjectUtil.merge(json, style);
			//_count = props.count;
			_color = ParseUtil.toColor(props.color);
			_width = props.width;
			//_length = props.length;
			//buildXScale(props);
		}
		
		/*private function buildXScale(json:Object):void {
			_scale = new XScale(json);
			addChild(_scale);
		}*/
		
		/**
		 * 返回数据点显示个数
		 */
		/*public function get count():int {
			return _count;// < 1 ? ThemeConst.xAxisCount : _count;
		}*/
		
		/**
		 * 窗口重绘，绘制横坐标
		 * @param	coord
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number = NaN, range:Number = NaN):void {
			graphics.clear();
			graphics.beginFill(_color);
			//宽度+2为了坐标刻度
			graphics.drawRect(coord.widthXLeft, coord.heightYTop + coord.axisHeight, coord.axisWidth + _width, _width);
			//addChild(_scale);
			/*for (var i:int = 0; i < _count; i++ ) {
				graphics.drawRect(coord.getXFromPos(i, _count), 
					coord.heightYTop + coord.axisHeight + _length, _width, _length);
			}*/
			//_scale.resize(coord);
			graphics.endFill();
		}
		
	}

}