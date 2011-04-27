package chem.model
{

	public class Liquid
	{

		private var _volume:Number;

		public function Liquid()
		{
		}

		/**
		 * Mix two liquids together
		 */
		public function mix(l:Liquid):void {
			_volume += l._volume;
		}

		/**
		 * Extract a part of this liquid to form another liquid
		 */
		public function extract(v: Number):Liquid
		{
			if (v <= 0 || v >= _volume)
			{
				throw "invalid extracted volume: " + v;
			}
			_volume -= v;
			var extracted:Liquid = new Liquid();
			extracted._volume = v;
			return extracted;
		}

		public function get volume()
		{
			return _volume;
		}

	}

}