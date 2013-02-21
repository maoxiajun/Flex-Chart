package chart.series 
{
	import chart.BaseGraphic;
	import chart.series.point.Point;
	import chart.series.point.PointCollection;
	import chart.series.point.PointFactory;
	import coords.ScreenCoordsBase;
	import flash.display.BlendMode;
	import pop.HLine;
	import stages.axis.XScale;
	import stages.axis.YScale;
	import theme.RandomColor;
	import theme.ThemeCss;
	import util.NumberUtil;
	import util.ObjectUtil;
	import util.ParseUtil;
	
	/**
	 * 折线基类
	 * @author maoxiajun
	 */
	public class BaseLine extends BaseGraphic
	{
		//protected var props:Object;//线划显示样式
		protected var _bottom:Number;
		protected var _top:Number;
		protected var _yscale:YScale;
		protected var _xscale:XScale;
		protected var _index:Array;
		protected var _points:PointCollection;
		protected var _limitLines:Array;
		
		public function BaseLine(json:Object) {
			var style:Object = {
				lineWidth: ThemeCss.lineStroke,
				//color: ThemeCss.lineColor,
				axis: 'left',
				index: undefined//表示本条折线是所有要显示的折线中第几条折线
			};
			var props:Object = ObjectUtil.merge(json, style);
			
			_lineWidth = props.lineWidth;
			_index = String(props.index).split(",");
			_color = ParseUtil.toColor(props.color ? props.color : RandomColor.pseudoRandomColor(_index[0]));
			//_colors.push(_color);
			//允许点擦除附近的线划
			blendMode = BlendMode.LAYER;
			addJsonChild(props);
		}
		
		/**
		 * 添加坐标轴刻度
		 * @param json
		 */
		private function addJsonChild(json:Object):void {
			var yscale:Object = json['yscale'];
			var limits:Object = {
				topLimit: yscale['topLimit'],
				bottomLimit: yscale['bottomLimit']
			};
			//var _marks:Array = [];
			_limitLines = [];//初始化标示线容器
			if (yscale['topLimit'] != undefined) {
				buildLimitLine('topLimit', yscale['limitLine']);//_marks.push('top');//构建提示线
			} else {
				yscale['topLimit'] = NumberUtil.getMaxValue(json['data']);
				limits['topLimit'] = Number.MAX_VALUE;
			}
			if (yscale['bottomLimit'] != undefined) {
				buildLimitLine('bottomLimit', yscale['limitLine']);//_marks.push('bottom');//构建提示线
			} else {
				yscale['bottomLimit'] = NumberUtil.getMinValue(json['data']);
				limits['bottomLimit'] = Number.MIN_VALUE;
			}
			_yscale = new YScale(yscale);
			addChild(_yscale);//添加Y轴刻度
			/*for each(var mark:String in _marks) {
				if (mark == 'top') {
					buildLimitLine(limits.topLimit, yscale['limitLine']);
				} else if (mark == 'bottom') {
					buildLimitLine(limits.bottomLimit, yscale['limitLine']);
				}
			}*/
			
			_xscale = new XScale(json['xscale']);
			addChild(_xscale);//添加X轴刻度
			_points = PointFactory.createPoint({data:json['data'], limits:limits, color:_color});
			for each(var pt:Point in _points.points) {
				addChild(pt);
			}
		}
		
		/**
		 * 创建数据超标提示线
		 */
		private function buildLimitLine(/*limit:Number,*/limitType:String, dobuild:Boolean = false):void {
			if (dobuild) {
				//添加begin，range用于Y轴定位
				//var begin:Number = _yscale.positions[0];
				//var range:Number = Math.abs(_yscale.positions[_yscale.count - 1] - begin);
				_limitLines.push(new HLine({}));
				addChild(_limitLines[_limitLines.length - 1]);
				_limitLines.push(limitType);
			}
		}
		
		/**
		 * 绘制提示线
		 */
		private function drawLimitLine(coord:ScreenCoordsBase):void {
			var begin:Number = _yscale.positions[0];
			var range:Number = Math.abs(_yscale.positions[_yscale.count - 1] - begin);
			for (var i:int = 0; i < _limitLines.length; i++ ) {
				if (_limitLines[i] is String) {
					switch (_limitLines[i]) {
						case 'topLimit':
							HLine(_limitLines[i - 1]).limit(_yscale.topLimit).resize(coord, begin, range);
							break;
						case 'bottomLimit':
							HLine(_limitLines[i - 1]).limit(_yscale.bottomLimit).resize(coord, begin, range);
							break;
					}
				}
			}
		}
		
		/**
		 * 重定位数据点位置
		 * @param	coord
		 */
		private function locateDots(coord:ScreenCoordsBase):void {
			var begin:Number = _yscale.positions[0];
			var range:Number = Math.abs(_yscale.positions[_yscale.count - 1] - begin);
			_points.resize(coord, begin, range);
			/*for (var i:int = 0; i < numChildren; i++ ) {
				if (getChildAt(i) is BasePoint) {
					var element:BasePoint = getChildAt(i) as BasePoint;
					element.resize(coord);
				}
			}*/
		}
		
		/**
		 * 画线
		 */
		protected function drawLine():void {
			graphics.clear();
			graphics.lineStyle(_lineWidth, _color);
		}
		
		/**
		 * resize方法几乎用于所有的绘制过程，由于图表自适应宽高，所以初定义时并未设置宽度与高度，
		 * 创建之后便会调用resize方法绘制元素，并在每次窗体resize时重绘
		 * @param	coords
		 */
		override public function resize(coord:ScreenCoordsBase, begin:Number=NaN, range:Number=NaN):void {
			//super.x = super.y = 0;
			_xscale.resize(coord);
			_yscale.resize(coord);
			locateDots(coord);
			drawLine();
			drawLimitLine(coord);
		}
		
		/**
		 * gc
		 */
		override public function destroy():void {
			super.destroy();
			if (_yscale != null) {
				_yscale.destroy();
				_yscale = null;
			}
			if (_xscale != null) {
				_xscale.destroy();
				_xscale = null;
			}
			_index = null;
			for each(var limit:* in _limitLines) {
				if (limit is Resizable) {
					limit.destroy();
				}
				limit = null;
			}
			_limitLines = null;
		}
		
	}

}