package chart.series.line 
{
	import chart.series.BaseLine;
	import chart.series.BasePoint;
	
	/**
	 * 简化部分功能，可扩展
	 * @author 
	 */
	public class SolidLine extends BaseLine {
		
		public function SolidLine(json:Object) {
			super(json);
		}
		
		/**
		 * 画实线
		 */
		override protected function drawLine():void {
			graphics.clear();
			graphics.lineStyle(_lineStroke, _color);
			
			var pointOne:Boolean = true;
			var item:BasePoint = null;
			for (var i:int = 0; i < numChildren; i++ ) {
				if (getChildAt(i) is BasePoint) {
					item = getChildAt(i) as BasePoint;
					if (pointOne) {
						graphics.moveTo(item.x, item.y);
						pointOne = false;
					} else {
						graphics.lineTo(item.x, item.y);
					}
				}
			}
			item = null;
		}
		
	}

}