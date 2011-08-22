package chem.objects {
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class BeakerLiquid extends LiquidClip {
		public static const MAX_LEVEL:Number = 160;
		var _level:Number; //h<=160
		var _color:Number;
				
		public function BreakerLiquid(level:Number=0/*height<160*/,color:Number = 0xFFFFFF00/*color*/) {
			this.level = level;
			this.color = color;
		}
		
		public function updateLevel(){
			var j:int;
			if (this._level<=0){
				for (j = this.numChildren-1; j>=0;j--){
					this.removeChildAt(j);
				}
			}else if ((this._level>0)&&(this._level<=MAX_LEVEL)){
				for (j = this.numChildren-1; j>=0;j--){
					this.removeChildAt(j);
				}
				
				var bottom:liquid_bottom = new liquid_bottom();
				this.addChild(bottom);
				
				bottom.x = 0;
				bottom.y = 0;
				for (var i:Number=1;i<this._level;i++){
					var element:liquid_element = new liquid_element();
					this.addChild(element);
					element.x = 0;
					element.y = -i;
				}
				var top:liquid_top = new liquid_top();
				this.addChild(top);
				top.x = 0;
				top.y = -top.height/2-this._level+1.5;
				
				updateColor();
			}
		}
				
		
		public function updateColor(){
			if (this._level>0){
				//trace((this._color >> 24)&0xFF, (this._color >> 16)&0xFF,(this._color >> 8)&0xFF);
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
