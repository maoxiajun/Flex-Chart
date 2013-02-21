package chart 
{
	import chart.series.BasePoint;
	import coords.ScreenCoordsBase;
	import flash.display.Sprite;
	/**
	 * 画区显示对象集合
	 * @author ...
	 */
	public class SpriteCollection
	{
		//private var objCached:Array;//
		private var objDynamic:Array;//
		
		/**
		 * 构造器
		 */
		public function SpriteCollection() {
			//objCached = [];
			objDynamic = [];
		}
		
		/*public function get cached():Array {
			return objCached;
		}*/
		
		public function get dynamics():Array {
			return objDynamic;
		}
		
		/**
		 * 增加
		 * @param	objectSet
		 */
		/*public function addCached(objcache:Resizable):void {
			objCached.push(objcache);
		}*/
		
		/**
		 * 增加
		 * @param	objectSet
		 */
		public function addDynamic(objdyna:BaseGraphic):void {
			objDynamic.push(objdyna);
		}
		
		/**
		 * 获取画区X坐标最小值，此类中存放的为子画区，例如一条曲线，
		 * 此方法在于从所有子曲线中查找X坐标最小值，比较每一个子画区中的X坐标最小值
		 * @return
		 */
		public function get minX():Number {
			var min:Number = Number.MAX_VALUE;
			for each(var obj:BaseGraphic in objDynamic) {
				min = Math.min(min, obj.minX);
			}
			return min;
		}
		
		/**
		 * 获取画区X坐标最大值
		 * @return
		 */
		public function get maxX():Number {
			var max:Number = Number.MIN_VALUE;
			for each(var obj:BaseGraphic in objDynamic) {
				max = Math.max(max, obj.maxX);
			}
			return max;
		}
		
		/**
		 * 查找最近点
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function closest(x:Number, y:Number):Object {
			//简化处理，返回第一个图表对象中的最近点
			return BaseGraphic(objDynamic[0]).closest(x, y);
		}
		
		/**
		 * 画区重绘
		 * @param	coord
		 */
		public function resize(coord:ScreenCoordsBase):void {
			/*for each(var cachedObj:Resizable in objCached) {
				cachedObj.resize(coord);
			}*/
			for each(var dynamicObj:BaseGraphic in objDynamic) {
				dynamicObj.resize(coord);
			}
		}
		
		/**
		 * gc，此集合中存储需要动态绘制的图形对象
		 */
		public function destroy():void {
			//destroyCache();
			destroyDynamic();
		}
		
		/*public function destroyCache():void {
			for each(var obj:Resizable in objCached) {
				obj.destroy();
			}
		}*/
		
		public function destroyDynamic():void {
			for each(var obj:BaseGraphic in objDynamic) {
				obj.destroy();
			}
		}
	}

}