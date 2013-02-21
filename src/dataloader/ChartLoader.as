package dataloader 
{
	import util.ObjectUtil;
	/**
	 * 外部URL数据加载器，此部分与后台通信业务耦合度较高，非可重用类
	 * @author maoxiajun
	 */
	public class ChartLoader extends Loader
	{
		private var _uricount:int;
		
		public function ChartLoader(json:Object) {
			super(json);
			_uricount = 0;
			countUris();
		}
		
		/**
		 * 计算外部资源请求所需次数
		 * @param	json
		 */
		private function countUris():void {
			for each(var cdata:Object in _props['chart']['chartData']) {
				if (cdata['url']) {
					_uris.push(cdata['url']);
				}
			}
		}
		
		/**
		 * 处理异步加载的json数据，返回bool型表示是否已完成所有数据的加载
		 * @param	json
		 * @return
		 */
		override public function process(json:Object):Boolean {
			for each(var cdata:Object in _props['chart']['chartData']) {
				var row:Object = (json['rows'] as Array)[0]['cell'];
				if (row[cdata['display']['y']] && cdata['data'] == undefined) {
					cdata['data'] = [];
					cdata['xscale']['data'] = [];
					for each(var tmp:Object in json['rows']) {
						(cdata['data'] as Array).push(tmp['cell'][cdata['display']['y']]);
						(cdata['xscale']['data'] as Array).push(
							(tmp['cell'][cdata['display']['x']] as String).split(String.fromCharCode(32))[1]
						);
					}
					_uricount ++;
					//cdata['data'] = [1, 2, 12, 2, 12];
				}
			}
			if (_uricount == uris.length) {
				_uricount = 0;//还原以待下一次加载
				return true;
			}
			return false;
		}
		
	}

}