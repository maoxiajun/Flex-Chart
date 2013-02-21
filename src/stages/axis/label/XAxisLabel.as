package stages.axis.label 
{
	import theme.ThemeConst;
	/**
	 * X轴坐标标签
	 * @author maoxiajun
	 */
	public class XAxisLabel extends BaseLabel
	{
		
		public function XAxisLabel(json:Object) {
			super(json);
		}
		
		/**
		 * 旋转及位置偏移补偿控制
		 * @param	rotation
		 */
		override protected function rotateAndAlign(rotationNum:Number):void {
			var radian:Number = rotationNum * Math.PI / 180;
			x -= (textWidth * Math.cos(radian) - textHeight * Math.sin(radian)) / 2;
			
			if (rotationNum <= 90) {
				y += ThemeConst.scaleLengthOffset;
				
			} else if (rotationNum <= 180) {
				y += ThemeConst.scaleLengthOffset - textHeight * Math.sin(radian);
				
			} else if (rotationNum <= 270) {
				y += ThemeConst.scaleLengthOffset - (textWidth * Math.sin(radian) + textHeight * Math.cos(radian));
				
			} else {
				y += ThemeConst.scaleLengthOffset - textWidth * Math.sin(radian);
				
			}
			rotationZ = rotationNum;
		}
	}

}