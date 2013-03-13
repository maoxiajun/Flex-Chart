package {
	import chart.GraphicFactory;
	import chart.series.BasePoint;
	import chart.SpriteCollection;
	import com.adobe.serialization.json.JSON;
	import coords.base.RangeX;
	import coords.base.RangeY;
	import coords.ScreenCoords;
	import dataloader.ChartLoader;
	import dataloader.TimeInterval;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import pop.DragRect;
	import pop.TipLine;
	import pop.ToolTip;
	import stages.axis.XAxis;
	import stages.axis.YAxis;
	import stages.BackGround;
	import stages.menu.BaseMenu;
	import stages.menu.ComboMenu;
	import util.ObjectUtil;
	import util.TraceUtil;
	
	/**
	 * 主画区
	 * @author maoxiajun
	 */
	public class Main extends Sprite {
		private var isChartLoaded:Boolean; //标记是否已完成构建
		private var tip:ToolTip; //弹窗
		private var sprites:SpriteCollection; //对象集合
		private var background:BackGround; //舞台背景
		private var xAxis:XAxis; //横坐标
		private var yAxis:YAxis; //纵坐标
		private var scoord:ScreenCoords; //坐标系
		private var tipLine:TipLine;//折线图
		private var chartLoader:Loader;//保存图表加载时的初始参数
		private var timer:TimeInterval;//定时器
		private var menu:BaseMenu;//菜单
		private var dragRect:DragRect;//框选
		
		public function Main():void	{
			addCallBack("load", load);
			isChartLoaded = false;
			initStage();
			//loadExternalData("../lib/data.txt");
			//blendMode = BlendMode.LAYER;
		}
////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////事件区开始///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * 设置画区事件及属性
		 */
		private function initStage():void {
			stage.align = StageAlign.TOP_LEFT;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		/**
		 * 画区尺寸变化时响应函数
		 * @param	event
		 */
		private function resizeHandler(event:Event):void {
			//flex单线程运行，所有远程访问数据方式均为异步方式，考虑到延时性，若此时图表未完成加载，则不做操作
			if (!isChartLoaded) { return; }
			resizeChart();
			//TraceUtil.ace("resize:"+stage.fullScreenWidth);
		}
		
		/**
		 * 重置图表画区比例
		 * @return
		 */
		private function resizeChart():void {
			var rangeX:RangeX = new RangeX(background.paddingLeft, background.paddingRight/*, xAxis.count*/);
			var rangeY:RangeY = new RangeY(background.paddingTop, background.paddingBottom/*, yAxis.count*/);
			scoord = new ScreenCoords(0, 0, stage.stageWidth, stage.stageHeight, rangeX, rangeY);
			
			background.resize(scoord);
			xAxis.resize(scoord);
			yAxis.resize(scoord);
			menu.resize(scoord);
			sprites.resize(scoord);
		}
		
		/**
		 * 鼠标按下
		 * @param	evt
		 */
		private function mouseDown(evt:MouseEvent):void {
			if ( isChartLoaded && background.covers(evt.stageX, evt.stageY) ) {
				dragRect.originX = evt.stageX;
				dragRect.originY = evt.stageY;
				addEventListener(MouseEvent.MOUSE_UP, mouseUp);//鼠标弹起
			}
		}
		
		/**
		 * 鼠标弹起
		 * @param	evt
		 */
		private function mouseUp(evt:MouseEvent):void {
			if ( isChartLoaded ) {
				dragRect.clear();
				resolveSelected( dragRect.selectedRect() );
				dragRect.destroy();
				removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
		}
		
		/**
		 * 处理框选放大事件
		 * @param	rect
		 */
		private function resolveSelected(rect:Rectangle):void {
			var selected:Array = [];
			if (sprites) {
				selected = sprites.contains(rect);
			}
			if (chartLoader) {
				rebuildChart( chartLoader.belongTo(selected) );
				timer.stop();
			}
		}
		
		/**
		 * 鼠标跟随
		 * @param	event
		 */
		private function mouseMove(evt:MouseEvent):void {
			if (evt.buttonDown) {
				if (background.covers(evt.stageX, evt.stageY)) {
					dragRect.destinationX = evt.stageX;
					dragRect.destinationY = evt.stageY;
				} else {
					dragRect.destinationX = evt.stageX > (scoord.axisWidth + scoord.widthXLeft) ? (scoord.axisWidth + scoord.widthXLeft) :
						(evt.stageX < scoord.widthXLeft ? scoord.widthXLeft : evt.stageX);
					dragRect.destinationY = evt.stageY > (scoord.axisHeight + scoord.heightYTop) ? (scoord.axisHeight + scoord.heightYTop) :
						(evt.stageY < scoord.heightYTop ? scoord.heightYTop : evt.stageY);
					//trace(evt.stageY + "," + (scoord.axisHeight + scoord.heightYTop));
				}
				dragRect.resize(scoord);
			}
			if (!tip) { return; }
			switch (tip.tipMouse) {
				case ToolTip.CLOSEST: dispathMouseMoveClosest(evt);	break;
				case ToolTip.PROXIMITY: break;
				case ToolTip.NORMAL: break;
			}
		}
		
		/**
		 * 分派鼠标跟随事件
		 * @param	evt
		 */
		private function dispathMouseMoveClosest(evt:MouseEvent):void {
			var closest:BasePoint = sprites.closest(evt.stageX, evt.stageY);
			tipLine.closestPoint(closest, scoord);
			tip.closestPoint(closest, scoord);
		}
///////////////////////////////////////事件区结束///////////////////////////////////////////////////
///////////////////////////////////////构建区开始///////////////////////////////////////////////////
		/**
		 * 重建图表，用于动态展示
		 * @param	json
		 */
		public function rebuildChart(json:Object = null):void {
			if (sprites) {
				sprites.destroy();
			}
			sprites = GraphicFactory.buildChart( json != null ? json : chartLoader.props );
			for each (var scale:Sprite in sprites.dynamics) {
				addChild(scale);
			}
			resizeChart();
		}
		
		/**
		 * 构建图表，加载过后只进行一次创建，此处添加事件监听器
		 * @param	json
		 */
		private function buildChart(json:Object):void {
			if (sprites) {
				destroy();
			}
			sprites = GraphicFactory.buildChart(json);
			tip = new ToolTip(json['tooltip']);
			tipLine = new TipLine({});
			buildChartBackGround(json);
			addChild(tipLine);
			for each (var scale:Sprite in sprites.dynamics) {
				addChild(scale);
			}
			addChild(tip);
			isChartLoaded = true;
			resizeChart();
			var isReload:Boolean = json['chart'] ? json['chart']['reload'] : false;
			timer = new TimeInterval(reload);
			if (isReload) {
				timer.start();
			}
			menu.addClickHandler("select", function():void { timer.start(arguments[0]); } );
			//menu.clickHandler = function(arg:int):void{ timer.start(arg); };同样可以
			menu.addClickHandler("click", function():void {
				timer.start(arguments[0]);
				chartLoader.reset();
				rebuildChart(null);
			});
			
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);//鼠标按下
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);//添加鼠标跟随
		}
		
		/**
		 * 构建图表背景
		 * @param	json
		 */
		private function buildChartBackGround(json:Object):void	{
			background = new BackGround(json['background']);
			xAxis = new XAxis(json['xaxis']);
			yAxis = new YAxis(json['yaxis']);
			menu = new ComboMenu(json['menu']);
			dragRect = new DragRect({});
			
			//背景最先添加，addChild有层次，最先添加的对象显示在最下层
			addChild(background);
			addChild(xAxis);
			addChild(yAxis);
			addChild(menu);
			addChild(dragRect);
		}
////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////构建区结束///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * 外部接口通过此方法加载数据并创建图表
		 * @param param
		 */
		private function load(json:Object):void {
			try {
				//TraceUtil.aceJson(json);
				chartLoader = new ChartLoader(json);
				if (chartLoader.uris.length == 0) {
					buildChart(chartLoader.props);
				} else {
					for each(var uri:String in chartLoader.uris) {
						if (uri) {
							loadExternalData(uri);
						}
					}
				}
			} catch (err:*) { }
		}
		
		/**
		 * 重新加载
		 * @param	json
		 */
		private function reload(json:Object = null):void {
			try {
				if (!chartLoader) { return; }
				if (chartLoader.uris.length == 0) {
					chartLoader.reload(json);
					rebuildChart(chartLoader.props);
				} else {
					for each(var uri:String in chartLoader.uris) {
						if (uri) {
							loadExternalData(uri);
						}
					}
				}
			} catch (err:*) { }
		}
		
		/**
		 * 加载外部数据，可为文本文件或url
		 * @param	uri
		 */
		private function loadExternalData(uri:String):void {
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, parseData);
			
			var request:URLRequest = new URLRequest(uri);
			loader.load(request);
		}
		
		/**
		 * 数据处理
		 * @param	evt
		 */
		private function parseData(evt:Event):void {
			var loader:URLLoader = URLLoader(evt.target);
			var json:Object = JSON.decode(loader.data);
			if (!chartLoader) {
				load(json);
			}
			if (chartLoader.process(json)) {
				var dobuild:Function = isChartLoaded ? rebuildChart : buildChart;
				dobuild(chartLoader.props);
			}
		}
		
		/**
		 * 发布外部回调函数接口
		 * @param	functionName
		 * @param	closure
		 */
		private function addCallBack(functionName:String, closure:Function):void {
			if (ExternalInterface.available) {
				ExternalInterface.addCallback(functionName, closure);
			}
		}
		
		/**
		 * 回调外部JS函数
		 * @param	functionName
		 * @param	...rest
		 * @return
		 */
		private function callExternalCallback(functionName:String, ...rest):* {
			if (ExternalInterface.available) {
				return ExternalInterface.call(functionName, rest);
			}
		}
		
		/**
		 * 垃圾回收
		 */
		private function destroy():void	{
			sprites.destroy(); sprites = null;
			
			if (tip) { tip.destroy(); tip = null; }
			if (tipLine) { tipLine.destroy(); tipLine = null; }
			if (background) { background.destroy();	background = null; }
			if (xAxis) { xAxis.destroy(); xAxis = null; }
			if (yAxis) { yAxis.destroy(); yAxis = null;	}
			if (menu) { menu.destroy(); menu = null; }
			
			while (numChildren > 0)	{
				removeChildAt(0);
			}
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			stage.removeEventListener(Event.RESIZE, resizeHandler);
			chartLoader.destroy(); chartLoader = null;
			timer.destroy(); timer = null;
			ObjectUtil.gc();
		}
	}
}