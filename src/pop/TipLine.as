package pop 
{
	import chart.series.BasePoint;
	import coords.ScreenCoordsBase;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * 数据点提示线
	 * @author maoxiajun
	 */
	public class TipLine extends Resizable
	{
		//private var _color:uint;
		//private var _stroke:int;
		
		private var hLine:HLine;
		private var vLine:VLine;
		
		public function TipLine(json:Object) 
		{
			var style:Object = {
				color: ThemeCss.tipBgColor,
				stroke: ThemeCss.tipLineStroke,
				type: 'solid',
				alpha: 0.8
			};
			//var props:Object = ObjectUtil.merge(json, style);
			//_color = ParseUtil.toColor(props.color);
			//_stroke = props.stroke;
			addHVLine(ObjectUtil.merge(json, style));
		}
		
		/**
		 * 添加提示线
		 * @param	json
		 */
		private function addHVLine(json:Object):void {
			hLine = new HLine(json);
			addChild(hLine);
			vLine = new VLine(json);
			addChild(vLine);
		}
		
		/**
		 * 吸附最近点
		 * @param	pt
		 */
		public function closestPoint(pt:BasePoint, coord:ScreenCoordsBase):void {
			if (pt != null) {
				hLine.limit(pt.y);//标示线原意是用于数据超标提示，所以设置显示位置时采用limit函数名
				vLine.limit(pt.x);
			} else {
				hLine.limit(NaN);
				vLine.limit(NaN);
			}
			resize(coord);
		}
		
		/**
		 * 重绘
		 * @param	coord
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number=NaN, range:Number=NaN):void {
			hLine.resize(coord);
			vLine.resize(coord);
		}
		
		/**
		 * gc
		 */
		override public function destroy():void {
			super.destroy();
			hLine.destroy();
			hLine = null;
			vLine.destroy();
			vLine = null;
		}
	}

}