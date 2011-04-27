package 
{

	import flash.display.MovieClip;
	import chem.objects.CupShape;
	import chem.objects.Equipment;
	import chem.prototype.BeakerPrototype;
	import flash.events.Event;
	import chem.objects.InteractionProvider;

	public class Main extends MovieClip
	{
		public function Main()
		{
			_instance = this;
			initToolbox();
			this.addEventListener(Event.ADDED_TO_STAGE, function() {
				InteractionProvider.init(stage);
			});
		}

		private function initToolbox()
		{
			toolbox.add(new BeakerPrototype());
			toolbox.add(new BeakerPrototype());
		}

		private static var _instance:Main;

		public static function get instance():Main
		{
			return _instance;
		}

	}

}