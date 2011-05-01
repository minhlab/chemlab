package chem.objects {
	
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	
	
	public class Beaker extends LiquidContainer {
		
		private var liquidClip:BeakerLiquid= new BeakerLiquid();
		
		public function Beaker() {
			addChildAt(liquidClip, getChildIndex(front));
			updateLevel();
			liquidClip.x = baseLine.x + 7.5;
			liquidClip.y = baseLine.y+1;
			var scale:Number = (baseLine.width - 14)/(liquidClip.width);
			liquidClip.scaleX = scale;
			liquidClip.scaleY = scale;
		}
		
		public override function get baseLine():MovieClip {
			return _baseLine;
		}
		
		private function updateLevel() {
			liquidClip.color = 0xff0000ff;
			liquidClip.level = 120;
		}
		
	}
	
}
