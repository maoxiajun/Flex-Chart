package  
{
	import com.adobe.utils.StringUtil;
	import util.ParseUtil;
	/**
	 * 模拟web中css样式
	 * @author ...
	 */
	public class Css 
	{
		//private var margin:String;//暂不支持margin、padding，有空回头写
		public var marginTop:int;
		public var marginBottom:int;
		public var marginLeft:int;
		public var marginRight:int;
		
		//private var padding:String;
		public var paddingTop:int;
		public var paddingBottom:int;
		public var paddingLeft:int;
		public var paddingRight:int;
		
		public var textAlign:String;
		public var fontSize:String;
		public var fontWeight:String;
		public var fontFamily:String;
		//public var fontStyle:String;
		public var color:uint;
		public var backgroundColor:int;
		
		public function Css(json:Object) 
		{
			this.marginTop = 0;
			this.marginBottom = 0;
			this.marginLeft = 0;
			this.marginRight = 0;
			
			this.paddingTop = 0;
			this.paddingBottom = 0;
			this.paddingLeft = 0;
			this.paddingRight = 0;
			
			for (var prop:String in json) {
				this.setValue(prop, StringUtil.trim(json[prop]));
				//string.replace( /^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2" );
			}
		}
		
		private function setValue(prop:String, val:Object):void {
			prop = StringUtil.trim(prop);
			switch ( prop ) {
				case "text-align": this.textAlign = val; break;
				case "font-size": this.fontSize = val; break;
				case "font-weight": this.fontWeight = val; break;
				case "font-family": this.fontFamily = val; break;
				//case "font-style": this.fontStyle = val; break;
				case "color": this.color = ParseUtil.toColor(val); break;
				case "background-color": this.backgroundColor = ParseUtil.toColor(val); break;
				
				//case "margin": this.margin = val; break;
				case "margin-top": this.marginTop = ParseUtil.toPixel(val); break;
				case "margin-bottom": this.marginBottom = ParseUtil.toPixel(val); break;
				case "margin-left": this.marginLeft = ParseUtil.toPixel(val); break;
				case "margin-right": this.marginRight = ParseUtil.toPixel(val); break;
				
				//case "padding": this.padding = val; break;
				case "padding-top": this.paddingTop = ParseUtil.toPixel(val); break;
				case "padding-bottom": this.paddingBottom = ParseUtil.toPixel(val); break;
				case "padding-left": this.paddingLeft = ParseUtil.toPixel(val); break;
				case "padding-right": this.paddingRight = ParseUtil.toPixel(val); break;
			}
		}
		
		public function clear():void {
			//margin;//暂不支持margin、padding
			marginTop = undefined;
			marginBottom = undefined;
			marginLeft = undefined;
			marginRight = undefined;
			
			//padding;
			paddingTop = undefined;
			paddingBottom = undefined;
			paddingLeft = undefined;
			paddingRight = undefined;
			
			textAlign = undefined;
			fontSize = undefined;
			fontWeight = undefined;
			fontFamily = undefined;
			//fontStyle;
			color = undefined;
			backgroundColor = undefined;
		}
	}

}