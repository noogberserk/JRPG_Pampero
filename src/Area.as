package  
{
	import flash.net.SharedObject;
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
	public class Area extends World 
	{
		private var player:Player;
		private var sharedOBJ:SharedObject;
		
		[Embed(source="assets/level_1.oel", mimeType="application/octet-stream")]
		public static const DATA:Class;
		private var width:uint;
		private var height:uint;
		
		public function Area() 
		{
			
			//MAP LOADING STUFF
			var xml:XML = FP.getXML(DATA);
			width = xml.@width;
			height = xml.@height;
			
			
			
			add(new Walls(width, height));
			Walls.id.loadFromXML(xml);
			
			
			//player = new Player(180, 160);
			//add(player); 
			
			//TEXT STUFF. SEE LATER
			add(new MyEntity());
			sharedOBJ = SharedObject.getLocal("ld");
			load();
			
			
			loadObjects(xml);
			add( new DialogBox() );
		}
		
		private function loadObjects(data:XML):void 
		{
			//add(new PlayerCar(data.Objects.PlayerCar.@x, data.Objects.PlayerCar.@y));
			//<Entities><Player id="0" x="108" y="32" />
			add( new Player( data.Entities.Player.@x, data.Entities.Player.@y ) );
			for each( var o:Object in data.Entities.NPC ) add( new NPC( o.@x, o.@y ) );
		}
		
		override public function update():void 
		{
			if (Input.pressed(Key.F4)) {
				save()
			}
			super.update();
		}
		
		public function save():void
		{
			var levelData:XML = <level> </level>;
			
			var arrayOfStuff:Array = new Array();
			getClass(Player, arrayOfStuff);
			
			for each(var p:Entity in arrayOfStuff)
			{
				var stuffXML:XML = <stuff />;
				stuffXML.@x = (p.x).toString();
				stuffXML.@y = (p.y).toString();
				levelData.appendChild(stuffXML);
				
			}
			
			var arrayOfText:Array = new Array();
			getClass(MyEntity, arrayOfText);
			
			for each(var e:Entity in arrayOfText) {
				var textXML:XML = <textString />;
				textXML.@text = (e as MyEntity).txt.text;
				textXML.@color = (e as MyEntity).txt.color;
				levelData.appendChild(textXML);
			}
			
			sharedOBJ.data.levelXML = levelData;
			sharedOBJ.flush();
			
			trace(levelData);
		}
		
		public function load():void 
		{
			if (sharedOBJ.data.levelXML != undefined) {
				var arrayOfText:Array = new Array();
				getClass(MyEntity, arrayOfText);
				removeList(arrayOfText);
			}
			else {
				trace("NO SHARED OBJECT!");
			}
			
			var xml: XML = sharedOBJ.data.levelXML;
			
			for each(var entry:XML in xml.textString) {
				MyEntity.id.txt.text = entry.@text;
				MyEntity.id.txt.color = entry.@color;
			}
		}
	}

}