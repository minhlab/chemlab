package chem.objects {
	
	import flash.display.MovieClip;
	
	
	public class CupShape extends MovieClip {
		
		
		public function CupShape() {
			// constructor code
		}
		
		public function changeLiquidLevel(level){
			if (level>0){
				var liquidBottom:CupLiquidBottom = new CupLiquidBottom();
				this.addChild(liquidBottom);
				liquidBottom.x=3.30;
				liquidBottom.y=48.75;
			}
		}
	}
	
}
