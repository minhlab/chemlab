package chem.model
{

	public class Metal extends Chemical
	{
		private var _defaultValence:int;

		public function Metal(name:String, aValence:int, aColor:int)
		{
			super(name, aColor,STATE_SOLID);
			_defaultValence = aValence;
		}

		public function get defaultValence():int
		{
			return _defaultValence;
		}

	}

}