package chem.util {
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.display.MovieClip;
	
	public class GuiUtils {

		public function GuiUtils() {
			// constructor code
		}

		public static function changeParent(e:MovieClip, p:MovieClip):void {
			var ep :Point = e.parent.localToGlobal(new Point(e.x, e.y));
			var mp :Point = p.parent.localToGlobal(new Point(p.x, p.y));
			e.x = ep.x - mp.x;
			e.y = ep.y - mp.y;
			e.parent.removeChild(e);
			p.addChild(e);
		}

	}
	
}
