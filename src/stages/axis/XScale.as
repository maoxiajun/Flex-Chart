package stages.axis 
{
	import coords.ScreenCoordsBase;
	import flash.text.TextFormat;
	import stages.axis.label.BaseLabel;
	import stages.axis.label.LabelFactory;
	import theme.ThemeConst;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * X坐标轴刻度
	 * @author maoxiajun
	 */
	public class XScale extends Resizable
	{
		private var _count:int;
		private var _color:uint;
		private var _data:Array;
		private var _rotation:*;
		
		public function XScale(json:Object) 
		{
			var style:Object = {
				count: ThemeConst.xAxisCount,
				color: ThemeCss.axisColor,
				data: undefined,
				rotation: 'vertical'
			};
			var props:Object = ObjectUtil.merge(json, style);
			_count = props.count;
			_color = ParseUtil.toColor(props.color);
			_data = props.data;
			_rotation = props.rotation;
		}
		
		/**
		 * 窗口重绘
		 */
		override public function resize(coord:ScreenCoordsBase, begin:Number=0, range:Number=0):void {
			graphics.clear();//不直接调用destroy方法，防止更改destroy方法导致的问题
			while (numChildren > 0) {
				removeChildAt(0);
			}
			var txtFmt:TextFormat = new TextFormat();
			txtFmt.color = _color;
			txtFmt.size = ThemeCss.scaleSize;
			//graphics.beginFill(_color);
			for (var i:int = 0; i < _count; i++ ) {
				var txt:BaseLabel = LabelFactory.createLabel('xaxis');
				txt.text = _data[i];
				txt.setTextFormat(txtFmt);//设置文本内容之后设置TextFormat，否则失效
				txt.x = coord.getXFromPos(i, _count);// - txt.textWidth / 2;
				txt.y = coord.heightYTop + coord.axisHeight + ThemeConst.scaleLength;// + 6;
				txt.rotate(_rotation);
				addChild(txt);
			}
			//graphics.endFill();
		}
		
		/**
		 * gc
		 */
		override public function destroy():void {
			graphics.clear();
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}
	}

}