package chem.util {
	import flash.display.MovieClip;
	
	public class AbstractAnimation {

		var o:MovieClip;

		public function AbstractAnimation(o:MovieClip) {
			this.o = o;
		}

		public function run() {
			throw "run() must be overrided by extending class.";
		}

		public function stop() {
			Animation.stopAnim(this);
		}

	}
	
}
