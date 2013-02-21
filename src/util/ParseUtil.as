package util 
{
	import com.adobe.utils.StringUtil;
	/**
	 * 类型转换
	 * @author ...
	 */
	public final class ParseUtil 
	{
		public static function toPixel(txt:String):int {
			try {
				txt = StringUtil.remove(txt, "px");
				return new int(txt);
				/*if (int(txt) == 0) {
					return 0;
				} else {
					return new int(txt);
				}*/
			} catch (e:*) {}
			return 1;
		}
		
		/**
		 * 必须以#开头，返回十六进制数字
		 * @param	txt
		 * @return
		 */
		public static function toColor(txt:*):uint {
			try {
				if (txt is String && txt.substr(0, 1) == "#") {
					txt = txt.substring(1);
					if (txt.length != 6) {
						txt += "000000";
						txt = txt.substr(0, 6);
					}
					return new uint("0x"+txt);
				} else if (txt is uint) {
					return txt;
				}
			} catch (e:*) {}
			return 0x000000;
		}
		
		/**
		 * 转换精度
		 * @param	num
		 * @param	fix
		 * @return
		 */
		public static function toNumberFixed(num:Number, fix:int = 0):Number {
			try {
				var txt:String = num.toFixed(fix);
				return new Number(txt);
			} catch (e:*) { }
			return num;
		}
	}

}