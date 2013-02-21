package chart.series.line 
{
	import chart.series.BaseLine;
	import chart.series.BasePoint;
	
	/**
	 * 简化部分功能，可扩展
	 * @author 
	 */
	public class SolidLine extends BaseLine
	{
		public function SolidLine(json:Object) {
			super(json);
		}
		
		/**
		 * 画实线
		 */
		override protected function drawLine():void {
			super.drawLine();
			var pointOne:Boolean = true;
			for (var i:int = 0; i < numChildren; i++ ) {
				if (getChildAt(i) is BasePoint) {
					var element:BasePoint = getChildAt(i) as BasePoint;
					if (pointOne) {
						graphics.moveTo(element.x, element.y);
						pointOne = false;
					} else {
						graphics.lineTo(element.x, element.y);
					}
				}
			}
		}
	}

}