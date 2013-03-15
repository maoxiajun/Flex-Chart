package pop 
{
	import coords.ScreenCoordsBase;
	import flash.geom.Rectangle;
	import theme.ThemeCss;
	import util.ObjectUtil;
	import util.ParseUtil;
	/**
	 * 框选时出现的框，附加一些框选事件
	 * @author maoxiajun
	 */
	//[Event(name = "dragDraw", type = "events.DragEvent")]
	public class DragRect extends Resizable {
		private var _color:uint;
		private var _stroke:int;
		private var _originX:Number = 0;//起始点
		private var _originY:Number = 0;
		private var _destinationX:Number = 0;//目标点
		private var _destinationY:Number = 0;
		
		public function DragRect(json:Object) {
			var style:Object = {
				color: ThemeCss.dragRectColor,
				stroke: ThemeCss.dragRectBorderStroke
			};
			var props:Object = ObjectUtil.merge(json, style);
			_color = ParseUtil.toColor(props.color);
			_stroke = props.stroke;
		}
		
		/**
		 * 重绘
		 * @param	coord
		 * @param	begin
		 * @param	range
		 */
		override public function resize(coord:ScreenCoordsBase, count:int = 0, begin:Number = NaN, range:Number = NaN):void {
			graphics.clear();
			if (_originX * _originY == 0) { 
				return;
			}
			graphics.beginFill(_color, 0.5);
			graphics.lineStyle(_stroke, _color, 0.9);
			graphics.drawRect(_originX, _originY, _destinationX - _originX, _destinationY - _originY);
			graphics.endFill();
		}
		
		/**
		 * 返回选中的矩形框区域
		 * @return
		 */
		public function selectedRect():Rectangle {
			return new Rectangle(_originX, _originY, _destinationX - _originX, _destinationY - _originY);
		}
		
		/**
		 * 框选起始点
		 */
		public function set originX(x:Number):void {
			_originX = x;
		}
		
		public function set originY(y:Number):void {
			_originY = y;
		}
		
		/**
		 * 框选目标点
		 */
		public function set destinationX(x:Number):void {
			_destinationX = x;
		}
		
		public function set destinationY(y:Number):void {
			_destinationY = y;
		}
		
		/**
		 * 清除图形
		 */
		public function clear():void {
			graphics.clear();
		}
		
		/**
		 * gc
		 */
		override public function destroy():void {
			super.destroy();
			originX = 0;
			originY = 0;
			destinationX = 0;
			destinationY = 0;
		}
	}

}