package dataloader 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * 定时器
	 * @author maoxiajun
	 */
	public class TimeInterval
	{
		private var _timer:Timer;//定时器
		private var _delay:int;//时间间隔
		private var _closure:Function;//回调函数
		
		public function TimeInterval(closure:Function, delay:int=5000) {
			//_timer = new Timer(delay ? delay : 5000);
			_delay = delay;
			_closure = closure != null ? closure : function():void { return; };
		}
		
		/**
		 * 开始计时
		 * @param delay 时间间隔，以毫秒为单位
		 */
		public function start(delay:int=0):void {
			stop();
			_timer = new Timer(delay != 0 ? delay : _delay);
			_timer.addEventListener(TimerEvent.TIMER, _closure);
			_timer.start();
		}
		
		/**
		 * 停止计时
		 */
		public function stop():void {
			if (_timer != null) {
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, _closure);
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