package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine
	{
		public function Main():void
		{
			super(414, 320, 60, false);
		}
		
		override public function init():void 
		{
			trace("FlashPunk " + FP.VERSION + " started!");
			FP.screen.scale = 2;
			FP.world = new MainMenu()//TestWorld();
			FP.screen.color = 0x3b3b3d;
			FP.console.enable();
		}
	}
	
	
}