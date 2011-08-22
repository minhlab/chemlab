package chem.model
{

	public class Reaction
	{

		private var _reactants:Array = new Array  ;
		private var _reactantCoefficients:Array=new Array;
		private var _products:Array = new Array  ;
		private var _productCoefficients:Array=new Array;
		var _velocity:Number=0.5;
		var _heat:Number=0;

		public function Reaction()
		{

		}
		
		function addReactant(c:Chemical, x:int=1) {
			_reactants.push(c);
			_reactantCoefficients.push(x);
		}
		
		function addProduct(c:Chemical, x:int=1) {
			_products.push(c);
			_productCoefficients.push(x);			
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

		public function getReactantCoefficient(index:int):int
		{
			return _reactantCoefficients[index];
		}

		public function getProductCoefficient(index:int):int
		{
			return _productCoefficients[index];
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
				if (_reactantCoefficients[i] > 1) {
					s += _reactantCoefficients[i].toString();
				}
				s +=  chemical.name;
			}
			s +=  " = ";
			for (i = 0; i < _products.length; i++)
			{
				if (i != 0)
				{
					s +=  " + ";
				}
				chemical = Chemical(_products[i]);
				if (_productCoefficients[i] > 1) {
					s += _productCoefficients[i].toString();
				}
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