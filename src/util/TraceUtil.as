package util
{
	import com.adobe.serialization.json.JSON;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * 跟踪调试输出信息
	 * @author ...
	 */
	public final class TraceUtil 
	{
		/**
		 * 追踪
		 * @param	obj
		 */
		public static function ace(obj:Object):void {
			if (obj == null) {
				FlashConnect.trace('对象为空');
			} else {
				FlashConnect.trace(obj.toString());
			}
		}
		
		/**
		 * 带名称追踪，例如（‘值’，value）
		 * @param	...optionalArgs
		 */
		public static function aces(...optionalArgs):void {
			var tmp:Array = [];
			for each(var obj:Object in optionalArgs) {
				if (obj == null) {
					tmp.push('对象为空');
				} else {
					tmp.push(obj.toString());
				}
			}
			
			FlashConnect.trace(tmp.join(':'));
		}
		
		/**
		 * 追踪json数据串
		 * @param	json
		 */
		public static function aceJson(json:Object):void {
			TraceUtil.ace(JSON.encode(json));
		}
	}

}