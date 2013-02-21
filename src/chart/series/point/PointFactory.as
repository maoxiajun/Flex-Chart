package chart.series.point 
{
	import theme.RandomColor;
	import theme.ThemeCss;
	/**
	 * 数据点生成类
	 * @author maoxiajun
	 */
	public class PointFactory 
	{
		/**
		 * 生成数据点
		 * @return
		 */
		public static function createPoint(json:Object):PointCollection {
			var points:PointCollection = new PointCollection();
			if (json['data']) {
				var data:Array = json['data'] as Array;
				var color:uint = json['color'] ? json['color'] : RandomColor.pseudoRandomColor();
				for (var i:int = 0; i < data.length; i++ ) {
					var pt:Point = null, limits:Object = json['limits'];
					if (data[i] > limits.topLimit || data[i] < limits.bottomLimit) {
						pt = new Point( { x:i, y:data[i], color:ThemeCss.alarmColor, stroke:ThemeCss.pointStroke + 2 } );
					} else {
						pt = new Point( { x:i, y:data[i], color:color } );
					}
					points.addPoint(pt);
				}
			}
			return points;
		}
	}

}