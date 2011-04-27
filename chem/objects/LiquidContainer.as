package chem.objects
{
	import chem.model.Liquid;

	public class LiquidContainer extends Equipment
	{

		protected var _liquid:Liquid = null;
		protected var _volume:Number;

		public function LiquidContainer()
		{
			// constructor code
		}
		
		public function startStiring():void {
			throw "unsupported operation";
		}
		
		public function stopStiring():void {
			throw "unsupported operation";
		}
		
		public function addLiquid(l:Liquid) {
			_liquid.mix(l);
		}
		
		public function clean():void {
			_liquid = null;
		}
		
		public function pour(v:Number):Liquid {
			return _liquid.extract(v);
		}
		
		public function startBurned():void {
			throw "unsupported operation";
		}
		
		public function stopBurned():void {
			throw "unsupported operation";
		}

		public function get volume():Number
		{
			return _volume;
		}

		public function get liquid():Liquid
		{
			return _liquid;
		}

	}

}