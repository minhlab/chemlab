package chem.objects {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import chem.util.Animation;
	
	public class Equipment extends MovieClip {

		private var dragging: Boolean = false;
		private var startX, startY : int;

		public function Equipment() {
			this.addEventListener(MouseEvent.MOUSE_DOWN, equipmentOnMouseDown);
			this.addEventListener(MouseEvent.MOUSE_MOVE, equipmentOnMouseMove);
			this.addEventListener(MouseEvent.MOUSE_UP, equipmentOnMouseUp);
		}

		public function equipmentOnMouseDown(evt: MouseEvent) {
			this.dragging = true;
			startX = evt.stageX - x;
			startY = evt.stageY - y;
			Animation.stop(this);
		}

		public function equipmentOnMouseMove(evt: MouseEvent) {
			if (dragging) {
				this.x = evt.stageX - startX;
				this.y = evt.stageY - startY;
			}
		}

		public function equipmentOnMouseUp(evt: MouseEvent) {
			this.dragging = false;
			var destY = Main.instance.desk.topY;
			if (y + height < destY) {
				Animation.fall(this, destY);
			} else {
				y = destY - height;
			}
		}

	}
	
}
