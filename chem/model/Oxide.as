package chem.model
{

	public class Oxide extends Chemical
	{

		private var _metal:Metal;
		private var _valence:int;

		public function Oxide(aMetal:Metal, valence:int, color:int)
		{
			super(getOxideName(aMetal, valence), color, STATE_SOLID);
			_metal = aMetal;
			_valence = valence;
		}

		private static function getOxideName(aMetal:Metal, valence:int):String
		{
			if (valence == 2) {
				return aMetal.name + "O";
			}
			if (valence % 2 == 0)
			{
				return aMetal.name + "O" + (valence/2);
			}
			return aMetal.name + "2O" + valence;
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