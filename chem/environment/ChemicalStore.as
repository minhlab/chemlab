package chem.environment
{

	import flash.display.MovieClip;
	import chem.prototype.ChemicalPrototype;
	import chem.model.Chemical;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import flash.events.Event;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;


	public class ChemicalStore extends MovieClip
	{

		private var prototypes : Array = new Array();
		private var childrenHeight:int = 0;
		private var spacing = 10;
		private var margin = 5;

		private var startX:Number;
		private var startY:Number;
		private var endX:Number;
		private var moveLeftId:Number = 0;
		private var moveRightId:Number = 0;
		public function ChemicalStore()
		{
			startX = this.x;
			startY = this.y;
			endX = this.x + this.width-30;
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			
		}
		
		public function onMouseOver(e:MouseEvent){
			clearInterval(moveLeftId);
			moveRightId = setInterval(moveRight,1);		
		}
		public function onMouseOut(e:MouseEvent){
			
			clearInterval(moveRightId);
			moveLeftId = setInterval(moveLeft,1);
			
		}
		
		public function moveLeft(){
			if (this.x>startX){
				this.x -= 0.5;
			} else {
				clearInterval(moveLeftId);
			}
		}
		
		public function moveRight(){
			if (this.x<endX){
				this.x += 3;
			} else {
				clearInterval(moveRightId);
			}
		}

		public function add(c : Chemical):int
		{
			var p:ChemicalPrototype = ChemicalPrototype.createPrototype(c);
			p.x = width / 2;
			p.y = prototypes.length > 0 ? childrenHeight + spacing:margin;
			childrenHeight = p.y + p.height;
			this.addChild(p);
			return prototypes.push(p) - 1;
		}

		public function remove(p:Chemical):void
		{
			var index = prototypes.indexOf(p);
			if (index >= 0)
			{
				childrenHeight -=  prototypes[index].height;
				if (index > 0)
				{
					childrenHeight -=  spacing;
				}
				else
				{
					childrenHeight -=  margin;
				}
				prototypes.slice(index, 1);
			}
		}

	}

}