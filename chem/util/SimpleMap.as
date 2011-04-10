package chem.util
{

	public class SimpleMap
	{

		private var keys : Array = new Array();
		private var values : Array = new Array();

		public function SimpleMap()
		{
		}

		public function put(key, value)
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

		public function get(key)
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
		
		public function remove(key) {
			var index:int = keys.indexOf(key);
			if (index >= 0)
			{
				keys.splice(index, 1);
				values.splice(index, 1);
			}
		}

	}

}