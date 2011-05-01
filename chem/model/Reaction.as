package chem.model
{

	public class Reaction
	{

		var _reactants:Array = new Array  ;
		var _products:Array = new Array  ;
		var _velocity:Number;
		var _heat:Number;

		public function Reaction()
		{

		}

		public function getReactantCount():int
		{
			return _reactants.length;
		}

		public function getProductCount():int
		{
			return _products.length;
		}

		public function getReactant(index:int):Chemical
		{
			return _reactants[index];
		}

		public function getProduct(index:int):Chemical
		{
			return _products[index];
		}

		public function get velocity()
		{
			return _velocity;
		}

		public function get heat()
		{
			return _heat;
		}

		public function toString():String
		{
			var s:String = "";
			var i:int;
			var chemical:Chemical;
			for (i = 0; i < _reactants.length; i++)
			{
				if (i != 0)
				{
					s +=  " + ";
				}
				chemical = Chemical(_reactants[i]);
				s +=  chemical.name;
			}
			s +=  " --> ";
			for (i = 0; i < _products.length; i++)
			{
				if (i != 0)
				{
					s +=  " + ";
				}
				chemical = Chemical(_reactants[i]);
				s +=  chemical.name;
			}
			if (_heat != 0)
			{
				s +=  heat + "kJ";
			}
			return s;
		}

	}

}