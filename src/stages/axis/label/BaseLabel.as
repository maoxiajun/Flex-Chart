package stages.axis.label 
{
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	/**
	 * 坐标刻度标签基类
	 * @author maoxiajun
	 */
	public class BaseLabel extends TextField
	{
		/**
		 * 旋转角度
		 */
		private var _rotation:Number;
		
		public function BaseLabel(json:Object) {
			_rotation = 0;
			antiAliasType = AntiAliasType.ADVANCED;
		}
		
		/**
		 * 标签旋转
		 * @param	rotation
		 */
		public function rotate(rotationNum:*):void {
			if (rotationNum is String) {
				switch (rotationNum as String) {
					case 'vertical':
						_rotation = 270;
						break;
					case 'horizontal':
						_rotation = 0;
						break;
				}
			} else if (rotationNum is Number) {
				_rotation = rotation % 360;
				if (_rotation < 0) {
					_rotation += 360;
				}
			}
			rotateAndAlign(_rotation);
		}
		
		/**
		 * 旋转及位置补偿控制函数
		 * @param	rotation
		 */
		protected function rotateAndAlign(rotationNum:Number):void { }
	}

}