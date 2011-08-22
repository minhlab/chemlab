package chem.objects {
	
	import flash.display.MovieClip;
	import chem.effect.Flames;
	
	
	public class SpriritLampBody extends MovieClip {
		
		private var flame:Flames;
		public function SpriritLampBody() {
			flame = new Flames(bac,0.5,1,2,0);
		}
		
		public function startBurning():void
		{
			if (!this.contains(flame)){
				this.addChildAt(flame,this.getChildIndex(bac)+1);
			}
		}

		public function stopBurning():void
		{
			if (this.contains(flame)){
				this.removeChild(flame);
			}
		}
	}
	
}
