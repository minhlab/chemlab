package chem.objects
{
	import chem.model.Liquid;
	import chem.model.Matter;
	import chem.model.ChemicalProvider;
	import chem.effect.BubbleAnimation;
	import chem.objects.helper.SolidMatterIcon;
	import flash.display.MovieClip;
	import chem.model.Reaction;
	import chem.model.Chemical;

	public class LiquidContainer extends Equipment
	{

		protected var _bubbleEffect:BubbleAnimation;

		protected var _liquid:Liquid ;
		private var _volume:Number=500;
		protected var solidClip:SolidMatterIcon= null;
		protected var hasBubbleOld:Boolean = false;

		public function LiquidContainer(_volume:Number)
		{
			this._volume = _volume;
			_liquid = new Liquid(this);
			addMatter(new Matter(ChemicalProvider.OXYGEN, 0.2*volume));
			addMatter(new Matter(ChemicalProvider.NITROGEN, 0.8*volume));			
			Equipment.addContainer(this);
		}

		public function startStiring():void
		{
			throw "unsupported operation";
		}

		public function stopStiring():void
		{
			throw "unsupported operation";
		}

		public function addMatter(m:Matter){
			_liquid.add(m);
		}

		public function addLiquid(l:Liquid)
		{
			_liquid.mix(l);
		}

		public function clean():void
		{
			_liquid = null;
			onLiquidChanged();
		}

		public function pour(k:Number):Liquid
		{
			return _liquid.extract(k);
		}

		public function get volume():Number
		{
			return _volume;
		}

		public function get liquid():Liquid
		{
			return _liquid;
		}

		public function onLiquidChanged(){
			if (solidClip != null && contains(solidClip)) {
				removeChild(solidClip);
			}
			
			if (liquid.solids.length > 0) {
				if (solidClip == null) {
					solidClip = new SolidMatterIcon();
					solidClip.width = baseLine.width-2;
					solidClip.x = baseLine.x+1;
					solidClip.y = baseLine.y;
				}
				var backIndex:int = getChildIndex(back);
				var solidVolume:Number=0;
				var i, j:int;
				for (i = 0; i < liquid.solids.length; i++) {
					solidVolume += Matter(liquid.solids[i]).volumn;
				}
				solidClip.volume = solidVolume;
				addChildAt(solidClip, backIndex+1);
			}
			
			var hasBubble:Boolean = computeHasBubble();
			if (hasBubble != hasBubbleOld) {
				if (hasBubble) {
					startBubble();
				} else {
					stopBubble();
				}
				hasBubbleOld = hasBubble;
			}
			if (hasBubble) {
				_bubbleEffect.depth = liquidClip.height-(height-baseLine.y-8);
			}
		}

		private function computeHasBubble():Boolean {
			for (var i = 0; i < liquid.currentReactions.length; i++) {
				var reaction:Reaction=Reaction(liquid.currentReactions[i]);
				for (var j = 0; j <reaction.getProductCount(); i++) {
					if (reaction.getProduct(j).state == Chemical.STATE_GAS) {
						return true;
					}
				}
			}
			return false;
		}

		public function get empty():Boolean
		{
			return !liquid.containsNonGas;
		}

		protected function startBubble() {
			fullBubble(10, 4, 5);
		}
		
		public function fullBubble(density:Number,speed:Number,bubbleSize:Number){
			if (_bubbleEffect != null && this.contains(_bubbleEffect)){
				this.removeChild(_bubbleEffect);
			}
			//trace(baseLine.width,liquidClip.height);
			_bubbleEffect = new BubbleAnimation(baseLine.width-24,liquidClip.height-(height-baseLine.y-8),density,speed,bubbleSize);
			_bubbleEffect.x = baseLine.x+8;
			_bubbleEffect.y = baseLine.y;
			this.addChildAt(_bubbleEffect, numChildren-1);
			//this.addChild(_bubbleEffect);
		}
		
		private function pointBubble(locationX:Number,locationY:Number,density:Number,speed:Number,bubbleSize:Number){
			if (_bubbleEffect != null && this.contains(_bubbleEffect)){
				this.removeChild(_bubbleEffect);
			}
			_bubbleEffect = new BubbleAnimation(10,liquidClip.height,density,speed,bubbleSize);
			_bubbleEffect.x = locationX;
			_bubbleEffect.y = locationY;
			this.addChildAt(_bubbleEffect, numChildren-1);
		}

		private function stopBubble(){
			if (_bubbleEffect != null && this.contains(_bubbleEffect)){
				this.removeChild(_bubbleEffect);
			}
		}

		protected function get liquidClip():LiquidClip
		{
			throw "get liquidClip must be overriden";
		}

		protected function get front():MovieClip
		{
			throw "get front must be overriden";
		}

		protected function get back():MovieClip
		{
			throw "get front must be overriden";
		}

	}

}