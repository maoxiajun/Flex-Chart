package theme 
{
	/**
	 * 生成随机颜色
	 * @author maoxiajun
	 */
	public final class RandomColor 
	{
		/**
		 * 返回随机颜色
		 * @return
		 */
		public static function randomColor():uint {
			//var color:String = (Math.random() * 0xffffff as uint).toString(16);
			//trace(color);
			//return "#" + color;
			return Math.random() * 0xffffff;
		}
		
		/**
		 * 返回伪随机颜色
		 * @return
		 */
		public static function pseudoRandomColor(index:int = -1):uint {
			var color:Object = {
				"0": 0x4F6CFF,
				"1": 0x10C988,
				"2": 0x3EC910,
				"3": 0xD8CB13,
				"4": 0xCE829C,
				"5": 0x7D4DD6,
				"6": 0x55BED6,
				"7": 0xf8811E
			};
			if (index > 7 || index < 0) {
				return color[Math.floor(Math.random() * 10) % 8];
			} else {
				return color[index];
			}
		}
	}

}