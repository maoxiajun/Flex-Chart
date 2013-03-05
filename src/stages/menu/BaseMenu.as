package stages.menu 
{
	import coords.ScreenCoordsBase;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * 菜单
	 * @author maoxiajun
	 */
	public class BaseMenu extends Resizable {
		private var _borderColor:uint = 0xff0000;
		private var _borderWitdth:int = 1;
		private var _bgColor:uint = 0xff0000;
		
		public function BaseMenu(json:Object) {
			var style:Object = {
				border: ThemeCss.menuBorderCss,//"0 0 1px 0 #000000"
				bgColor: ThemeCss.menuBgColor
			};
			var props:Object = ObjectUtil.merge(json, style);
		}
		
		/**
		 * 绘制菜单
		 * @param	coord
		 * @param	begin
		 * @param	range
		 */
		override public function resize(coord:ScreenCoordsBase, begin:Number = NaN, range:Number = NaN):void {
			graphics.clear();
			graphics.beginFill(_bgColor);
			graphics.lineStyle(_borderWitdth, _borderColor);
			graphics.drawRect(0, 0, 100,  10);
			graphics.endFill();
		}
		
	}
	
}