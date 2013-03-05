package stages.axis 
{
	import coords.ScreenCoordsBase;
	import flash.display.Sprite;
	import theme.ThemeConst;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * Y轴，纵坐标，Y轴的处理有点特殊，需要由折线绘制过程来确定刻度，主要是考虑到多条折线的可能
	 * @author maoxiajun
	 */
	public class YAxis extends Resizable {
		
		private var _color:uint;
		private var _count:int;
		//private var _scales:Array;
		private var _width:int;
		private var _length:int;
		
		public function YAxis(json:Object) {
			var style:Object = {
				//topLimit : Number.NaN,
				//bottomLimit : Number.NaN,
				//steps : Number.NaN,
				color : ThemeCss.axisColor,
				count : ThemeConst.yAxisCount,
				width : ThemeConst.axisWidth,
				length : ThemeConst.scaleLength
			}
			var props:Object = ObjectUtil.merge(json ? json : {}, style);
			_color = ParseUtil.toColor(props.color);
			_count = props.count;
			_width = props.width;
			_length = props.length;
			//buildYScale(props);//创建Y轴刻度
		}
		
		/**
		 * 返回Y轴刻度数量
		 */
		public function get count():int {
			return _count;// < 1 ? ThemeConst.yAxisCount : _count;
		}
		
		/**
		 * 绘制Y轴坐标刻度
		 */
		/*private function buildYScale(props:Object):void {
			var scales:Array = props.scale as Array;
			_scales = [];
			for (var i:int = 0; i < scales.length; i++ ) {
				var scale:YScale = new YScale(scales[i]);
				_scales.push(scale);
				addChild(scale);
			}
		}*/
		
		/**
		 * 重绘，绘制纵坐标
		 * @param	coord
		 * @param	begin
		 * @param	range
		 */
		override public function resize(coord:ScreenCoordsBase, begin:Number = NaN, range:Number = NaN):void {
			//var step:Number = coord.axisHeight / (_count - 1);
			graphics.clear();
			graphics.beginFill(_color);
			graphics.drawRect(coord.widthXLeft, coord.heightYTop, _width, coord.axisHeight);
			for (var i:int = 0; i < _count; i++ ) {
				graphics.drawRect(coord.widthXLeft - _length, coord.getYFromPos(i, _count), _length, _width);
				//trace(coord.axisHeight + "," + i*interval + "," + i%2 * offset);
			}
			graphics.endFill();
			/*for (var i:int = 0; i < _scales.length; i++) {
				(_scales[i] as YScale).resize(coord);
			}*/
		}
		
	}

}