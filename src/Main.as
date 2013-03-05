package
{
	import chart.GraphicFactory;
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
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import pop.TipLine;
	import pop.ToolTip;
	import stages.axis.XAxis;
	import stages.axis.YAxis;
	import stages.BackGround;
	import stages.menu.BaseMenu;
	import util.ObjectUtil;
	import util.TraceUtil;
	
	/**
	 * 主画区
	 * @author maoxiajun
	 */
	public class Main extends Sprite
	{
		private var isChartLoaded:Boolean; //标记是否已完成构建
		private var tip:ToolTip; //弹窗
		private var sprites:SpriteCollection; //对象集合
		private var background:BackGround; //舞台背景
		private var xAxis:XAxis; //横坐标
		private var yAxis:YAxis; //纵坐标
		private var scoord:ScreenCoords; //坐标系
		private var tipLine:TipLine;//折线图
		private var clder:Loader;//保存图表加载时的初始参数
		private var timer:TimeInterval;//定时器
		private var menu:BaseMenu;//菜单
		
		public function Main():void	{
			addCallBack("load", load);
			isChartLoaded = false;
			setMainStage();
			loadExternalData("../lib/data.txt", true);
			//blendMode = BlendMode.LAYER;
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////事件区开始///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * 设置画区事件及属性
		 */
		private function setMainStage():void {
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
			if (!isChartLoaded) {
				return;
			}
			resizeChart();
			//TraceUtil.ace("resize:"+stage.fullScreenWidth);
		}
		
		/**
		 * 重置图表画区比例
		 * @return
		 */
		private function resizeChart(): /*ScreenCoordsBase*/void {
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMove); //添加鼠标跟随
			//TraceUtil.ace("stage>>width:" + stage.stageWidth + ",height:" + stage.stageHeight);
			
			var rangeX:RangeX = new RangeX(background.paddingLeft, background.paddingRight, xAxis.count);
			var rangeY:RangeY = new RangeY(background.paddingTop, background.paddingBottom, yAxis.count);
			scoord = new ScreenCoords(0, 0, stage.stageWidth, stage.stageHeight,
				/*background.paddingLeft, background.paddingRight, background.paddingTop, background.paddingBottom*/
				rangeX, rangeY);
			
			background.resize();
			xAxis.resize(scoord);
			yAxis.resize(scoord);
			menu.resize(scoord);
			sprites.resize(scoord);
			//tip.resize(scoord);
			//tipLine.resize(scoord);
		}
		
		/**
		 * 鼠标跟随
		 * @param	event
		 */
		private function mouseMove(evt:Event):void {
			if (!tip) {
				return;
			}
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
		private function dispathMouseMoveClosest(evt:Event):void {
			//trace(mouseX+','+mouseY);
			var closest:Object = sprites.closest(mouseX, mouseY);
			tipLine.closestPoint(closest['pt'], scoord);
			tip.closestPoint(closest['pt'], scoord);
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
			sprites = GraphicFactory.buildChart(clder.props);
			for each (var scale:Sprite in sprites.dynamics) {
				addChild(scale);
			}
			resizeChart();
		}
		
		/**
		 * 构建图表
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
			timer = new TimeInterval(rebuildChart);
			resizeChart();
			timer.start();
		}
		
		/**
		 * 构建图表背景
		 * @param	json
		 */
		private function buildChartBackGround(json:Object):void	{
			background = new BackGround(json['background']);
			xAxis = new XAxis(json['xaxis']);
			yAxis = new YAxis(json['yaxis']);
			menu = new BaseMenu(json['menu']);
			
			//背景最先添加，addChild有层次，最先添加的对象显示在最下层
			addChild(background);
			addChild(xAxis);
			addChild(yAxis);
			addChild(menu);
			/*for each (var scale:Sprite in sprites.cached) {
				addChild(scale);
			}*/
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////构建区结束///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * 外部接口通过此方法加载数据并创建图表
		 * @param param
		 */
		private function load(json:Object/*evt:Event*/):void {
			try {
				//TraceUtil.aceJson(json);
				var loader:URLLoader = URLLoader(evt.target);
				var json:Object = JSON.decode(loader.data);
				clder = new ChartLoader(json);
				for each(var uri:String in clder.uris) {
					if (uri) {
						loadExternalData(uri);
					}
				}
			} catch (err:*) { }
		}
		
		/**
		 * 加载外部数据，可为文本文件或url
		 * @param	uri
		 */
		private function loadExternalData(uri:String, debug:Boolean=false):void {
			var loader:URLLoader = new URLLoader();
			if (debug) {
				loader.addEventListener(Event.COMPLETE, load);
			} else {
				loader.addEventListener(Event.COMPLETE, parseData);
			}
			
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
			if (clder.process(json)) {
				buildChart(clder.props);
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
			if (background) { background.destroy();	background = null; }
			if (xAxis) { xAxis.destroy(); xAxis = null; }
			if (yAxis) { yAxis.destroy(); yAxis = null;	}
			//if (line) { line.destroy(); line = null; }
			
			while (numChildren > 0)	{
				removeChildAt(0);
			}
			if (hasEventListener(MouseEvent.MOUSE_MOVE)) {
				removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			}
			clder.destroy(); clder = null;
			timer.destroy(); timer = null;
			ObjectUtil.gc();
		}
	}
}