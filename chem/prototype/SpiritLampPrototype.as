package chem.prototype {
	import chem.objects.SpiritLamp;
	import chem.objects.Equipment;
	
	public class SpiritLampPrototype extends AbstractPrototype {

		public function SpiritLampPrototype() {
		}

		public override function createEquipment() : Equipment {
			return new SpiritLamp();
		}

	}
	
}
