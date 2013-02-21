package  
{
	import coords.ScreenCoordsBase;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author maoxiajun
	 */
	public class Resizable extends Sprite 
	{
		/**
		 * 定位并重绘，用于根据数值确定坐标的情形
		 */
		public function resize(coord:ScreenCoordsBase, begin:Number=NaN, range:Number=NaN):void {}
		
		/**
		 * gc
		 */
		public function destroy():void {
			graphics.clear();
			filters = [];
			while (numChildren > 0) {
				removeChildAt(0);
			}
		};
	}

}