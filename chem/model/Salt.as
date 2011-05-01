package chem.model {
	
	public class Salt extends Chemical {

		private var _metal:Metal;
		private var _acid:Acid;

		public function Salt(aMetal:Metal, anAcid:Acid, aColor:int) {
			super(aMetal.name + anAcid.name, aColor, STATE_SOLID);
			_metal = aMetal;
			_acid = anAcid;			
		}

	}
	
}
