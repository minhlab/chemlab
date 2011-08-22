package chem.util
{
	import flash.globalization.Collator;

	public class Color
	{

		private var _v:int;

		public static function fromValue(v:int):Color
		{
			var c:Color = new Color  ;
			c._v = v;
			return c;
		}

		public static function fromRgb(r:int, g:int, b:int):Color
		{
			var c:Color = new Color  ;
			c._v = r << 24 + g << 16 + b << 8 + 0xff;
			return c;
		}

		public function get value()
		{
			return _v;
		}

		public function get red():uint
		{
			return (_v >> 24)&0xff;
		}

		public function get green():uint
		{
			return (_v >> 16)&0xff;
		}

		public function get blue():uint
		{
			return (_v >> 8)&0xff;
		}

		public function get r():uint
		{
			return red;
		}

		public function get g():uint
		{
			return green;
		}

		public function get b():uint
		{
			return blue;
		}
		
		public function get alpha():uint {
			return _v & 0xff;
		}

		public function get a():uint
		{
			return alpha;
		}

	}

}