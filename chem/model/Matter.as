package chem.model
{

	public class Matter
	{

		private var _chemical:Chemical;
		private var _amount:Number;

		public function Matter(aChemical:Chemical, anAmount:Number)
		{
			_chemical = aChemical;
			_amount = anAmount;
		}

		public function get chemical():Chemical
		{
			return _chemical;
		}

		public function get amount():Number
		{
			return _amount;
		}
		
		public function get volumn():Number {
			return _amount; // TODO: correct ratio
		}

		public function set amount(v:Number)
		{
			_amount = v;
		}

	}

}