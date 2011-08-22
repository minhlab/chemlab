package chem.util
{
	import chem.model.Chemical;
	import fl.controls.progressBarClasses.IndeterminateBar;

	public class ChemicalUtils
	{

		public function ChemicalUtils()
		{
		}

		public static function combine(a:String, av:int, b:String, bv:int)
		{
			if (av == bv)
			{
				return a + b;
			}
			var gcd:int = gcd(av,bv);
			var s:String = a;
			if (bv/gcd != 1) s += (bv/gcd).toString();
			if (av/gcd == 1 && b.charAt(0) == '(') {
				s += b.substring(1, b.length-1);
			} else {
				s += b;
				if (av/gcd != 1) s += (av/gcd).toString();
			}
			return s;
		}

		public static function gcd(a:int, b:int)
		{
			while (b != 0)
			{
				var r:int = a % b;
				a = b;
				b = r;
			}
			return a;
		}

		public static function addAll(a:Array, b:Array)
		{
			for (var i :int=0; i < b.length; i++)
			{
				a.push(b[i]);
			}
		}

	}

}