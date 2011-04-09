package chem.prototype {
	import chem.objects.SpiritLamp;
	
	public class SpiritLampPrototype extends AbstractPrototype {

		public function SpiritLampPrototype() {
			// constructor code
		}

		public override function createEquipment() : Equipment {
			return new SpiritLamp();
		}

	}
	
}
