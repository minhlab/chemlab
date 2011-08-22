package chem.model
{

	public class ChemicalProvider
	{

		public static var WATER_LIQUID:Chemical = new Chemical("H2O",0xffffff00,Chemical.STATE_LIQUID);
		public static var WATER_VAPOR:Chemical = new Chemical("H2O(h)",0xffffff00,Chemical.STATE_GAS);
		public static var HIDRO:Chemical = new Chemical("H2",0xffffff00,Chemical.STATE_GAS);
		public static var OXYGEN:Chemical = new Chemical("O2",0xffffff00,Chemical.STATE_GAS);
		public static var NITROGEN:Chemical = new Chemical("N2",0xffffff00,Chemical.STATE_GAS);
		public static var HCL:Acid = new Acid("HCl","Cl",0xffffff00,1);
		public static var H2SO4:Acid = new Acid("H2SO4","(SO4)",0xffffff00,2);
		public static var NATRI:Metal = new Metal("Na",1,0xffffffff);
		public static var FERIT:Metal = new Metal("Fe",2,0xffffffff);
		public static var COPPER:Metal = new Metal("Cu",2,0xCC3300ff);
		public static var NAOH:Base = new Base(NATRI,1,0xffffffff);
		public static var CUCL:Salt= getSalt(COPPER, HCL);

		public function ChemicalProvider()
		{
		}

		public static function getOxide(metal:Metal,  valence:int=-1):Oxide
		{
			if (valence < 0)
			{
				valence = metal.defaultValence;
			}
			var color:int = metal.color;
			if (metal == COPPER)
			{
				color = 0x055DDDff;
			}
			return new Oxide(metal, metal.defaultValence, color);
		}

		public static function getSalt(metal:Metal, acid:Acid, metalValence:int=-1):Salt
		{
			if (metalValence < 0)
			{
				metalValence = metal.defaultValence;
			}
			var color:int = metal.color;
			if (metal == COPPER)
			{
				color = 0x055DDDFF;
			}
			var dissovable = 1;
			if (metal == COPPER && acid == H2SO4) {
				dissovable = 0;
			}
			return new Salt(metal,acid,metalValence,color, dissovable);
		}

	}

}