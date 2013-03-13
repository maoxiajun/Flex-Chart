package theme
{
	/**
	 * 主题样式类
	 * @author maoxiajun
	 */
	public class ThemeCss {
		////////////////////////坐标轴/////////////////////////////////////////////
		/**
		 * 坐标轴配色
		 */
		public static function get axisColor():String { return "#E58602"; }
		/**
		 * 坐标轴刻度字体大小
		 */
		public static function get scaleSize():int { return 12; }
		///////////////////////窗口背景////////////////////////////////////////////////
		/**
		 * 窗口背景
		 */
		public static function get bgColor():String { return "#ffffff"; }
		/**
		 * 窗口内边距
		 */
		public static function get bgPaddding():String { return "0px 0px 0px 0px"; }
		////////////////////////////提示窗///////////////////////////////////////////////
		/**
		 * 提示窗圆角
		 */
		public static function get tipRounded():int { return 6; }
		/**
		 * 提示窗字体粗细
		 */
		public static function get tipStroke():int { return 12; }
		/**
		 * 提示线粗细
		 */
		public static function get tipLineStroke():int { return 1; }
		/**
		 * 提示窗字体颜色
		 */
		public static function get tipColor():String { return "#808080"; }
		/**
		 * 提示窗背景色
		 */
		public static function get tipBgColor():String { return "#ffffff"; }
		/**
		 * 提示窗宽度
		 */
		public static function get tipWindowW():int { return 40; }
		/**
		 * 提示窗高度
		 */
		public static function get tipWindowH():int { return 30; }
		/**
		 * 提示窗边框宽度
		 */
		public static function get tipWindowBorder():int { return 2; }
		/**
		 * 提示窗透明度
		 */
		public static function get tipWindowAlpha():Number { return 0.9; }
		////////////////////////////曲线绘制样式///////////////////////////////////////////////
		/**
		 * 线条宽度
		 */
		public static function get lineStroke():int { return 2; }
		/**
		 * 线条配色
		 */
		public static function get lineColor():uint { return RandomColor.pseudoRandomColor(); }
		////////////////////////////数据点绘制样式///////////////////////////////////////////////
		/**
		 * 数据点大小
		 */
		public static function get pointStroke():int { return 3; }
		/**
		 * 数据超标后的报警色
		 */
		public static function get alarmColor():uint { return 0xff0000; }
		////////////////////////////菜单样式///////////////////////////////////////////////
		/**
		 * 菜单背景色
		 */
		public static function get menuBgColor():uint { return 0xf9f9f9; }
		/**
		 * 菜单边框样式
		 */
		public static function get menuBorderCss():String { return "1px 0 1px 0 #000000"; }
		/**
		 * 菜单高度
		 */
		public static function get menuHeight():int { return 25; }
		////////////////////////////框选框样式///////////////////////////////////////////////
		/**
		 * 框选框颜色
		 */
		public static function get dragRectColor():uint { return 0x04A3ED; }
		/**
		 * 边框宽度
		 */
		public static function get dragRectBorderStroke():int { return 3; }
	}

}