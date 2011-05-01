package chem.objects
{
	import chem.model.Liquid;

	public class LiquidContainer extends Equipment
	{

		protected var _liquid:Liquid = null;
		protected var _volume:Number;

		public function LiquidContainer()
		{
			//_liquid = new Liquid(new HCl,50);
		}

		public function startStiring():void
		{
			throw "unsupported operation";
		}

		public function stopStiring():void
		{
			throw "unsupported operation";
		}

		public function addLiquid(l:Liquid)
		{
			if (_liquid == null)
			{
				_liquid = liquid;
				onLiquidChanged();
			}
			else
			{
				_liquid.mix(l);
			}
		}

		public function clean():void
		{
			_liquid = null;
			onLiquidChanged();
		}

		public function pour(v:Number):Liquid
		{
			return _liquid.extract(v);
		}

		public function startBurned(v:Number):void
		{
			if (_liquid != null)
			{
				_liquid.startBurned(v);
			}
		}

		public function stopBurned():void
		{
			if (_liquid != null)
			{
				_liquid.stopBurned();
			}
		}

		public function get volume():Number
		{
			return _volume;
		}

		public function get liquid():Liquid
		{
			return _liquid;
		}

		public function onLiquidChanged()
		{

		}

	}

}