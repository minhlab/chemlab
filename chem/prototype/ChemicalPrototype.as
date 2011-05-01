package chem.prototype
{

	import flash.display.MovieClip;
	import chem.model.Chemical;
	import flash.geom.ColorTransform;
	import flash.display.DisplayObject;
	import fl.controls.Label;

	public class ChemicalPrototype extends MovieClip
	{

		protected var _chemical:Chemical;

		public function ChemicalPrototype(chemical:Chemical)
		{
			this._chemical = chemical;
			icon.transform.colorTransform = new ColorTransform(1, 1, 1, 1,
			((_chemical.color >> 24) & 0xff) - 0xff, 
			((_chemical.color >> 16) & 0xff) - 0xff, 
			((_chemical.color >> 8) & 0xff) - 0xff, 0);
			label.text = chemical.name;
		}

		public function get chemical():Chemical
		{
			return _chemical;
		}
		
		protected function get icon():MovieClip{
			return null;
		}
		
		protected function get label():Label {
			return null;
		}
		
		public static function createPrototype(c:Chemical):ChemicalPrototype  {
			if (c.state == Chemical.STATE_LIQUID) {
				return new LiquidPrototype(c);
			} else if (c.state == Chemical.STATE_SOLID) {
				return new SolidPrototype(c);
			} 
			return null;
		}
	}

}