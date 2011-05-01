package chem.prototype {
	import chem.objects.Tube;
	import chem.objects.Equipment;
	
	public class TubePrototype extends AbstractPrototype {

		public function TubePrototype() {
		}

		public override function createEquipment() : Equipment {
			return new Tube();
		}

	}
	
}
