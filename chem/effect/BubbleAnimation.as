package chem.effect{
	
	import flash.display.MovieClip;
	import flash.events.Event;	
	
	public class BubbleAnimation extends MovieClip {
		
		private var _w:Number;
		private var _depth:Number;
		private var _density:Number;
		private var _speed:Number;
		private var _bubbleSize:Number;
		
		public function BubbleAnimation(w:Number,depth:Number,density:Number,speed:Number,bubbleSize:Number) {
			this._w = w;
			this._depth = depth;
			this._density = density;
			this._speed = speed;
			this._bubbleSize = bubbleSize;
			
			
			this.addEventListener(Event.ENTER_FRAME,flowUp);			
		}
		
		function flowUp(evt:Event):void{
			for (var i=0; i<this._density; i++){
				if (Math.random()*100<2){
					var bubble:BubbleAnimationElement = new BubbleAnimationElement(
																				   this._depth, 
																				   (Math.random()*this._bubbleSize/2 + this._bubbleSize), 
																					(Math.random()*this._speed+this._speed)
																					);
					this.addChild(bubble);
					bubble.x = Math.random()*this._w;		
				}
			}
		}
		
		public function get w():Number{
			return this._w;
		}
		public function get depth():Number{
			return this._depth;
		}
		public function get density():Number{
			return this._density;
		}
		public function get speed():Number{
			return this._speed;
		}		
		public function get bubbleSize():Number{
			return this._bubbleSize
		}
		
		public function set w(w:Number){
			this._w = w;
		}
		public function set depth(depth:Number){
			return this._depth = depth;
		}
		public function set density(density:Number){
			return this._density = depth;
		}
		public function set speed(speed:Number){
			return this._speed = speed;
		}
		public function set bubbleSize(bubbleSize:Number){
			return this._bubbleSize = bubbleSize;
		}
	}
	
}
