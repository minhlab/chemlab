package chem.objects
{
	import flash.display.MovieClip;

	public class Tube extends LiquidContainer
	{

		private var _liquidClip:TubeLiquid = new TubeLiquid();
		public function Tube()
		{
			super(100);
			addChildAt(_liquidClip, getChildIndex(front));
			_liquidClip.level = 100;
			_liquidClip.color = 0x00FF0000;
			_liquidClip.x = baseLine.x + 2.5;
			_liquidClip.y = baseLine.y - 2;
			var scale:Number = (baseLine.width-5)/(_liquidClip.width);
			_liquidClip.scaleX = scale;
			_liquidClip.scaleY = scale;
			_liquidClip.level = 0;

		}

		public override function get baseLine():MovieClip
		{
			return _baseLine;
		}

		override public function onLiquidChanged()
		{
			if (liquid.containsLiquids)
			{
				_liquidClip.level = this.liquid.nonGasVolume / this.volume * TubeLiquid.MAX_LEVEL;
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