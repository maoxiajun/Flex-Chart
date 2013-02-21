package stages.axis.label 
{
	/**
	 * 标签类工厂
	 * @author maoxiajun
	 */
	public class LabelFactory 
	{
		/**
		 * 生成坐标轴标签
		 * @param	type
		 * @param	json
		 * @return
		 */
		public static function createLabel(type:String, json:Object=null):BaseLabel {
			var _txtFld:BaseLabel;
			switch (type) {
				case 'xaxis':
					_txtFld = new XAxisLabel(json);
					break;
				case 'yaxisleft':
					break;
				case 'yaxisright':
					break;
			}
			return _txtFld;
		}
	}

}