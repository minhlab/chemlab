package chem.prototype
{
	import chem.objects.Equipment;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import chem.objects.InteractionProvider;

	public class AbstractPrototype extends MovieClip
	{
		private var dragging: Boolean = false;

		public function AbstractPrototype()
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, prototypeOnMouseDown);
			this.addEventListener(MouseEvent.MOUSE_MOVE, prototypeOnMouseMove);
			this.addEventListener(MouseEvent.MOUSE_UP, prototypeOnMouseUp);
		}

		public function prototypeOnMouseDown(evt: MouseEvent) {
			dragging = true;
		}
		
		public function prototypeOnMouseUp(evt: MouseEvent) {
			dragging = false;			
		}
	
		public function prototypeOnMouseMove(evt: MouseEvent) {
			if (dragging) {
				var equipment : Equipment = createEquipment();
				equipment.x = evt.stageX - equipment.width/2;
				equipment.y = evt.stageY - equipment.height/2;
				Main.instance.addChild(equipment);
				InteractionProvider.startDraggingEquipment(equipment);
				dragging = false;
			}
		}

		public function createEquipment():Equipment
		{
			throw "Extending class must override createEquipment method";
		}

	}

}