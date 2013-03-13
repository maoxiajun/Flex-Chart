package coords 
{
	import coords.base.RangeX;
	import coords.base.RangeY;
	import flash.geom.Point;
	/**
	 * 图表坐标系，用于所有图形元素的定位
	 * @author maoxiajun
	 */
	public class ScreenCoords extends ScreenCoordsBase
	{
		private var _widthXLeft:int;//左补偿
		private var _widthXRight:int;//右补偿
		private var _heightYTop:int;//上补偿
		private var _heightYBottom:int;// 下补偿
		
		//private var _itemWidth:Number;
		//private var _itemHeight:Number;
		//private var _defaultXCount:int;
		//private var _defaultYCount:int;
		//private var offsetX:Boolean;
		//private var offsetY:Boolean;
		
		public function ScreenCoords(top:int, left:int, right:int, bottom:int,
			rangeX:RangeX, rangeY:RangeY, 
			/*widthXLeft:int=0, widthXRight:int=0, heightYTop:int=0, heightYBottom:int=0,*/ isThreeD:Boolean=false) {
			
			super(top, left, right, bottom);
			
			_widthXLeft = rangeX.paddingLeft;
			_widthXRight = rangeX.paddingRight;
			_heightYTop = rangeY.paddingTop;
			_heightYBottom = rangeY.paddingBottom;
			
			//_itemWidth = axisWidth / (rangeX.count - 1);
			//_itemHeight = axisHeight / (rangeY.count - 1);
			//_defaultXCount = rangeX.count;
			//_defaultYCount = rangeY.count;
		}
		
		/**
		 * 横坐标轴长
		 * @return
		 */
		override public function get axisWidth():int {
			return _right - _left - _widthXLeft - _widthXRight;
		}
		
		/**
		 * 纵坐标轴高
		 */
		override public function get axisHeight():int {
			return _bottom - _top - _heightYBottom - _heightYTop;
		}
		
		/**
		 * 画区宽度
		 */
		override public function get stageWidth():int {
			return _right - _left;
		}
		
		/**
		 * 画区高度
		 */
		override public function get stageHeight():int {
			return _bottom - _top;
		}
		
		/**
		 * 根据点对应的实际数值获取对应屏幕显示的纵坐标
		 * @param	val
		 * @param	rightAxis
		 * @return
		 */
		override public function getYFromVal(val:Number, begin:Number, range:Number, rightAxis:Boolean = false):Number { 
			if (isNaN(range) || range == 0) {
				return val;
			}
			var offset:int = _top + _heightYTop;
			var percent:Number = Math.abs(val - begin) / range;
			return (1 - percent) * axisHeight + offset;//坐标原点为左上角
		}
		
		/**
		 * 根据点对应的实际数据值获取对应屏幕显示的横坐标
		 * @param	val
		 * @return
		 */
		override public function getXFromVal( val:Number, begin:Number, range:Number ):Number { 
			if (isNaN(range) || range == 0) {
				return val;
			}
			var offset:int = _left + _widthXLeft;
			var percent:Number = Math.abs(val - begin) / range;
			return percent * axisWidth + offset;
		}
		
		/**
		 * 综合方法，getXFromPos, getYFromVal
		 * @param	index
		 * @param	val
		 * @param	rightAxis
		 * @return
		 */
		override public function getXFromPosYFromVal( index:int, count:int, val:Number, begin:Number, range:Number, 
			rightAxis:Boolean = false ):Point {
			var point:Point = new Point();
			point.x = getXFromPos(index, count);
			point.y = getYFromVal(val, begin, range, rightAxis);
			return point;
		}
		
		/**
		 * 根据传入的数值数组中实际数值在数组中的序号
		 * 获取对应屏幕显示位置的Y值，用于定位Y轴刻度
		 * @param	index
		 * @return
		 */
		override public function getYFromPos( index:int, count:int=0 ):Number {
			//return _top + _heightYTop + axisHeight - index * _itemHeight;
			if (count == 0) {
				return NaN;//count = _defaultYCount;
			}
			var itemHeight:Number = axisHeight / (count - 1);
			return _top + _heightYTop + axisHeight - index * itemHeight;
		}
		
		/**
		 * 根据传入的数值数组中实际数值在数组中的序号
		 * 获取对应屏幕显示的横坐标
		 * @param	index
		 * @return
		 */
		override public function getXFromPos( index:int, count:int=0 ):Number {
			//return _left + _widthXLeft + index * _itemWidth;
			if (count == 0) {
				return NaN;//count = _defaultXCount;
			}
			var itemWidth:Number = axisWidth / (count - 1);
			return _left + _widthXLeft + index * itemWidth;
		}
		
		/**
		 * 返回屏幕坐标（屏幕坐标为统一使用的坐标系）
		 * @return
		 */
		override public function get widthXLeft():int {
			return _left + _widthXLeft;
		}
		
		/**
		 * 返回屏幕Y坐标
		 * @return
		 */
		override public function get heightYTop():int {
			return _top + _heightYTop;
		}
	}
}