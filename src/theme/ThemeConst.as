package theme 
{
	/**
	 * 用于确定一些默认常量值
	 * 例如Y轴刻度数量、X轴刻度数量，线宽等
	 * @author maoxiajun
	 */
	public final class ThemeConst 
	{
		/**
		 * X轴刻度数量
		 */
		public static function get xAxisCount():int { return 20; }
		
		/**
		 * Y轴刻度数量
		 */
		public static function get yAxisCount():int { return 10; }
		
		/**
		 * 返回线宽
		 */
		public static function get axisWidth():int { return 2; }
		
		/**
		 * 刻度长度
		 */
		public static function get scaleLength():int { return 2; }
		
		/**
		 * 刻度长度带来的坐标标签偏移补偿量
		 */
		public static function get scaleLengthOffset():int { return 6; }
		
		/**
		 * 提示线的虚线片段长度
		 */
		public static function get limitLineDashOn():int { return 10; }
		
		/**
		 * 提示线的虚线片段长度
		 */
		public static function get limitLineDashOff():int { return 10; }
		
		/**
		 * 刷新菜单中combobox的默认值
		 */
		public static function get timeIntervals():Array { return [ -1, 5, 10, 15]; }
		
		/**
		 * 默认采用的Y轴
		 */
		public static function get attachAxis():String { return "left"; }
	}

}