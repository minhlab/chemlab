package chem.model
{
	import chem.util.ChemicalUtils;

	public class ReactionProvider
	{

		public function ReactionProvider()
		{
			// constructor code
		}

		public function getReactions(reactants:Array, temperature:int):Array
		{
			var reactions:Array = new Array  ;
			ChemicalUtils.addAll(reactions, getMetalAcidReactions(reactants, temperature));
			ChemicalUtils.addAll(reactions, getOxydationReactions(reactants, temperature));
			ChemicalUtils.addAll(reactions, getBoilingReaction(reactants, temperature));
			return reactions;
		}

		private function getOxydationReactions(reactants:Array, temperature:int):Array
		{
			var reactions:Array = new Array  ;
			var i,j:int;
			for (i = 0; i < reactants.length; i++)
			{
				if (Matter(reactants[i]).chemical == ChemicalProvider.OXYGEN)
				{
					for (j = 0; j < reactants.length; j++)
					{
						if (Matter(reactants[j]).chemical is Metal)
						{
							var metal:Metal = Metal(Matter(reactants[j]).chemical);
							if (temperature > 300)
							{
								var reaction:Reaction = new Reaction();
								reaction.addReactant(metal);
								reaction.addReactant(ChemicalProvider.OXYGEN);
								reaction.addProduct(ChemicalProvider.getOxide(metal));
								reaction._heat = 1000;
								reactions.push(reaction);
							}
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
				if (Matter(reactants[i]).chemical is Metal)
				{
					for (j = 0; j < reactants.length; j++)
					{
						if (Matter(reactants[j]).chemical is Acid)
						{
							var metal:Metal = Metal(Matter(reactants[i]).chemical);
							var acid:Acid = Acid(Matter(reactants[j]).chemical);
							var color = metal.color;

							var reaction:Reaction = new Reaction();
							reaction.addReactant(metal);
							reaction.addReactant(acid);
							reaction.addProduct(ChemicalProvider.HIDRO);
							reaction.addProduct(ChemicalProvider.getSalt(metal, acid));
							reactions.push(reaction);
						}
					}
				}
			}
			return reactions;
		}

		private function getBoilingReaction(reactants:Array, temperature:int):Array
		{
			var reactions:Array = new Array  ;
			var i:int;
			for (i = 0; i < reactants.length; i++)
			{
				var matter:Matter = Matter(reactants[i]);
				if (matter.chemical == ChemicalProvider.WATER_LIQUID &&
				temperature >= matter.chemical.boilingPoint-1)
				{
					var reaction:Reaction = new Reaction();
					reaction.addReactant(matter.chemical);
					reaction.addProduct(ChemicalProvider.WATER_VAPOR);
					reactions.push(reaction);
				}
			}
			return reactions;
		}

	}

}