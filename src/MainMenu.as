package  
{
	import flash.events.TextEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class MainMenu extends World 
	{
		//Definir MenuButton class
		//Es un entity con un text que es seleccionable al clickearlo y spawnea un nuevo World.
		private var startButton:Text;
		private var soundButton:Text;
		private var soundBool:Boolean;
		private var title:Text;
		private var selection:uint = 0;
		private const selectedColor:uint = 0x779438;
		private const entryColor:uint = 0xffffff;
		
		private var player:Player;
		
		public function MainMenu() 
		{
			startButton = new Text("New Game");
			soundButton = new Text("Sound: On");
			title = new Text("Pampero");
			soundBool = true;
			player = new Player();
		}
		
		override public function begin():void
		{
			title.size = 48;
			title.x = FP.screen.width / 2 - title.width / 2;
			title.y = 20;
			startButton.x = FP.screen.width / 2 - startButton.width / 2;
			startButton.y = FP.screen.height - 120;
			soundButton.x = FP.screen.width / 2 - soundButton.width / 2;
			soundButton.y = startButton.y + 40;
			
			addGraphic(startButton);
			addGraphic(soundButton);
			addGraphic(title);
			player.x = 185;
			player.y = 105;
			//add(player);
		}
		override public function update():void
		{
			if (selection == 0)
			{
				startButton.color = selectedColor;
				soundButton.color = entryColor;
			}
			else if (selection == 1) 
			{
				startButton.color = entryColor;
				soundButton.color = selectedColor;
			}
			
			if (Input.pressed(Key.DOWN) || Input.pressed(Key.UP)) {
				selection++;
			}
			
			if (Input.pressed(Key.ENTER) || Input.pressed(Key.SPACE)) {
				if (selection == 0) {
					FP.world = new Area();
				}
				else if (selection == 1)
				{
					soundBool = !soundBool;
				}
			}
			
			if (selection > 1) selection = 0;
			if (soundBool) soundButton.text = "Sound: On";
			else soundButton.text = "Sound: Off";
			
			super.update();
			
		}
	}

}