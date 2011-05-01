package chem.prototype {
	
	import flash.display.MovieClip;
	import chem.objects.ElectrolysisTank;
	import chem.objects.Equipment;
	
	
	public class ElectrolysisTankPrototype extends AbstractPrototype {
		
		public function ElectrolysisTankPrototype() {
			
		}
			
		public override function createEquipment() : Equipment {
			return new ElectrolysisTank();
		}

	}
	
}
