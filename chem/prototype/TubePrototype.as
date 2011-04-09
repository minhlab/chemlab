package chem.prototype {
	import chem.objects.Tube;
	
	public class TubePrototype extends AbstractPrototype {

		public function TubePrototype() {
			// constructor code
		}

		public override function createEquipment() : Equipment {
			return new Tube();
		}

	}
	
}
