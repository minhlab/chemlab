package chem.util {
	
	import flash.display.MovieClip;
	
	public final class Animation {

		private static var map : SimpleMap = new SimpleMap();

		public function Animation() {
		}
		
		public static function fall(o: MovieClip, destY: int) {
			stop(o);
			var anim = new FallAnimation(o, destY);
			map.put(o, anim);
			anim.run();
		}
		
		public static function stop(o: MovieClip) {
			var anim = map.get(o);
			if (anim != null) {
				anim.stop();
			}
		}

	}
	
}
