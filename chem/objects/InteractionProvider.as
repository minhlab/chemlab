package chem.objects
{

	import flash.events.MouseEvent;
	import chem.util.Animation;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.text.engine.TabAlignment;
	import chem.environment.Table;
	import chem.ui.PouringDialog;

	public class InteractionProvider
	{

		private static var _dragging:Equipment = null;
		private static var _receiver:Equipment = null;
		private static var _lamp:Equipment = null;
		private static var startX,startY:Number;
		private static var frozen:Boolean = false;

		private static var pouringDialog:PouringDialog;

		public static function init(stage: Stage)
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, equipmentOnMouseUp);
			stage.addEventListener(Event.ENTER_FRAME, equipmentOnEnterFrame);
		}

		public static function equipmentOnMouseDown(evt: MouseEvent)
		{
			startDraggingEquipment((Equipment)(evt.currentTarget));
		}

		public static function startDraggingEquipment(equipment: Equipment)
		{
			if (frozen)
			{
				return;
			}
			if (_dragging == null)
			{
				_dragging = equipment;
				startX = _dragging.stage.mouseX - _dragging.x;
				startY = _dragging.stage.mouseY - _dragging.y;
				Animation.stop(equipment);
				Main.instance.table.removeEquipment(equipment);
			}
		}

		public static function equipmentOnEnterFrame(evt: Event)
		{
			if (frozen)
			{
				return;
			}
			if (_dragging != null)
			{
				_dragging.x = _dragging.stage.mouseX - startX;
				_dragging.y = _dragging.stage.mouseY - startY;
				//trace(mouseX + ", " + mouseY);

				var i:uint;
				var table:Table = Main.instance.table;
				for (i = 0; i < table.equipmentCount; i++)
				{
					var equipment:Equipment = table.getEquipment(i);
					if (testPoorGesture(_dragging,equipment))
					{
						if (_receiver == null)
						{
							rotate();
						}
						_receiver = equipment;
						break;
					}
					if (testHoverAboveLampGesture(_dragging,equipment))
					{
						_lamp = equipment;
						break;
					}
				}
				if (i >= table.equipmentCount)
				{
					if (_receiver != null)
					{
						_receiver = null;
						unrotate();
					}
				}
			}
		}
		
		public static function equipmentOnMouseUp(evt: MouseEvent)
		{
			if (frozen)
			{
				return;
			}
			if (_dragging != null)
			{
				if (_receiver != null)
				{
					frozen = true;
					if (pouringDialog == null)
					{
						pouringDialog = new PouringDialog();
					}
					pouringDialog.show(function(dlg:PouringDialog) {;
					equipmentReturn();
					frozen = false;
					}, function(dlb:PouringDialog) {;
					equipmentReturn();
					frozen = false;
					});
				}
				else
				{
					equipmentReturn();
				}
			}
		}

		private static function equipmentReturn()
		{
			if (_receiver != null)
			{
				unrotate();
				_receiver = null;
			}

			var destY = Main.instance.table.topY;
			if (_dragging.y + _dragging.height < destY)
			{
				var added:Boolean = Main.instance.table.addEquipment(_dragging);
				if (added)
				{
					Animation.fall(_dragging, destY);
				}
				else
				{
					_dragging.parent.removeChild(_dragging);
				}
			}
			else
			{
				_dragging.y = destY - _dragging.height;
			}
			_dragging = null;
		}

		private static function rotate()
		{
			_dragging.rotation = -30;
			_dragging.x -=  10;
			_dragging.y +=  25;
		}

		private static function unrotate()
		{
			_dragging.rotation = 0;
			_dragging.x +=  10;
			_dragging.y -=  25;
		}

		public static function get dragging():Equipment
		{
			return _dragging;
		}

		private static function testPoorGesture(sender: Equipment, receiver:Equipment):Boolean
		{
			return (sender is LiquidContainer) && (receiver is LiquidContainer) && 
			(sender.x >= receiver.x + receiver.width/2 - 10) && 
			(sender.x < receiver.x + receiver.width) &&
			(sender.y + sender.height - 30 >= receiver.y);
		}

		private static function testHoverAboveLampGesture(container: Equipment, lamp: Equipment):Boolean
		{
			if (!((container is LiquidContainer) && (lamp is SpiritLamp)))
			{
				return false;
			}
			var dx = (lamp.x + lamp.width/2) - (container.x + container.width/2);
			var dy = lamp.y - (container.y + container.height);
			return Math.abs(dx) < 30 && dy >= 0 && dy < 30;

		}

	}

}