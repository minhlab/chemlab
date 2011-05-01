package chem.prototype {
	
	import flash.display.MovieClip;
	import fl.controls.Label;
	import chem.model.Chemical;
	
	public class SolidPrototype extends ChemicalPrototype {
		
		
		public function SolidPrototype(c:Chemical) {
			super(c);
		}
		
				
		protected override function get icon():MovieClip{
			return solidIcon;
		}
		protected override function get label():Label {
			return nameTxt;
		}

	}
	
}
