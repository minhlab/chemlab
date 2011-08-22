package chem.model
{
	import chem.util.ChemicalUtils;

	public class Oxide extends Chemical
	{

		private var _metal:Metal;
		private var _valence:int;

		public function Oxide(aMetal:Metal, valence:int, color:int)
		{
			super(ChemicalUtils.combine(aMetal.name, valence, "O", 2), 
			  color, STATE_SOLID, 0);
			_metal = aMetal;
			_valence = valence;
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