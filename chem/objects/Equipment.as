package chem.objects
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import chem.util.Animation;
	import flash.events.Event;

	public class Equipment extends MovieClip
	{

		private var dragging:Boolean = false;
		private var startX,startY:Number;

		public function Equipment()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, function() {
			stage.addEventListener(MouseEvent.MOUSE_UP, equipmentOnMouseUp);  
			});
			this.addEventListener(MouseEvent.MOUSE_DOWN, equipmentOnMouseDown);
			this.addEventListener(Event.ENTER_FRAME, equipmentOnMouseMove);
		}

		public function equipmentOnMouseDown(evt: MouseEvent)
		{
			if (!dragging) {
				this.dragging = true;
				startX = stage.mouseX - x;
				startY = stage.mouseY - y;
				Animation.stop(this);
				Main.instance.table.removeEquipment(this);
			}
		}

		public function equipmentOnMouseMove(evt: Event)
		{
			if (dragging)
			{
				x = stage.mouseX - startX;
				y = stage.mouseY - startY;
				//trace(mouseX + ", " + mouseY);
			}
		}

		public function equipmentOnMouseUp(evt: MouseEvent)
		{
			if (dragging) {
				this.dragging = false;
				var destY = Main.instance.table.topY;
				if (y + height < destY)
				{
					var added : Boolean = Main.instance.table.addEquipment(this);
					if (added) {
						Animation.fall(this, destY);
					} else {
						parent.removeChild(this);
					}
				}
				else
				{
					y = destY - height;
				}
			}
		}

	}

}