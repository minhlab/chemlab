package chem.environment {
	
	import flash.display.MovieClip;
	import chem.prototype.AbstractPrototype;
	
	
	public class Toolbox extends MovieClip {
		
		private var prototypes : Array = new Array();
		private var childrenWidth : int = 0;
		private var spacing = 6;
		private var margin = 10;
		
		public function Toolbox() {
		}
		
		public function add(p : AbstractPrototype) : int {
			p.y = margin;
			p.x = prototypes.length > 0 ? childrenWidth + spacing : margin;
			childrenWidth = p.x + p.width;
			this.addChild(p);
			return prototypes.push(p) - 1;
		}
		
		public function remove(p:AbstractPrototype) {
			var index = prototypes.indexOf(p);
			if (index >= 0) {
				childrenWidth -= prototypes[index].width + spacing;
				prototypes.slice(index, 1);
			}
		}
		
	}
	
}
