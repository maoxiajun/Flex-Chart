package stages.axis 
{
	import coords.ScreenCoordsBase;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import theme.ThemeConst;
	import theme.ThemeCss;
	import util.NumberUtil;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * Y轴刻度标注
	 * @author maoxiajun
	 */
	public class YScale extends Resizable
	{
		private var _count:int;//scale count
		private var _topLimit:Number;
		private var _bottomLimit:Number;
		private var _steps:Number;
		private var _color:uint;
		
		private var _positions:Array;//Y轴刻度
		
		public function YScale(json:Object) {
			var style:Object = {
				topLimit: Number.NaN,
				bottomLimit: Number.NaN,
				count: ThemeConst.yAxisCount,//显示的刻度个数，默认为10
				//steps: Number.NaN,
				color: ThemeCss.axisColor
			}
			var props:Object = ObjectUtil.merge(json ? json : {}, style);
			_topLimit = props.topLimit;
			_bottomLimit = props.bottomLimit;
			//_steps = props.steps;
			_count = props.count;//默认采用10等分y轴
			_color = ParseUtil.toColor(props.color);
			buildYScale(_topLimit, _bottomLimit);//创建Y轴刻度
		}
		
		/**
		 * 构建Y坐标轴，输入数据上下限(主要用于类似实时监测类数据的预警)，
		 * 依据上下限数据设定Y轴的步进，上下限数据可用实际数据的最高、最低值代替
		 */
		public function buildYScale(topLimit:Number, bottomLimit:Number):void {
			var tween:Number = Math.abs(topLimit - bottomLimit);
			
			var percent:int = _count * 0.6;
			//将上下限所占的纵坐标比例默认设定为60%
			//var total:Number = tween * 5 / 3;
			//获取上下限之间的数值步进，例如0.1、10等，即Y轴以此为单位刻画Y轴刻度
			var precision:Array = NumberUtil.getPrecision(tween / percent);
			
			if(precision[0] == 0) {
				//默认采用十等分
				_steps = NumberUtil.expNeg(Math.round(NumberUtil.expPos(tween / percent, precision[1])), precision[1]);
				//trace(tween / percent+","+precision[1]+","+_steps);
			} else if (precision[0] == 1) {
				_steps = Math.round(tween / percent * 10) / 10;
			} else if (precision[0] == 2) {
				_steps = Math.round(tween / percent / 10) * 10;
			} else if (precision[0] > 2) {
				_steps = NumberUtil.expPos(Math.round(NumberUtil.expNeg(tween / percent, precision[1])), precision[1]);
			}
			//_steps = ParseUtil.toNumberFixed(_steps, precision[1]);
			
			var begin:Number = NumberUtil.expNeg(
				Math.ceil(NumberUtil.expPos(
				ParseUtil.toNumberFixed(bottomLimit - 2 * _steps, precision[1]), precision[1])), precision[1]);
			var end:Number = NumberUtil.expNeg(
				Math.floor(NumberUtil.expPos(
				ParseUtil.toNumberFixed(topLimit - 2 * _steps, precision[1]), precision[1])), precision[1]);
			
			//判断是否异号，异号则从0开始
			if (Math.abs(begin + bottomLimit) < Math.abs(bottomLimit)) {
				begin = 0;
			}
			
			_positions = [];
			for (var i:int = 0; i < _count; i++ ) {
				_positions.push(begin + i * _steps);
				//ActionScript的浮点数处理很诡异，无法精确控制小数位，所以运算前后必须强制定义精度
				_positions[i] = ParseUtil.toNumberFixed(_positions[i], precision[1]);
			}
		}
		
		/**
		 * 报警上限
		 */
		public function get topLimit():Number {
			return _topLimit;
		}
		
		/**
		 * 报警下限
		 */
		public function get bottomLimit():Number {
			return _bottomLimit;
		}
		
		/**
		 * 返回Y轴刻度标注的位置
		 */
		public function get positions():Array {
			if (_positions) {
				return _positions;
			}
			return undefined;
		}
		
		/**
		 * 返回Y轴刻度个数
		 */
		public function get count():int {
			return _positions.length;
		}
		
		/**
		 * 窗口重绘
		 * @param	coord
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number=NaN, range:Number=NaN):void {
			var step:Number = coord.axisHeight / _count;
			/*var offset:int = 0;
			if (interval != Math.ceil(coord.axisHeight / _count)) {
				offset = 1;
			}*/
			var txtFmt:TextFormat = new TextFormat();
			txtFmt.color = _color;
			txtFmt.size = ThemeCss.scaleSize;
			graphics.clear();
			while (numChildren > 0) {
				removeChildAt(0);
			}
			graphics.beginFill(_color);
			for (var i:int = 0; i < _count; i++ ) {
				//graphics.drawRect(coord.widthXLeft - 2, coord.heightYTop + i * step, 2, 2);
				graphics.drawRect(coord.widthXLeft - ThemeConst.scaleLength, 
					coord.getYFromPos(i, _count), ThemeConst.scaleLength, ThemeConst.axisWidth);
				var txt:TextField = new TextField();
				txt.text = _positions[i];
				txt.setTextFormat(txtFmt);//设置文本内容之后设置TextFormat，否则失效
				txt.x = coord.widthXLeft - 6 - txt.textWidth - ThemeConst.scaleLength;
				txt.y = coord.getYFromPos(i, _count) - txt.textHeight / 2;
				txt.antiAliasType = AntiAliasType.ADVANCED;
				addChild(txt);
				//trace(coord.axisHeight + "," + i*step);
			}
			graphics.endFill();
		}
		
		/**
		 * gc
		 */
		override public function destroy():void {
			graphics.clear();
			while (numChildren > 0) {
				removeChildAt(0);
			}
			_positions = null;
		}
	}

}