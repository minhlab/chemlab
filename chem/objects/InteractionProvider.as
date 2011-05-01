package chem.objects
{

	import flash.events.MouseEvent;
	import chem.util.Animation;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.text.engine.TabAlignment;
	import chem.environment.Table;
	import chem.ui.PouringDialog;
	import chem.ui.TrashDialog;
	import flash.geom.Rectangle;
	import chem.util.GuiUtils;

	public class InteractionProvider
	{

		private static var _dragging:Equipment = null;
		private static var _receiver:Equipment = null;
		private static var _lamp:SpiritLamp = null;
		private static var startX,startY:Number;
		private static var frozen:Boolean = false;

		private static var pouringDialog:PouringDialog;

		public static function init(stage:Stage)
		{
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}

		public static function equipmentOnMouseDown(evt:MouseEvent)
		{
			startDraggingEquipment(Equipment(evt.currentTarget));
		}

		public static function startDraggingEquipment(equipment:Equipment)
		{
			if (frozen)
			{
				return;
			}
			if (_dragging == null)
			{
				_dragging = equipment;
				GuiUtils.changeParent(_dragging, Main.instance);
				startX = _dragging.stage.mouseX - _dragging.x;
				startY = _dragging.stage.mouseY - _dragging.y;
				Animation.stop(equipment);
				Main.instance.table.removeEquipment(equipment);
			}
		}

		public static function onEnterFrame(evt:Event)
		{
			if (frozen)
			{
				return;
			}
			if (_dragging != null)
			{
				_dragging.x = Math.min(Math.max(_dragging.stage.mouseX - startX, 0), Main.instance.width-20);
				_dragging.y = Math.min(Math.max(_dragging.stage.mouseY - startY, 0), Main.instance.height-20);

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
						_lamp = SpiritLamp(equipment);
						_lamp.showBase();
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
					if (_lamp != null)
					{
						_lamp.hideBase();
						_lamp.base.equipment = null;
						_lamp = null;
					}
				}
			}
		}

		public static function onMouseUp(evt:MouseEvent)
		{
			if (frozen)
			{
				return;
			}
			if (_dragging != null)
			{
				if (_dragging.hitTestObject(Main.instance.trash))
				{
					if (_dragging is LiquidContainer && LiquidContainer(_dragging).liquid != null)
					{
						var dlg:TrashDialog = new TrashDialog  ;
						frozen = true;
						dlg.show(function() {;
						removeDragging();
						frozen = false;
						}, function() {;
						frozen = false;
						});
					}
					else
					{
						removeDragging();
						return;
					}
				}

				if (_receiver != null)
				{
					frozen = true;
					if (pouringDialog == null)
					{
						pouringDialog = new PouringDialog  ;
					}
					pouringDialog.show(function(dlg:PouringDialog) {;
					frozen = false;
					equipmentReturn();
					}, function(dlb:PouringDialog) {;
					frozen = false;
					equipmentReturn();
					});
				}
				else if (_lamp != null)
				{
					if (testHoverAboveLampGesture(_dragging,_lamp))
					{
						_lamp.base.equipment = _dragging;
					}
					_lamp = null;
					_dragging = null;
				}
				else
				{
					equipmentReturn();
				}
			}
		}

		private static function removeDragging()
		{
			_dragging.parent.removeChild(_dragging);
			_dragging = null;
		}

		private static function equipmentReturn()
		{
			if (frozen)
			{
				return;
			}
			if (_receiver != null)
			{
				unrotate();
				_receiver = null;
			}

			var added:Boolean = Main.instance.table.addEquipment(_dragging);
			if (! added)
			{
				_dragging.parent.removeChild(_dragging);
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

		private static function testPoorGesture(sender:Equipment,receiver:Equipment):Boolean
		{
			return sender is LiquidContainer && receiver is LiquidContainer && LiquidContainer(sender).liquid != null && sender.x >= receiver.x + receiver.width / 2 - 10 && sender.x < receiver.x + receiver.width && sender.y + sender.height - 30 >= receiver.y;
		}

		private static function testHoverAboveLampGesture(container:Equipment,lampObj:Equipment):Boolean
		{
			if (! ((container is LiquidContainer) && (lampObj is SpiritLamp)))
			{
				return false;
			}
			var lamp:SpiritLamp = SpiritLamp(lampObj);
			if (lamp.base != null && lamp.base.equipment != null && lamp.base.equipment != container)
			{
				return false;
			}
			var dx = (lamp.x + lamp.body.x + lamp.body.width / 2) - (container.x + container.width / 2);
			var dy = lamp.y - (container.y + container.height);
			trace(dx, dy);
			return Math.abs(dx) < 30 && dy >= 0 && dy < 30;
		}

	}

}