package chem.environment
{

	import flash.display.MovieClip;
	import chem.prototype.ChemicalPrototype;
	import chem.model.Chemical;


	public class ChemicalStore extends MovieClip
	{

		private var prototypes : Array = new Array();
		private var childrenHeight:int = 0;
		private var spacing = 15;
		private var margin = 10;

		public function ChemicalStore()
		{
		}

		public function add(c : Chemical):int
		{
			var p:ChemicalPrototype = ChemicalPrototype.createPrototype(c);
			p.x = width / 2;
			p.y = prototypes.length > 0 ? childrenHeight + spacing:margin;
			childrenHeight = p.y + p.height;
			this.addChild(p);
			return prototypes.push(p) - 1;
		}

		public function remove(p:Chemical):void
		{
			var index = prototypes.indexOf(p);
			if (index >= 0)
			{
				childrenHeight -=  prototypes[index].height;
				if (index > 0)
				{
					childrenHeight -=  spacing;
				}
				else
				{
					childrenHeight -=  margin;
				}
				prototypes.slice(index, 1);
			}
		}

	}

}