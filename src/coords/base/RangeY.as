package coords.base 
{
	import theme.ThemeConst;
	/**
	 * Y坐标轴长
	 * @author maoxiajun
	 */
	public class RangeY {
		private var _top:int;
		private var _bottom:int;
		private var _count:int;
		
		public function RangeY(top:int = 0, bottom:int = 0, count:int = 0) {
			_top = top;
			_bottom = bottom;
			_count = count;
		}
		
		/**
		 * padding-top
		 */
		public function get paddingTop():int {
			return _top;
		}
		
		/**
		 * padding-bottom
		 */
		public function get paddingBottom():int {
			return _bottom;
		}
		
		/**
		 * Y坐标刻度，用作坐标系中的默认Y轴刻度个数
		 */
		public function get count():int {
			return _count < 1 ? ThemeConst.yAxisCount : _count;
		}
	}

}