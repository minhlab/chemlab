package chem.util
{
	import flash.display.MovieClip;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;

	public class FallAnimation extends AbstractAnimation
	{

		private var dyMax = 17,dy1 = 50,dy2 = 25;
		private var dt = 40; // (ms)
		private var y0:Number,y1:Number,y2:Number,y3:Number;
		private var i:int = 0,k:int = 0;
		private var phraseId:uint;

		public function FallAnimation(o: MovieClip, destY : Number)
		{
			super(o);
			if (o.y > destY)
			{
				throw "Invalid argument: the object is below destination y coordinate.";
			}

			// parameters
			y0 = o.y;
			y3 = destY;
			// special positions
			if (y0 + dy1 + dy2 < y3)
			{
				y1 = y0 + dy1;
				y2 = y3 - dy2;
			}
			else
			{
				y1 = y2 = (y0 + dy1 + y3 - dy2)/2;
				dyMax *= (y1 - y0) / dy1;
			}
			//trace(y0 + ", " + y1 + ", " + y2 + ", " + y3);
		}

		public override function run()
		{
			//trace(o.y);
			phraseId = setInterval(phrase1,dt);
		}

		public override function stop()
		{
			super.stop();
			clearInterval(phraseId);
			//trace(id + " stoped.");
		}

		private function phrase1()
		{
			o.y += dyMax * dyMax / 4 / dy1 * (2*i + 1);
			i++;
			//trace(o.y);

			if (o.y >= y1)
			{
				clearInterval(phraseId);
				o.y = y1;
				if (o.y < y2)
				{
					phraseId = setInterval(phrase2,dt);
				} else
				{
					phraseId = setInterval(phrase3,dt);
				}
			}
		}

		private function phrase2()
		{
			o.y +=  dyMax;
			//trace(o.y);

			if (o.y >= y2)
			{
				clearInterval(phraseId);
				o.y = y2;
				if (o.y < y3) {
					phraseId = setInterval(phrase3,dt);
				}
			}
		}

		private function phrase3()
		{
			var dy = dyMax - dyMax * dyMax / 4 / dy2 * (2*k + 1)
			if (dy > 0) {
				o.y += dy;
				k++;
			}
			//trace(o.y);

			if (dy <= 0 || o.y >= y3)
			{
				o.y = y3;
				stop();
			}
		}

	}

}