package chem.objects {
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	public class TubeLiquid extends MovieClip {
		
		var _level:Number; //h<=160
		var _color:Number;
		public function TubeLiquid(level:Number/*height<160*/,color:Number = 0xFFFFFF00/*color*/) {
			this.level = level;
			this.color = color;
		}
		
		public function updateLevel(){
			if ((this._level>0)&&(this._level<=220)){
				for (var j:Number = this.numChildren-1; j>=0;j--){
					this.removeChildAt(j);
				}
				
				var bottom:tube_liquid_bottom = new tube_liquid_bottom();
				this.addChild(bottom);
				
				bottom.x = 0;
				bottom.y = 0-0.5;
				for (var i:Number=1;i<this._level;i++){
					var element:tube_liquid_element = new tube_liquid_element();
					this.addChild(element);
					element.x = 0;
					element.y = -i;
				}
				var top:tube_liquid_top = new tube_liquid_top();
				this.addChild(top);
				top.x = 0;
				top.y = -top.height/2-this._level+1.5;
				
				updateColor();
			}
		}
				
		
		public function updateColor(){
			if (this._level>0){
				var colorTransform:ColorTransform = new ColorTransform(1,1,1,1,(((this._color >> 24)&0xFF)-0xFF),(((this._color >> 16)&0xFF)-0xFF),(((this._color >> 8)&0xFF)-0xFF),0);
				this.transform.colorTransform=colorTransform;
			}
		}
		
		public function set level(level:Number){
			this._level = level;
			updateLevel();
		}
		
		public function set color(color:Number){
			this._color = color;			
			updateColor();
		}
	}
	
}
