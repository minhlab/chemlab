package chem.objects
{

	import flash.display.MovieClip;
	import flash.ui.Mouse;


	public class Beaker extends LiquidContainer
	{

		private var _liquidClip:BeakerLiquid= new BeakerLiquid();

		public function Beaker()
		{
			super(500);
			addChildAt(_liquidClip, getChildIndex(front));
			_liquidClip.level = 100;
			_liquidClip.color = 0xFF000000;
			_liquidClip.x = baseLine.x + 7.5;
			_liquidClip.y = baseLine.y + 1;
			var scale:Number = (baseLine.width - 14)/(_liquidClip.width);
			_liquidClip.scaleX = scale;
			_liquidClip.scaleY = scale;
			_liquidClip.level = 0;
		}

		public override function get baseLine():MovieClip
		{
			return _baseLine;
		}

		public override function onLiquidChanged()
		{
			if (liquid.containsLiquids) {
				_liquidClip.level = this.liquid.nonGasVolume / this.volume * BeakerLiquid.MAX_LEVEL;
				_liquidClip.color = this._liquid.color;
			} else {
				_liquidClip.level = 0;
			}
			super.onLiquidChanged();
		}

		protected override function get liquidClip():LiquidClip
		{
			return _liquidClip;
		}

		protected override function get front():MovieClip
		{
			return _front;
		}

		protected override function get back():MovieClip
		{
			return _back;
		}

	}

}