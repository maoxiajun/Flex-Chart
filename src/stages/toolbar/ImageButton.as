package stages.toolbar 
{
	import com.bit101.components.Component;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	/**
	 * 图片按钮
	 * @see pushbutton.as
	 * @author maoxiajun
	 */
	public class ImageButton extends Component
	{
		[Embed(source="../../resource/refresh.png", mimeType="image/png")]
		private var PNG_RESET:Class;
		private var _png:Bitmap;
		//private var _callback:Function;
		
		private var _btnW:int;
		private var _btnH:int;
		
		public function ImageButton(parent:DisplayObjectContainer = null, 
			xpos:Number = 0, ypos:Number = 0, defaultW:int = 0, defaultH:int = 0, defaultHandler:Function = null) {
			
			//首先设置宽高使得初始化组件时已存在默认宽高值
			_btnW = defaultW;
			_btnH = defaultH;
			
			super(parent, xpos, ypos);
			
			if(defaultHandler != null) {
				//addEventListener(MouseEvent.CLICK, defaultHandler);
				//_callback = defaultHandler;
			}
		}
		
		/**
		 * 初始化组件
		 */
		override protected function init():void {
			super.init();
			buttonMode = true;
			useHandCursor = true;
			//setSize(_btnW, _btnH);
		}
		
		/**
		 * 添加子组件
		 */
		override protected function addChildren():void {
			_png = new PNG_RESET() as Bitmap;
			_png.x = 0;//子组件采用的是相对ImageButton自身的坐标系
			_png.y = 0;
			addChild(_png);
			
			_btnW = _btnW == 0 ? _png.width : _btnW;
			_btnH = _btnH == 0 ? _png.height : _btnH;
			setSize(_btnW, _btnH);
			
			//addEventListener(MouseEvent.CLICK, mouseClick);
		}
		
		/**
		 * 鼠标监听事件
		 * @param	evt
		 */
		private function mouseClick(evt:MouseEvent):void {
			//_callback();
		}
		
		/**
		 * 设置鼠标点击事件的响应函数
		 */
		public function set clickHandler(callback:Function):void {
			//_callback = callback;
		}
		
		/**
		 * gc
		 */
		public function destroy():void {
			PNG_RESET = null;
			_png = null;
			//_callback = null;
			//removeEventListener(MouseEvent.CLICK, mouseClick);
		}
	}

}