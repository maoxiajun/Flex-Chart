package util 
{
	/**
	 * 处理浮点数
	 * @author maoxiajun
	 */
	public final class NumberUtil 
	{
		/**
		 * 获取浮点数的位数，返回包含两个元素的数组，第一个元素为
		 * 小数点前有多少位，第二个元素为小数点后第一个不为0的数字所在的小数位
		 * @param	number
		 * @return
		 */
		public static function getPrecision(number:Number):Array {
			if (isNaN(number)) {
				return [0, 1];
			}
			var num:Array = number.toString().split(".");
			var precision:Array = [];
			if (num[0] == "0") {
				precision.push(0);
			} else {
				precision.push(num[0].length);
			}
			var len:int = 0;
			if (num[1]) {
				var numDecimal:String = num[1];
				while (numDecimal.length) {
					if (numDecimal.charAt(len) == "0") {
						len ++;
					} else {
						//trace("break while loop");
						break;
					}
				}
			}
			precision.push(len+1);
			return precision;
		}
		
		/**
		 * 获取最大值
		 * @param	array
		 * @return
		 */
		public static function getMaxValue(array:Array):Number {
			var max:Number = Number.MIN_VALUE;
			
			for (var i:int = 0; i < array.length; i++ ) {
				max = Math.max(max, array[i]);
			}
			return max;
		}
		
		/**
		 * 获取最小值
		 * @param	array
		 * @return
		 */
		public static function getMinValue(array:Array):Number {
			var min:Number = Number.MAX_VALUE;
			
			for (var i:int = 0; i < array.length; i++ ) {
				min = Math.min(min, array[i]);
			}
			return min;
		}
		
		/**
		 * 指数函数, exponent positive
		 * @return
		 */
		public static function expPos(origin:Number=10, capacity:int=0):Number {
			if (capacity == 0) {
				return NaN;
			}
			//var precision:int = capacity;
			while (capacity > 0) {
				origin = origin * 10;
				capacity --;
			}
			//return ParseUtil.toNumberFixed(origin, precision);
			return origin;
		}
		
		/**
		 * 负指数函数, exponent negative
		 * @return
		 */
		public static function expNeg(origin:Number=1, capacity:int=0):Number {
			if (capacity == 0) {
				return NaN;
			}
			//var precision:int = capacity;
			while (capacity > 0) {
				origin = origin / 10;
				capacity --;
			}
			//return ParseUtil.toNumberFixed(origin, precision);
			return origin;
		}
	}

}