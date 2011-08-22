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
	import flash.filters.GlowFilter;
	import chem.prototype.ChemicalPrototype;
	import chem.model.Liquid;
	import chem.prototype.LiquidPrototype;
	import chem.prototype.SolidPrototype;
	import chem.model.Matter;
	import chem.ui.AddMatterDialog;
	import chem.model.Chemical;

	public class InteractionProvider
	{

		private static var _dragging:Equipment = null;
		private static var _selected:Equipment = null;
		private static var _receiver:Equipment = null;
		private static var _lamp:SpiritLamp = null;
		private static var startX,startY:Number;
		private static var frozen:Boolean = false;

		private static var glow:GlowFilter = new GlowFilter(0xFFFFFF,0.5,25,25,2,3,false,false);


		private static var _takingChemical:ChemicalPrototype = null;
		private static var addMatterDialog:AddMatterDialog;


		public static function init(stage:Stage)
		{
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}

		public static function equipmentOnMouseDown(evt:MouseEvent)
		{
			evt.stopImmediatePropagation();
			startDraggingEquipment(Equipment(evt.currentTarget));
			selectEquipment(Equipment(evt.currentTarget));
		}

		public static function chemicalPrototypeOnMouseDowm(evt:MouseEvent)
		{
			startTakingChemical(ChemicalPrototype(evt.currentTarget));
		}

		public static function startTakingChemical(chemical:ChemicalPrototype)
		{
			if (frozen)
			{
				return;
			}
			if (_takingChemical == null)
			{
				_takingChemical = chemical;
				GuiUtils.changeParent(_takingChemical, Main.instance);
				startX = _takingChemical.stage.mouseX - _takingChemical.x;
				startY = _takingChemical.stage.mouseY - _takingChemical.y;
				Animation.stop(chemical);
			}
		}

		public static function selectEquipment(equipment:Equipment)
		{
			if (frozen)
			{
				return;
			}
			if (_selected != null)
			{
				//trace(_selected.filters.indexOf(glow));
				//_selected.filters.slice(_selected.filters.indexOf(glow),1);
				_selected.filters = new Array();
			}
			_selected = equipment;
			var filter:Array = _selected.filters;
			filter.push(glow);
			_selected.filters = filter;
			if (_selected is SpiritLamp){
				_selected.filters = new Array();
			}
		}

		public static function get select():Equipment
		{
			return _selected;
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
				processGestures();
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
				_dragging.x = Math.min(Math.max(_dragging.stage.mouseX - startX,0),Main.instance.width - 20);
				_dragging.y = Math.min(Math.max(_dragging.stage.mouseY - startY,0),Main.instance.height - 20);
				processGestures();
			}
			if (_takingChemical != null)
			{
				_takingChemical.x = Math.min(Math.max(_takingChemical.stage.mouseX - startX,0),Main.instance.width - 20);
				_takingChemical.y = Math.min(Math.max(_takingChemical.stage.mouseY - startY,0),Main.instance.height - 20);
			}
		}
		
		private static function processGestures() {
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
					if (_dragging is LiquidContainer && ! LiquidContainer(_dragging).empty)
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
					var pouringDialog:PouringDialog=new PouringDialog(
							LiquidContainer(_dragging), LiquidContainer(_receiver));
					pouringDialog.show(function(dlg:PouringDialog) {;
					frozen = false;
					var extracted:Liquid = LiquidContainer(_dragging).pour(dlg.percent/100);
					LiquidContainer(_receiver).addLiquid(extracted);
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

			if (_takingChemical != null)
			{
				var containerCount:Number = Equipment.containers.length;
				var hittedEquipment:Equipment = null;
				for (var i:Number = 0; i<containerCount; i++)
				{
					if (_takingChemical.hitTestObject(Equipment.containers[i]))
					{
						hittedEquipment = Equipment.containers[i];
					}
				}
				if ((hittedEquipment==null)||(!(hittedEquipment is LiquidContainer)))
				{
					removeTakingChemical();
				}
				else
				{
					if (addMatterDialog == null)
					{
						addMatterDialog = new AddMatterDialog();
					}
					frozen = true;
					var theChemical:Chemical = _takingChemical.chemical;
					addMatterDialog.show(function(dlg:AddMatterDialog) {;
					var newMatter:Matter = new Matter(theChemical, dlg.amount);
					LiquidContainer(hittedEquipment).addMatter(newMatter);

					frozen = false;
					}, function(dlb:AddMatterDialog) {;
					frozen = false;
					});
					removeTakingChemical();
				}
			}
		}

		private static function removeTakingChemical()
		{
			_takingChemical.parent.removeChild(_takingChemical);
			_takingChemical = null;
		}

		private static function removeDragging()
		{
			if (_selected == _dragging)
			{
				_selected = null;
			}
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
			return sender is LiquidContainer && receiver is LiquidContainer && !LiquidContainer(sender).empty && sender.x >= receiver.x + receiver.width / 2 - 10 && sender.x < receiver.x + receiver.width && sender.y + sender.height - 30 >= receiver.y;
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
			//trace(dx, dy);
			return Math.abs(dx) < 50 && dy >= 0 && dy < 50;
		}

	}

}