package util
{
	import flash.net.LocalConnection;
	/**
	 * 对象工具类，用于合并对象
	 * @author ...
	 */
	public final class ObjectUtil 
	{
		/**
		 * from复制至to，to中有属性值则不覆盖
		 * @param	to
		 * @param	from
		 * @return
		 */
		public static function merge(to:Object, from:Object):Object {
			if (to == null) {
				to = { };
			}
			for (var prop:String in from) {
				if ( to[prop] == undefined ) {
					to[prop] = from[prop];
				}
			}
			return to;
		}
		
		/**
		 * from与to合并，from中属性覆盖to中属性
		 * @param	to
		 * @param	from
		 * @return
		 */
		public static function mergeOverride(to:Object, from:Object):Object {
			if (to == null) {
				to = { };
			}
			for (var prop:String in from) {
				to[prop] = from[prop];
			}
			return to;
		}
		
		/**
		 * 强制垃圾回收，释放内存
		 */
		public static function gc():void {
			try {
				new LocalConnection().connect("foo");
				new LocalConnection().connect("foo");
			} catch (e:*) { }
		}
	}

}