package chem.model
{
	import chem.util.ChemicalUtils;

	public class Base extends Chemical
	{

		private var _metal:Metal;
		private var _valence:int;

		public function Base(aMetal:Metal, valence:int, color:int)
		{
			super(ChemicalUtils.combine(aMetal.name, valence, "(OH)", 1), 
				  color, STATE_LIQUID);
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