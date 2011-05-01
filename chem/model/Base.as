package chem.model
{

	public class Base extends Chemical
	{

		private var _metal:Metal;
		private var _valence:int;

		public function Base(aMetal:Metal, valence:int, color:int)
		{
			super(getBaseName(aMetal, valence), color, STATE_LIQUID);
			_metal = aMetal;
			_valence = valence;
		}

		private static function getBaseName(aMetal:Metal, valence:int):String
		{
			if (valence == 2) {
				return aMetal.name + "OH";
			}
			if (valence % 2 == 0)
			{
				return aMetal.name + "(OH)" + (valence/2);
			}
			return aMetal.name + "2(OH)" + valence;
		}

		public function get metal():Metal
		{
			return _metal;
		}

		public function get valence():int
		{
			return _valence;
		}

	}

}