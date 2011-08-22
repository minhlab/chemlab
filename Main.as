package 
{

	import flash.display.MovieClip;
	import chem.objects.CupShape;
	import chem.objects.Equipment;
	import chem.prototype.BeakerPrototype;
	import flash.events.Event;
	import chem.objects.InteractionProvider;
	import chem.prototype.TubePrototype;
	import chem.prototype.SpiritLampPrototype;
	import chem.prototype.ChemicalPrototype;
	import chem.environment.ChemicalStore;
	import chem.prototype.FunnelPrototype;
	import chem.prototype.ElectrolysisTankPrototype;
	import chem.model.Chemical;
	import chem.model.ChemicalProvider;
	import chem.environment.Properties;

	public class Main extends MovieClip
	{
		public function Main()
		{
			_instance = this;
			initToolbox();
			initChemicalStore();
			this.addEventListener(Event.ADDED_TO_STAGE, function() {
			InteractionProvider.init(stage);
			});
			initProperties();
		}
		
		private function initProperties(){
			var _properties:Properties = new Properties();
			this.addChild(_properties);
		}

		private function initToolbox()
		{
			toolbox.add(new BeakerPrototype());
			toolbox.add(new TubePrototype());
			toolbox.add(new SpiritLampPrototype());
			toolbox.add(new FunnelPrototype());
			toolbox.add(new ElectrolysisTankPrototype());
		}

		private function initChemicalStore()
		{
			chemicalStore.add(ChemicalProvider.WATER_LIQUID);
			chemicalStore.add(ChemicalProvider.NATRI);
			chemicalStore.add(ChemicalProvider.FERIT);
			chemicalStore.add(ChemicalProvider.H2SO4);
			chemicalStore.add(ChemicalProvider.HCL);
			chemicalStore.add(ChemicalProvider.NAOH);
			//chemicalStore.add(ChemicalProvider.CUCL);
		}

		private static var _instance:Main;

		public static function get instance():Main
		{
			return _instance;
		}

	}

}