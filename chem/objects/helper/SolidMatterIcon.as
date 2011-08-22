package chem.objects.helper
{

	import flash.display.MovieClip;


	public class SolidMatterIcon extends MovieClip
	{

		private var _volume:Number = 0;

		public function SolidMatterIcon()
		{
			// constructor code
		}

		public function get volume()
		{
			return _volume;
		}
		public function set volume(v:Number)
		{
			_volume = v;
			height = v / (width*width) * 5000;
		}

	}

}