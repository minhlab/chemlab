package chem.environment
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import chem.objects.Equipment;
	import chem.objects.InteractionProvider;
	import chem.objects.LiquidContainer;
	import chem.model.Liquid;
	import chem.model.Chemical;

	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Properties extends MovieClip
	{

		public function Properties()
		{
			this.addEventListener(Event.ENTER_FRAME,updateProperties);
		}
		
		public function updateProperties(e:Event){
			var i:int;
			var selected:Equipment = InteractionProvider.select;
			if (selected is LiquidContainer){
				var liquid:Liquid = LiquidContainer(selected).liquid;
				var s:String="";
				s = appendText(s, liquid.gases);
				s = appendText(s, liquid.solids);
				s = appendText(s, liquid.liquids);
				s = appendText(s, liquid.solutions);
				if (s.length > 0) {
					s = s.substring(0, s.length-2);
				}
				Main.instance.chemicalsDetail.text = s;
				
				Main.instance.reactionsDetail.text = "";
				var reactions:Array = liquid.currentReactions;
				for (i = 0; i< reactions.length; i++){
					Main.instance.reactionsDetail.appendText(reactions[i].toString());
					Main.instance.reactionsDetail.appendText("\n");
				}
				
				Main.instance.conditionsDetail.text = "t = ";
				Main.instance.conditionsDetail.appendText(liquid.temperature.toFixed(2));
				Main.instance.conditionsDetail.appendText(" oC\n");
				Main.instance.conditionsDetail.appendText("p = ");
				Main.instance.conditionsDetail.appendText("1");//get ap suat
				Main.instance.conditionsDetail.appendText(" atm\n");
				Main.instance.conditionsDetail.appendText("V = ");
				Main.instance.conditionsDetail.appendText(liquid.nonGasVolume.toFixed(2));
				Main.instance.conditionsDetail.appendText(" ml");
			}else{
				Main.instance.chemicalsDetail.text = "Chua chon binh dung";
				Main.instance.reactionsDetail.text = "Chua chon binh dung";
				Main.instance.conditionsDetail.text = "t = 25 oC\np = 1 atm\nV = 0 ml";
			}
		}
		
		private function appendText(s:String, matters:Array):String {
			for (var i:int = 0; i< matters.length; i++){
				s += matters[i].chemical.name;
				s += ", ";
			}
			return s;
		}
		
	}
}