package chem.model
{
	import chem.objects.LiquidContainer;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;

	public class Liquid
	{

		public static var roomTemperature:Number = 25;
		private var _volume:Number = 0;
		private var _chemicals:Array = new Array  ;
		private var _temperature:Number = roomTemperature;
		public var container:LiquidContainer = null;
		private var _boilingPoint = 100;
		private var _coolingVelocity = 0.04;
		private var _color:int;

		public function Liquid(chemical:Chemical=null,volume:Number=0)
		{
			if (chemical == null)
			{
				return;
			}
			this._chemicals[0] = chemical;
			this._volume = volume;
		}

		/**
		 * Mix two liquids together
		 */
		public function mix(l:Liquid):void
		{
			_volume +=  l._volume;
			_chemicals.concat(l._chemicals);
			if (containType('Acid') && containType('Metal'))
			{

			}
			fireOnLiquidChanged();
		}

		private function containType(type):Boolean
		{
			for (var i = 0; i < chemicals.length; i++)
			{
				if (chemicals[i] is type)
				{
					return true;
				}
			}
			return false;
		}

		/**
		 * Extract a part of this liquid to form another liquid
		 */
		public function extract(v:Number):Liquid
		{
			if (v <= 0 || v >= _volume)
			{
				throw "invalid extracted volume: " + v;
			}
			_volume -=  v;
			var extracted:Liquid = new Liquid  ;
			extracted._volume = v;
			fireOnLiquidChanged();
			return extracted;
		}

		public function get volume()
		{
			return _volume;
		}

		public function get chemicals()
		{
			return _chemicals;
		}

		protected function fireOnLiquidChanged()
		{
			if (container != null)
			{
				container.onLiquidChanged();
			}
		}

		private var burnedId;
		private var cooledId;
		private var burningVelocity;

		public function startBurned(v:Number)
		{
			burningVelocity = v;
			burnedId = setInterval(burned,40);
		}

		private function burned()
		{
			_temperature +=  burningVelocity;
			if (_temperature > boilingPoint)
			{
				_temperature = boilingPoint;
				_volume -=  burningVelocity * 0.1;
				if (_volume < 0)
				{
					_volume = 0;
					clearInterval(burnedId);
				}
			}
			fireOnLiquidChanged();
		}

		public function stopBurned()
		{
			clearInterval(burnedId);
			cooledId = setInterval(cooled,40);
		}

		private function cooled()
		{
			_temperature -=  _coolingVelocity;
			if (_temperature < roomTemperature)
			{
				_temperature = roomTemperature;
				clearInterval(cooledId);
			}
			fireOnLiquidChanged();
		}

		public function get temperature():Number
		{
			return _temperature;
		}

		public function get boilingPoint():Number
		{
			return _boilingPoint;
		}

		public function get color()
		{
			return _color;
		}

	}

}