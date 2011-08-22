package chem.effect{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class BubbleAnimationElement extends MovieClip {
		
		private var _depth:Number;
		private var _size:Number;
		
		private var _speed:Number;
		private var _bubble:BubleShape;
		
		public function BubbleAnimationElement(depth:Number,size:Number,speed:Number) {
			this._depth = depth;
			this._size = size;
			this._speed = speed;
			
			this._bubble = new BubleShape();
			this.addChild(_bubble);
			
			_bubble.scaleX = _bubble.scaleY = this._size/35;
			_bubble.y=0;
			_bubble.x=0;
			
			this.addEventListener(Event.ENTER_FRAME,flowUp);	
			play();
		}
		
		function flowUp(evt:Event):void{
			this._bubble.y -= this._speed;
			if (this._bubble.y < (-this._depth)) 
			{
				this.removeChild(this._bubble);
				this.removeEventListener(Event.ENTER_FRAME,flowUp);
				this.parent.removeChild(this);
			}
		}
		
		public function get depth():Number{
			return this._depth;
		}
		public function get size():Number{
			return this._size;
		}
		public function get speed():Number{
			return this._speed;
		}
		
		
		public function set depth(depth:Number){
			return this._depth = depth;
		}
		public function set size(size:Number){
			return this._size = size;
		}
		public function set speed(speed:Number){
			return this._speed = speed;
		}
	}
	
}
