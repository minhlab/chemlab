package chem.model
{

	public class Acid extends Chemical
	{

		private var _root:String;

		public function Acid(name:String, aRoot:String, aColor:int)
		{
			super(name, aColor, STATE_LIQUID);
			this._root = aRoot;
		}

		public function get root():String
		{
			return _root;
		}

	}

}