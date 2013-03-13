package chart.series.point 
{
	import chart.series.BasePoint;
	import coords.ScreenCoordsBase;
	/**
	 * 折线中的数据点集合
	 * @author maoxiajun
	 */
	public class PointCollection {
		private var _points:Array;
		
		public function PointCollection() {
			_points = [];
		}
		
		/**
		 * 添加点
		 * @param	pt
		 */
		public function addPoint(pt:BasePoint):void {
			_points.push(pt);
		}
		
		/**
		 * 集合中点个数
		 */
		public function get length():int {
			return _points.length;
		}
		
		/**
		 * 点集
		 */
		public function get points():Array {
			return _points;
		}
		
		/**
		 * 窗口重绘
		 * @param	coord
		 */
		public function resize(coord:ScreenCoordsBase, count:int, begin:Number, range:Number):void {
			for (var i:int = 0; i < _points.length; i++ ) {
				var pt:BasePoint = _points[i] as BasePoint;
				pt.resize(coord, count, begin, range);
			}
			/*for each(var pt:BaseTip in _points) {
				pt.resize(coord);
			}*/
		}
		
		/**
		 * gc
		 */
		public function destroy():void {
			for each(var pt:BasePoint in _points) {
				pt.destroy();
			}
			_points = null;
		}
	}

}