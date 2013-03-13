package chart.series 
{
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	import coords.ScreenCoordsBase;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import theme.RandomColor;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * 图表基本组件，数据点对象，与其他折线、多边形等区别处理
	 * 所有提示框等都是以点为基础，实际绘制的折线、多边形等都是以点为基础绘制
	 * 实际图形中有意义的都是数据点
	 * @author maoxiajun
	 */
	public class BasePoint extends Resizable {
		
		protected var _x:Number;
		protected var _y:Number;
		
		protected var _stroke:int;
		protected var _color:uint;
		protected var _rightAxis:Boolean = false;
		
		public function BasePoint(json:Object) {
			var style:Object = {
				color: RandomColor.randomColor(),
				stroke: ThemeCss.pointStroke,
				x:0,
				y:0
			};
			var props:Object = ObjectUtil.merge(json, style);
			_color = ParseUtil.toColor(props.color);
			_stroke = props.stroke;
			_x = props.x;
			_y = props.y;
			attachEvents();
		}
		
		/**
		 * 判断点是否在指定区域内
		 * @param	rect
		 * @return
		 */
		public function isIn(rect:Rectangle):Boolean {
			return rect.contains(x, rect.y + 1)
		}
		
		/**
		 * 为对象添加监听事件
		 */
		protected function attachEvents():void {
			//weak references可以使垃圾回收器干掉事件对象
			addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0, true);
		}
		
		/**
		 * 鼠标滑动响应
		 * @param	evt
		 */
		private function mouseOver(evt:MouseEvent):void {
			Tweener.addTween(this, { alpha:0.5, time:0.4, transition:"linear" } );
			
			//## [Tweener] Error: [object Point] raised an error while executing the 'onComplete'handler. 
			//ArgumentError: Error #1063: chart.series::BasePoint/mouseOver() 的参数数量不匹配。应该有 1 个，当前为 0 个。
			//不可直接使用onComplete:mouseOver方式
			Tweener.addTween(this, { alpha:1, time:0.4, delay:0.4, onComplete:function():void {
				mouseOver(null);
			}, transition:"linear" } );
		}
		
		/**
		 * 鼠标移出
		 * @param	evt
		 */
		private function mouseOut(evt:MouseEvent):void {
			Tweener.removeTweens(this);
			Tweener.addTween(this, { alpha:1, time:0.4, transition:Equations.easeOutElastic } );
		}
		
		/**
		 * 窗口重绘
		 * @param	coords
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number=NaN, range:Number=NaN):void {
			//rest中存储了Y轴起始坐标值及坐标值范围
			var point:Point = coord.getXFromPosYFromVal(_x, count, _y, begin, range, rightAxis);
			x = point.x;//将元素坐标定义为画区坐标
			y = point.y;//x，y为sprite对象属性，即父类属性
		}
		
		/**
		 * 设置是否以右侧y轴为纵坐标
		 */
		public function set rightAxis(axis:Boolean):void {
			_rightAxis = axis;
		}
		
		/**
		 * 返回是否以右侧Y轴为纵坐标
		 */
		public function get rightAxis():Boolean {
			return _rightAxis;
		}
		
		/**
		 * 返回元素设定的颜色
		 * @return
		 */
		public function get toolTipColor():uint {
			return _color;
		}
		
		/**
		 * 获取提示窗内容，暂无实现
		 * @return
		 */
		public function get toolTip():String {
			return "--";
		}
		
		/**
		 * 获取tip显示位置
		 * @return
		 */
		public function get tipPositon():Point {
			return new Point(_x, _y);
		}
		
		/**
		 * gc
		 */
		override public function destroy():void {
			super.destroy();
			if (hasEventListener(MouseEvent.MOUSE_OVER)) {
				removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			}
			if (hasEventListener(MouseEvent.MOUSE_OUT)) {
				removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			}
		}
	}

}