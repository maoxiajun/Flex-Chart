package chart.series.line 
{
	import chart.BaseGraphic;
	/**
	 * 线工厂
	 * @author maoxiajun
	 */
	public class LineFactory 
	{
		/**
		 * 生成线
		 * @return
		 */
		public static function createLine(type:String, json:Object = null):BaseGraphic {
			var line:BaseGraphic = null;
			switch (type) {
				//case 'dashLine': 
				//	line = new DashLine(json); break;
				case 'solid':
					line = new SolidLine(json); break;
			}
			return line;
		}
	}

}