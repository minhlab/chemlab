package chem.prototype {
	
	import flash.display.MovieClip;
	import fl.controls.Label;
	import chem.model.Chemical;
	
	
	public class LiquidPrototype extends ChemicalPrototype {
				
		public function LiquidPrototype(c:Chemical) {
			super(c);
		}
		
		protected override function get icon():MovieClip{
			return liquidIcon;
		}
		protected override function get label():Label {
			return nameTxt;
		}
	}
	
}
