package chem.model
{

	public class ReactionProvider
	{

		public function ReactionProvider()
		{
			// constructor code
		}

		public function getReactions(reactants:Array, temperature:int):Array
		{
			var reactions:Array = new Array  ;
			reactions.concat(getMetalAcidReactions(reactants, temperature));
			reactions.concat(getOxydationReactions(reactants, temperature));
		}

		private function getOxydationReactions(reactants:Array, temperature:int):Array
		{
			var reactions:Array = new Array  ;
			var i;
			if (reactants.indexOf(ChemicalProvider.OXYGEN) >= 0)
			{
				for (i = 0; i < reactants.length; i++)
				{
					if (reactants[i] is Metal)
					{
						var metal:Metal = Metal(reactants[i]);
						if (temperature > 300)
						{
							var reaction:Reaction = new Reaction();
							reaction._reactants.push(metal, ChemicalProvider.OXYGEN);
							reaction._products.push(new Oxide(metal, metal.defaultValence, metal.color));
							reaction._heat = 1000;
							reactions.push(reaction);
						}
					}
				}
			}
			return reactions;
		}

		private function getMetalAcidReactions(reactants:Array, temperature:int):Array
		{
			var reactions:Array = new Array  ;
			var i,j:int;
			for (i = 0; i < reactants.length; i++)
			{
				if (reactants[i] is Metal)
				{
					for (j = 0; j < reactants.length; j++)
					{
						if (reactants[j] is Acid)
						{
							var metal:Metal = Metal(reactants[i]);
							var acid:Acid = Acid(reactants[j]);
							var color = metal.color;

							var reaction:Reaction = new Reaction();
							reaction._reactants.push(metal, acid);
							reaction._products.push(ChemicalProvider.HIDRO);
							reaction._products.push(new Salt(metal, acid, color));
							reactions.push(reaction);
						}
					}
				}
			}
			return reactions;
		}

	}

}