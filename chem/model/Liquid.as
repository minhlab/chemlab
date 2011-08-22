package chem.model
{
	import chem.objects.LiquidContainer;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import chem.util.Color;
	import flash.utils.setTimeout;
	import chem.util.ChemicalUtils;

	public class Liquid
	{

		public static var roomTemperature:Number = 25;
		private var _temperature:Number = roomTemperature;
		private var _container:LiquidContainer = null;
		private var _boilingPoint = 100;
		private var _coolingVelocity:Number = 1;
		private var _color:int;

		private var _nonGasVolume:Number = 0;

		private var _liquids:Array = new Array  ;
		private var _solutions:Array = new Array  ;
		private var _gases:Array = new Array  ;
		private var _solids:Array = new Array  ;

		public var currentReactions:Array = new Array  ;

		private var reactionProvider:ReactionProvider = new ReactionProvider  ;

		public function Liquid(c:LiquidContainer)
		{
			_container = c;
			setInterval(processReactions,40);
		}

		public function add(m:Matter)
		{
			if (m.amount <= 0) {
				return;
			}
			if (m.chemical.state != Chemical.STATE_GAS) {
				_temperature = (_temperature * nonGasVolume + 
								roomTemperature * m.volumn) / (nonGasVolume + m.volumn);
			}
			changeMatter(m);
			fireOnLiquidChanged();
		}

		private function changeMatter(m:Matter) {
			switch (m.chemical.state)
			{
				case Chemical.STATE_SOLID :
					if (containsLiquids && m.chemical.dissolvable > 0)
					{
						addMatterTo(solutions,m);
					}
					else
					{
						addMatterTo(solids,m);
					}
					break;
				case Chemical.STATE_LIQUID :
					var old:Boolean = containsLiquids;
					addMatterTo(liquids,m);
					if (containsLiquids != old)
					{
						for (var i:int = solids.length - 1; i >= 0; i--)
						{
							if (Matter(solids[i]).chemical.dissolvable > 0)
							{
								solutions.push(solids[i]);
								solids.slice(i,1);
							}
						}
					}
					break;
				case Chemical.STATE_GAS :
					addMatterTo(gases,m);
					break;
			}
		}

		private function addMatterTo(a:Array,m:Matter)
		{
			var i:int;
			for (i = 0; i < a.length; i++)
			{
				var ai:Matter = Matter(a[i]);
				if (ai.chemical == m.chemical)
				{
					ai.amount +=  m.amount;
					if (ai.amount <= 0) {
						a.splice(i, 1);
						return;
					}
					break;
				}
			}
			if (i >= a.length)
			{
				a.push(m);
			}
		}

		private function addAllMatters(a:Array,b:Array)
		{
			var i:int;
			for (i = 0; i < b.length; i++)
			{
				addMatterTo(a,b[i]);
			}
		}

		/**
		 * Mix two liquids together
		 */
		public function mix(l:Liquid):void
		{
			addAllMatters(_liquids,l._liquids);
			addAllMatters(_solids,l._solids);
			addAllMatters(_solutions,l._solutions);
			addAllMatters(_gases,l._gases);
			fireOnLiquidChanged();
		}

		/**
		 * Extract a part of this liquid to form another liquid
		 * TODO extract
		 */
		public function extract(k:Number):Liquid
		{
			if (k <= 0 || k > 1)
			{
				throw "invalid extracting ratio: " + k;
			}
			var extracted:Liquid = new Liquid(null);
			extractAllMatters(extracted,liquids,k);
			extractAllMatters(extracted,solutions,k);
			extractAllMatters(extracted,solids,k);
			extractAllMatters(extracted,gases,k);
			fireOnLiquidChanged();
			return extracted;
		}

		private function extractAllMatters(receiver:Liquid,matters:Array,k:Number):void
		{
			for (var i:int = 0; i < matters.length; i++)
			{
				var m1:Matter = Matter(matters[i]);
				var m2:Matter = new Matter(m1.chemical,m1.amount * k);
				m1.amount *= (1-k);
				receiver.add(m2);
			}
		}

		private var cooledId:uint;

		protected function fireOnLiquidChanged()
		{
			_color = computeColor();
			_nonGasVolume = computeNonGasVolume();
			updateReactions();
			if (_temperature > roomTemperature)
			{
				if (cooledId <= 0)
				{
					cooledId = setInterval(cooled,40);
				}
			}
			else
			{
				if (cooledId > 0)
				{
					clearInterval(cooledId);
				}
			}
			if (_container != null)
			{
				_container.onLiquidChanged();
			}
		}

		public function processReactions()
		{
			if (currentReactions.length <= 0) {
				return;
			}
			var i, j:int;
			for (i = 0; i < currentReactions.length; i++)
			{
				var reaction:Reaction = Reaction(currentReactions[i]);
				for (j = 0; j < reaction.getReactantCount(); j++) {
					changeMatter(new Matter(reaction.getReactant(j), 
								   -reaction.getReactantCoefficient(i)*reaction.velocity));
				}
				for (j = 0; j < reaction.getProductCount(); j++) {
					changeMatter(new Matter(reaction.getProduct(j), 
								   reaction.getProductCoefficient(i)*reaction.velocity));
				}
			}
			fireOnLiquidChanged();
		}

		private function updateReactions()
		{
			currentReactions = new Array  ;
			if (liquids.length <= 0)
			{
				var dry:Array = new Array  ;
				ChemicalUtils.addAll(dry, solids);
				ChemicalUtils.addAll(dry, gases);
				ChemicalUtils.addAll(currentReactions, reactionProvider.getReactions(dry,temperature));
			}
			else
			{
				var wet:Array = new Array  ;
				ChemicalUtils.addAll(wet, solids);
				ChemicalUtils.addAll(wet, solutions);
				ChemicalUtils.addAll(wet, liquids);
				ChemicalUtils.addAll(currentReactions, reactionProvider.getReactions(wet,temperature));
			}
		}

		private var burningVelocity;

		public function burn(heat:Number)
		{
			if (containsNonGas)
			{
				_temperature +=  heat / nonGasVolume;
				if (_temperature > boilingPoint) {
					_temperature = boilingPoint;
				}
				fireOnLiquidChanged();
			}
		}

		private function cooled()
		{
			if (containsNonGas) {
				_temperature -=  _coolingVelocity / nonGasVolume * 
				(_temperature - roomTemperature) / roomTemperature;
				if (_temperature < roomTemperature)
				{
					_temperature = roomTemperature;
				}
			} else {
				_temperature = roomTemperature;
			}
			fireOnLiquidChanged();
		}

		public function get temperature():Number
		{
			return _temperature;
		}

		public function get boilingPoint():Number
		{
			return _boilingPoint;
		}

		private function computeColor():int
		{
			var r:Number = 0;
			var g:Number = 0;
			var b:Number = 0;
			var totalAmount:Number = 0;
			var i:int;
			var m:Matter;
			var c:Color;
			for (i = 0; i < liquids.length; i++)
			{
				m = Matter(liquids[i]);
				c = Color.fromValue(m.chemical.color);
				if (c.a > 0) {
					r +=  c.r * m.amount;
					g +=  c.g * m.amount;
					b +=  c.b * m.amount;
					totalAmount +=  m.amount;
				}
			}
			for (i = 0; i < solutions.length; i++)
			{
				m = Matter(solutions[i]);
				c = Color.fromValue(m.chemical.color);
				if (c.a > 0) {
					r +=  c.r * m.amount;
					g +=  c.g * m.amount;
					b +=  c.b * m.amount;
					totalAmount +=  m.amount;
				}
			}
			if (totalAmount == 0)
			{
				return 0xffffff00;
			}
			var ri:int = Math.min(255,Math.max(0,r / totalAmount));
			var gi:int = Math.min(255,Math.max(0,g / totalAmount));
			var bi:int = Math.min(255,Math.max(0,b / totalAmount));
			return Color.fromRgb(ri,gi,bi).value;
		}

		public function get color()
		{
			return _color;
		}

		public function get liquids():Array
		{
			return _liquids;
		}

		public function get solids():Array
		{
			return _solids;
		}

		public function get solutions():Array
		{
			return _solutions;
		}

		public function get gases():Array
		{
			return _gases;
		}

		public function get container():LiquidContainer
		{
			return _container;
		}

		private function computeNonGasVolume():Number
		{
			var v:Number = 0;
			var i:int;
			for (i = 0; i < liquids.length; i++)
			{
				v +=  Matter(liquids[i]).volumn;
			}
			for (i = 0; i < solids.length; i++)
			{
				v +=  Matter(solids[i]).volumn;
			}
			return v;
		}

		public function get nonGasVolume():Number
		{
			return _nonGasVolume;
		}

		public function get containsNonGas():Boolean
		{
			return (liquids.length > 0 || solids.length > 0);
		}

		public function get containsLiquids():Boolean
		{
			return liquids.length > 0;
		}

	}

}