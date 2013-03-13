package events 
{
	import coords.ScreenCoordsBase;
	import flash.events.MouseEvent;
	/**
	 * 框选事件
	 * @author maoxiajun
	 */
	public class DragEvent extends MouseEvent
	{
		private var _screenCoords:ScreenCoordsBase;
		
		public static const DRAG_DRAW:String = "dragDraw";
		
		public function DragEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		public function get screenCoords():ScreenCoordsBase {
			return _screenCoords;
		}
		
		public function set screenCoords(screenCoords:ScreenCoordsBase):void {
			_screenCoords = screenCoords;
		}
		
		/**
		 * 复制自身，继承event所需
		 * @return
		 */
		override public function clone():MouseEvent {
			return new DragEvent(type, bubbles, cancelable);
		}
	}

}