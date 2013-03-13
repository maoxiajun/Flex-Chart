package dataloader 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import util.TraceUtil;
	/**
	 * 定时器
	 * @author maoxiajun
	 */
	public class TimeInterval {
		private var _timer:Timer;//定时器
		private var _delay:int;//时间间隔
		private var _closure:Function;//回调函数
		
		public function TimeInterval(closure:Function, delay:int=5000) {
			//_timer = new Timer(delay ? delay : 5000);
			_delay = delay;
			_closure = closure != null ? closure : function():void { return; };
			//_closure.apply(null, [5]);
		}
		
		/**
		 * 开始计时
		 * @param delay 时间间隔，以毫秒为单位，输入-1则停止计时
		 */
		public function start(delay:int = 0):void {
			//TraceUtil.ace(delay);
			stop();
			if (delay == -1) {
				return;//方便菜单中的匿名函数调用，免除需要start，stop两个函数的切换
			}
			_timer = new Timer(delay != 0 ? delay : _delay);
			_timer.addEventListener(TimerEvent.TIMER, callBack);
			_timer.start();
		}
		
		/**
		 * 测试Function.apply()
		 * @param	evt
		 */
		private function callBack(evt:TimerEvent):void {
			_closure.apply(null, null);//[{haha:"heihei"}]
			//_closure.call(null);//{haha:"heihei"}与apply调用函数时传递参数方式不同
		}
		
		/**
		 * 停止计时
		 */
		public function stop():void {
			if (_timer != null) {
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, callBack);
				_timer = null;
			}
		}
		
		/**
		 * gc
		 */
		public function destroy():void {
			stop();
			_timer = null;
			_closure = null;
		}
	}

}