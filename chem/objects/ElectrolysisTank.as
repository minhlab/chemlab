package chem.objects
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class ElectrolysisTank extends Equipment
	{

		public function ElectrolysisTank()
		{
			onBtn.addEventListener(MouseEvent.MOUSE_DOWN, onToggle);
			offBtn.addEventListener(MouseEvent.MOUSE_DOWN, onToggle);
		}

		public override function get baseLine():MovieClip
		{
			return _baseLine;
		}
		
		public function get on() : Boolean {
			return onBtn.visible;
		}
		
		public function set on(b:Boolean):void {
			onBtn.visible = b;
			offBtn.visible = !b;
		}
		
		public function onToggle(evt:MouseEvent):void {
			evt.stopImmediatePropagation();
			on = !on;
		}
		
	}

}