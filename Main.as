package 
{

	import flash.display.MovieClip;
	import chem.objects.CupShape;

	public class Main extends MovieClip
	{
		public function Main()
		{
			for (var i =0;i<100;i++){
				var cup:CupShape = new CupShape();
				this.addChild(cup);
				cup.x = Math.random()*50 + 100;
				cup.y = Math.random()*50 + 200;
				cup.gotoAndPlay(1);
			}
			
		}
	}

}