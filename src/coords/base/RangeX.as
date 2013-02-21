package coords.base 
{
	import theme.ThemeConst;
	/**
	 * 坐标轴长
	 * @author maoxiajun
	 */
	public class RangeX
	{
		private var _left:int;
		private var _right:int;
		private var _count:int;
		private var _offset:Boolean;
		
		public function RangeX(left:int=0, right:int=0, count:int=0, offset:Boolean=false) 
		{
			_left = left;
			_right = right;
			_count = count;
			_offset = offset;
		}
		
		/**
		 * X坐标轴长
		 */
		/*public function get length():int {
			//
			// range, 5 - 10 = 10 - 5 = 5
			// range -5 - 5 = 5 - -5 = 10
			//
			//
			//  x_offset:
			//
			//   False            True
			//
			//  |               |
			//  |               |
			//  |               |
			//  +--+--+--+      |-+--+--+--+-+
			//  0  1  2  3        0  1  2  3
			//
			if( _offset )
				return (_right - _left) + 1;
			else
				return _right - _left;
		}*/
		
		/**
		 * padding-left
		 */
		public function get paddingLeft():int {
			return _left;
		}
		
		/**
		 * padding-right
		 */
		public function get paddingRight():int {
			return _right;
		}
		
		/**
		 * 数据点显示个数，用作默认X轴刻度个数
		 */
		public function get count():int {
			return _count < 1 ? ThemeConst.xAxisCount : _count;
		}
	}

}