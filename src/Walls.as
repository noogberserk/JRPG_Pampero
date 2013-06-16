package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Walls extends Entity 
	{
		public static var id:Walls;
		private var _map:Tilemap;
		private var _grid:Grid;
		[Embed(source = "assets/walls.png")]
		private const TILESET:Class;
		
		public function Walls(width:uint, height:uint) 
		{
			id = this;
			type = "walls";
			setHitbox(width, height);
			
			_map = new Tilemap(TILESET, width, height, GC.TILE_WIDTH, GC.TILE_HEIGHT);
			addGraphic(_map);
			
			mask = _grid = new Grid(width, height, GC.TILE_WIDTH, GC.TILE_HEIGHT);
			super(0, 0);
		}
		
		public function loadFromXML(data:XML):void 
		{
			for each(var o:Object in data.Solids.tile) {
				_map.setTile(o.@x, o.@y, 0);
				_grid.setTile(o.@x, o.@y, true);
			}
		}
		
	}

}