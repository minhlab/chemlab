package chem.prototype {
	import chem.objects.Funnel;
	
	public class FunnelPrototype extends AbstractPrototype {

		public function FunnelPrototype() {
			// constructor code
		}

		public override function createEquipment() : Equipment {
			return new Funnel();
		}

	}
	
}
