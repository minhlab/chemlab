package chem.prototype {
	import chem.objects.Equipment;
	import chem.objects.Beaker;
	
	public class BeakerPrototype extends AbstractPrototype {

		public function BeakerPrototype() {
		}
		
		public override function createEquipment() : Equipment {
			return new Beaker();
		}

	}
	
}
