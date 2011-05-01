package chem.model {
	
	public class ChemicalProvider {

		public static var HIDRO:Chemical = new Chemical("H2",0xffffff80,Chemical.STATE_GAS);
		public static var OXYGEN:Chemical = new Chemical("O2",0xffffff80,Chemical.STATE_GAS);
		public static var HCL:Acid = new Acid("HCl", "Cl", 0xffffff80);
		public static var H2SO4:Acid = new Acid("H2SO4", "SO4", 0xffffffff);
		public static var NATRI:Metal = new Metal("Na", 1, 0xffffffff);
		public static var FERIT:Metal = new Metal("Na", 1, 0xffffffff);
		public static var COPPER:Metal = new Metal("Cu", 1, 0xCC3300ff);
		public static var NAOH:Base = new Base(NATRI, 1, 0xffffffff);

		public function ChemicalProvider() {
		}

	}
	
}
