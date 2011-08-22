package chem.model
{

	public class Acid extends Chemical
	{

		private var _root:String;
		private var _valence:int;		

		public function Acid(name:String, aRoot:String, aColor:int, valence:int)
		{
			super(name, aColor, STATE_LIQUID);
			this._root = aRoot;
			this._valence = valence;
		}

		public function get root():String
		{
			return _root;
		}

		public function get valence():int
		{
			return _valence;
		}

	}

}