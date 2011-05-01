package chem.model
{

	public class Chemical
	{

		public static var STATE_SOLID:int = 1;
		public static var STATE_LIQUID:int = 2;
		public static var STATE_GAS:int = 3;
		public static var STATE_PLASMA:int = 4;

		private var _name:String = "";
		private var _color:int = 0xc0c0c0ff;
		private var _state:int;

		public function Chemical(aName:String, aColor:int, aState:int)
		{
			this._name = aName;
			this._color = aColor;
			this._state = aState;
		}

		public function get color():int
		{
			return _color;
		}

		public function get state():int
		{
			return _state;
		}

		public function get name():String
		{
			return _name;
		}

		public function get formula():String
		{
			return name;
		}

		public function toString():String
		{
			return name;
		}

	}

}