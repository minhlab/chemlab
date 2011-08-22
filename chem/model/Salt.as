package chem.model
{
	import chem.util.ChemicalUtils;

	public class Salt extends Chemical
	{

		private var _metal:Metal;
		private var _acid:Acid;
		private var _metalValence:int;

		public function Salt(aMetal:Metal, anAcid:Acid, metalValence:int, 
		 aColor:int, dissolvable:Number=1)
		{
			super(ChemicalUtils.combine(aMetal.name, metalValence, 
										anAcid.root, anAcid.valence), 
			  aColor, STATE_SOLID, dissolvable);
			_metal = aMetal;
			_acid = anAcid;
			_metalValence = metalValence;
		}

		public function get metal():Metal
		{
			return _metal;
		}
		public function get acid():Acid
		{
			return _acid;
		}
		public function get metalValence():int
		{
			return _metalValence;
		}

	}

}