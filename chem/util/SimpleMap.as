package chem.util
{

	public class SimpleMap
	{

		private var keys : Array = new Array();
		private var values : Array = new Array();

		public function SimpleMap()
		{
		}

		public function put(key : Object, value : Object)
		{
			var index:int = keys.indexOf(key);
			if (index >= 0)
			{
				values[index] = value;
			}
			else
			{
				keys.push(key);
				values.push(value);
			}
		}

		public function get(key):Object
		{
			var index:int = keys.indexOf(key);
			if (index >= 0)
			{
				return values[index];
			}
			else
			{
				return null;
			}
		}

	}

}