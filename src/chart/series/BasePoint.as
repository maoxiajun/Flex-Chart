package chart.series 
{
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	import coords.ScreenCoordsBase;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * 图表基本组件，数据点对象，与其他折线、多边形等区别处理
	 * 所有提示框等都是以点为基础，实际绘制的折线、多边形等都是以点为基础绘制
	 * 实际图形中有意义的都是数据点
	 * @author ...
	 */
	public class BasePoint extends Resizable /*implements IBaseTip*/ {
		
		protected var _x:Number;
		protected var _y:Number;
		
		protected var _color:uint;
		protected var _rightAxis:Boolean = false;
		
		/**
		 * 返回X坐标
		 */
		/*public function get px():Number {
			return _x;
		}*/
		
		/**
		 * 返回Y坐标
		 */
		/*public function get py():Number {
			return _y;
		}*/
		
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
		 * 设置为true则显示弹窗信息
		 * @param	show
		 */
		//public function set toolTipShow(show:Boolean):void { }
		
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
		public function mouseOver(evt:Event):void {
			Tweener.addTween(this, { alpha:0.5, time:0.4, transition:"linear" } );
			Tweener.addTween(this, { alpha:1, time:0.4, delay:0.4, onComplete:this.mouseOver, transition:"linear" } );
		}
		
		/**
		 * 鼠标移出
		 * @param	evt
		 */
		public function mouseOut(evt:Event):void {
			Tweener.removeTweens(this);
			Tweener.addTween(this, { alpha:1, time:0.4, transition:Equations.easeOutElastic } );
		}
		
		/**
		 * 窗口重绘
		 * @param	coords
		 */
		override public function resize(coord:ScreenCoordsBase, begin:Number=NaN, range:Number=NaN):void {
			//rest中存储了Y轴起始坐标值及坐标值范围
			var point:Point = coord.getXFromPosYFromVal(_x, undefined, _y, begin, range, rightAxis);
			super.x = point.x;//将元素坐标定义为画区坐标
			super.y = point.y;//x，y为sprite对象属性，即父类属性
		}
	}

}