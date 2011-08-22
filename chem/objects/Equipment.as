package chem.objects
{

	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class Equipment extends MovieClip
	{
		private static var _containers:Array = new Array(); 

		public function Equipment()
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, InteractionProvider.equipmentOnMouseDown);
			baseLine.visible = false;
		}

		public function get baseLine():MovieClip
		{
			return null;
		}
		
		public static function get containers():Array{
			return _containers;
		}
		
		public static function set containers(containers:Array){
			Equipment._containers = containers;
		}
		
		public static function addContainer(container:Equipment){
			Equipment._containers.push(container);
		}

	}

}