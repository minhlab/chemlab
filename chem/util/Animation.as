package chem.util {
	
	import flash.display.MovieClip;
	
	public final class Animation {

		private static var map : SimpleMap = new SimpleMap();

		public function Animation() {
		}
		
		public static function move(o: MovieClip, destX: Number, destY: Number, time: uint) {
			runAnimation(new MoveAnimation(o, destX, time));
		}
		
		public static function fall(o: MovieClip, destY: Number) {
			runAnimation(new FallAnimation(o, destY));
		}
		
		private static function runAnimation(anim: AbstractAnimation) {
			var anims : Array = map.get(anim.o);
			if (anims == null) {
				anims = new Array();
			}
			anims.push(anim);
			map.put(anim.o, anims);
			anim.run();
		}
		
		public static function stop(o: MovieClip) {
			var anims : Array = map.get(o);
			if (anims != null) {
				for each (var anim in anims) {
					anim.stop();
				}
				map.remove(o);
			}
		}

		static function stopAnim(anim: AbstractAnimation) {
			var anims : Array = map.get(anim.o);
			if (anims != null) {
				var index = anims.indexOf(anim);
				if (index >= 0) {
					anims.slice(index, 1);
				}
			}
		}

	}
	
}
