package chart 
{
	import chart.series.line.LineFactory;
	/**
	 * 工厂类
	 * @author 
	 */
	public class GraphicFactory 
	{
		/**
		 * 创建图表元素
		 * @param	json
		 * @return
		 */
		public static function buildChart(json:Object):SpriteCollection {
			var sprites:SpriteCollection = new SpriteCollection();
			var jsonChart:Object = json['chart'];
			
			var type:String = jsonChart['type'] ? jsonChart['type'] as String : 'line';
			//此处只能画一种类型的图表
			//但实际应用中可能在一个图幅中要显示雷达图、折线图等多种类型的图表
			//所以此处待完善，应该是循环内套嵌图表类型
			switch(type) {
				case 'line':
					var chartData:Array = jsonChart['chartData'] as Array;
					for (var i:int = 0; i < chartData.length; i++ ) {
						chartData[i]['index'] = i + "," + chartData.length;
						sprites.addDynamic(LineFactory.createLine('solid', chartData[i]));
					}
					/*for each(var data:Object in chartData['chartData']) {
						var yscale:Object = data['yscale'];
						yscale['count'] = json['yaxis'] ? json['yaxis']['count'] : undefined;
						if (yscale['topLimit'] == undefined) {
							yscale['topLimit'] = NumberUtil.getMaxValue(data['data']);
						}
						if (yscale['bottomLimit'] == undefined) {
							yscale['bottomLimit'] = NumberUtil.getMinValue(data['data']);
						}
						var tmpScale:YScale = new YScale(yscale);
						sprites.addCached(tmpScale);//添加Y轴刻度
						
						var xscale:Object = data['xscale'];
						xscale['count'] = json['xaxis'] ? json['xaxis']['count'] : undefined;
						sprites.addCached(new XScale(data['xscale']));//添加X轴刻度
						
						data['data']['top'] = tmpScale.positions ? NumberUtil.getMaxValue(tmpScale.positions) : undefined;
						data['data']['bottom'] = tmpScale.positions ? NumberUtil.getMinValue(tmpScale.positions) : undefined;
						sprites.addDynamic(new Line(data['data']));//添加折线
					}*/
					break;
				default:
					break;
			}
			
			return sprites;
		}
		
	}

}