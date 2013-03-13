package i18n 
{
	/**
	 * 国际化消息
	 * @author maoxiajun
	 */
	public class Message
	{
		private static var _xml:XML = <messages>
			<message region={MessageNodeValue.REGION}>
			<{MessageNode.SECOND} value={MessageNodeValue.SECOND}/>
			<{MessageNode.MINUTE} value={MessageNodeValue.MINUTE}/>
			<{MessageNode.HOUR} value={MessageNodeValue.HOUR}/>
			<{MessageNode.STOP} value={MessageNodeValue.STOP}/>
			</message></messages>;
		
		/**
		 * 获取键值
		 * @param	key
		 * @return
		 */
		public static function getMsg(key:String):String {
			return _xml.message.(@region == MessageNodeValue.REGION)[key].@value;
		}
	}

}