package chem.util
{
	import flash.display.MovieClip;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;

	public class MoveAnimation extends AbstractAnimation
	{

		private var dx:Number;
		private var destX:Number;
		private var time:uint;
		private var dt = 40;
		private var intervalId:uint;

		public function MoveAnimation(o: MovieClip, destX: Number, time: uint)
		{
			super(o);
			this.destX = destX;
			this.time = time;
			dx = (destX-o.x) / time * dt;
		}

		public override function run()
		{
			intervalId = setInterval(function() {
					if( (o.x+dx-destX)*(o.x-destX) <= 0) {
						o.x = destX;
						stop();
					} else {
						o.x += dx;
					}
				}, dt);
		}

		public override function stop()
		{
			super.stop();
			clearInterval(intervalId);
		}

	}

}