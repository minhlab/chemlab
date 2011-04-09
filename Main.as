package 
{

	import flash.display.MovieClip;
	import chem.objects.CupShape;
	import chem.prototype.BeakerPrototype;

	public class Main extends MovieClip
	{
		public function Main()
		{
			_instance = this;
			initToolbox();
		}
		
		private function initToolbox() {
			toolbox.add(new BeakerPrototype());
			toolbox.add(new BeakerPrototype());
		}
		
		private static var _instance : Main;
		
		public static function get instance(): Main {
			return _instance;
		}
		
	}

}