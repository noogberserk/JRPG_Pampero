package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class NPC extends Entity 
	{
		[Embed(source = 'assets/npc.png')]
		private const NPC_IMAGE:Class;
		private var sprNPC:Image;
		
		
		public function NPC(x:uint, y:uint) 
		{
			sprNPC = new Image(NPC_IMAGE);
			graphic = sprNPC;
			graphic.y = -16;
			setHitbox(18, 16);
			
			type = "npc";
			
			super(x, y)
		}
		
	}

}