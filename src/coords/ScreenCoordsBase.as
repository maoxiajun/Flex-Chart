package coords 
{
	import flash.geom.Point;
	/**
	 * 屏幕坐标
	 * @author maoxiajun
	 */
	public class ScreenCoordsBase {
		protected var _top:int;//上
		protected var _left:int;//左
		protected var _right:int;//右
		protected var _bottom:int;//下
		protected var _width:int;//宽
		protected var _height:int;//高
		
		public function ScreenCoordsBase(top:int, left:int, right:int, bottom:int) {
			_top = top;
			_left = left;
			_right = right;
			_bottom = bottom;
			
			_width = right - left;
			_height = bottom - top;
		}
		
		/**
		 * 获取显示区中点横坐标
		 */
		public function get centerX():int {
			return (_width / 2) + _left;
		}

		/**
		 * 获取显示区中点纵坐标
		 */
		public function get centerY():int {
			return (_height / 2) + _top;
		}
		
		/**
		 * 横坐标轴长
		 * @return
		 */
		public function get axisWidth():int {
			return -1;
		}
		
		/**
		 * 纵坐标轴高
		 */
		public function get axisHeight():int {
			return -1;
		}
		
		/**
		 * 画区宽度
		 */
		public function get stageWidth():int {
			return -1;
		}
		
		/**
		 * 画区高度
		 */
		public function get stageHeight():int {
			return -1;
		}
		
		/**
		 * 根据点对应的实际数值获取对应屏幕显示的纵坐标
		 * @param	val
		 * @param	rightAxis
		 * @return
		 */
		public function getYFromVal( val:Number, begin:Number, range:Number, rightAxis:Boolean = false ):Number { 
			return -1; 
		}
		
		/**
		 * 根据点对应的实际数据值获取对应屏幕显示的横坐标
		 * @param	val
		 * @return
		 */
		public function getXFromVal( val:Number , begin:Number, range:Number):Number { 
			return -1;
		}
		
		/**
		 * 综合方法，getXFromPos, getYFromVal
		 * @param	index
		 * @param	y
		 * @param	rightAxis
		 * @return
		 */
		public function getXFromPosYFromVal( index:int, count:int, val:Number, begin:Number, range:Number, 
			rightAxis:Boolean = false ):Point {
			return null;
		}
		
		/**
		 * 根据传入的数值数组中实际数值在数组中的序号
		 * 获取对应屏幕显示位置的Y值，用于定位Y轴刻度
		 * @param	index
		 * @return
		 */
		public function getYFromPos( index:int, count:int=0 ):Number {
			return -1;
		}
		
		/**
		 * 根据传入的数值数组中实际数值在数组中的序号
		 * 获取对应屏幕显示位置的X值，用于定位X轴刻度
		 * @param	index
		 * @return
		 */
		public function getXFromPos( index:int, count:int=0 ):Number {
			return -1;
		}
		
		/**
		 * 返回坐标区域的起点处横坐标
		 * @return
		 */
		public function get widthXLeft():int {
			return -1;
		}
		
		/**
		 * 返回坐标区域的起点处纵坐标，屏幕区域的起点为左上角
		 * |*（此处起点）
		 * |
		 * |
		 * +--+--+--+
		 * 0  1  2  3
		 * @return
		 */
		public function get heightYTop():int {
			return -1;
		}
	}

}