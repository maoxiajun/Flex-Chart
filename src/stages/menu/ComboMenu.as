package stages.menu 
{
	import com.bit101.components.ComboBox;
	import coords.ScreenCoordsBase;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import i18n.Message;
	import i18n.MessageNode;
	import stages.toolbar.ImageButton;
	import theme.ThemeConst;
	import util.ObjectUtil;
	/**
	 * 下拉框菜单
	 * @author maoxiajun
	 */
	public class ComboMenu extends BaseMenu {
		private var _combo:ComboBox;
		private var _list:Array;
		private var _type:String;
		private var _milisec:int;
		private var _reset:ImageButton;
		
		private static const SECOND:String = MessageNode.SECOND;
		private static const MINUTE:String = MessageNode.MINUTE;
		private static const HOUR:String = MessageNode.HOUR;
		private static const STOP:String = MessageNode.STOP;
		
		public function ComboMenu(json:Object) {
			super(json);
			var style:Object = {
				interval: ThemeConst.timeIntervals,
				type: SECOND
			};
			var props:Object = ObjectUtil.merge(json['combo'], style);
			_list = props.interval;
			_type = props.type;
			//_callback = function():void { return; };
			//添加下拉菜单及重置按钮
			addCombo();
			addImageButton();
		}
		
		/**
		 * 添加combobox
		 */
		private function addCombo():void {
			_combo = new ComboBox(this, 0, 0);
			_combo.addEventListener(Event.SELECT, selectHandler);
			switch (_type) {
				case SECOND:
					_milisec = 1000;
					break;
				case MINUTE:
					_milisec = 1000 * 60;
					break;
				case HOUR:
					_milisec = 1000 * 60 * 60;
					break;
			}
			_combo.defaultLabel = _list[0] == -1 ? Message.getMsg(STOP) : _list[0] + Message.getMsg(_type);
			_combo.numVisibleItems = _list.length;
			for each(var num:int in _list) {
				_combo.addItem(num == -1 ? Message.getMsg(STOP) : num + Message.getMsg(_type));
			}
		}
		
		/**
		 * 添加重置按钮
		 */
		private function addImageButton():void {
			_reset = new ImageButton(this, 0, 0);
			_reset.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		/**
		 * 添加鼠标点击事件
		 * @param	evt
		 */
		private function clickHandler(evt:MouseEvent):void {
			for each (var handler:Array in _callbackList) {
				if (handler[0] == "click") {
					//所有click事件都会被触发
					var time:int = getTime();
					handler[1](time == -1 ? -1 : time * _milisec);
				}
			}
		}
		
		/**
		 * combo点击事件处理函数
		 * @param	evt
		 */
		private function selectHandler(evt:Event):void {
			//_callback.apply(null, [5]);
			for each (var handler:Array in _callbackList) {
				if (handler[0] == "select") {
					//所有select事件都会被触发
					var time:int = getTime();
					handler[1].call(null, time == -1 ? -1 : time * _milisec);
				}
			}
		}
		
		/**
		 * 获取下拉框中被选中的值
		 * @return
		 */
		private function getTime():int {
			var time:int = -1;
			if (_combo.selectedIndex > -1 && _combo.selectedIndex < _list.length + 1) {
				time = _list[_combo.selectedIndex];
			}
			return time;
		}
		
		/**
		 * 窗口重绘
		 * @param	coord
		 * @param	begin
		 * @param	range
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number = NaN, range:Number = NaN):void {
			super.resize(coord, begin, range);
			setPosition(coord);
		}
		
		/**
		 * 添加子控件
		 */
		private function setPosition(coord:ScreenCoordsBase):void {
			_combo.setSize(100, 20);
			_combo.move(coord.stageWidth - _combo.width, (_height - _combo.height) / 2);
			_reset.move(coord.stageWidth - _combo.width - _reset.width - 5, (_height - _reset.height) / 2);
		}
		
		/**
		 * gc
		 */
		override public function destroy():void {
			super.destroy();
			_combo.removeEventListener(Event.SELECT, selectHandler);
			_combo = null;
			_reset.removeEventListener(MouseEvent.CLICK, clickHandler);
			_reset.destroy();
			_reset = null;
			_list = null;
		}
	}

}