package chem.prototype {
	import chem.objects.GlassRod;
	
	public class GlassRodPrototype extends AbstractPrototype {

		public function GlassRodPrototype() {
			// constructor code
		}

		public override function createEquipment() : Equipment {
			return new GlassRod();
		}

	}
	
}
