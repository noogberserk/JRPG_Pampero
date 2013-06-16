package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author noogberserk
	 */
	public class Player extends Entity 
	{
		[Embed(source = 'assets/rudy_walk.png')]
		private const PLAYER:Class;
		
		private var sprPlayer:Spritemap;
		private var frameRate:uint = 2;
		private var isMoving:Boolean;
		private var moveSpeed:uint = 30;
		private var direction:Point;
		private var nextPosition:Point;
		
		private var traceText:Text;
		
		public function Player(x:uint = 0, y:uint = 0) 
		{
			sprPlayer = new Spritemap(PLAYER, 18, 32);
			
			sprPlayer.add("front", [0, 1, 2, 1], frameRate, true);
			sprPlayer.add("left", [3, 4, 5, 4], frameRate, true);
			sprPlayer.add("back", [6, 7, 8, 7], frameRate, true);
			sprPlayer.add("right", [9, 10, 11, 10], frameRate, true);
			
			graphic = sprPlayer;
			graphic.y = -16;
			setHitbox(18, 16);
			
			type = "player";
			isMoving = false;
			sprPlayer.play("front");
			direction = new Point();
			nextPosition = new Point();
			traceText = new Text("", 0, 10);
			addGraphic(traceText);
			
			super(x, y);
		}
		private function getNextPosition(directionX:int, directionY:int):Point {
			return new Point(x + 18 * directionX, y + 16 * directionY);
		}
		
		override public function update():void 
		{
			if ( Input.pressed(Key.DOWN) ) {
				if ( direction.y == 1 ) {
					isMoving = true;
					nextPosition = getNextPosition(direction.x, direction.y);
				}
				else {
					direction = new Point(0, 1);
					isMoving = false;
				}
				sprPlayer.play("front", true);
			}
			if ( Input.pressed(Key.UP) ) {
				if ( direction.y == -1 ) {
					isMoving = true;
					nextPosition = getNextPosition(direction.x, direction.y);
				}
				else {
					direction = new Point(0, -1);
					isMoving = false;
				}
				sprPlayer.play("back", true);
			}
			if ( Input.pressed(Key.RIGHT) ) {
				if ( direction.x == 1 ) {
					isMoving = true;
					nextPosition = getNextPosition(direction.x, direction.y);
				}
				else {
					direction = new Point(1, 0);
					isMoving = false;
				}
				
				sprPlayer.play("right", true);
			}
			if ( Input.pressed(Key.LEFT) ) {
				if ( direction.x == -1 ) {
					isMoving = true;
					nextPosition = getNextPosition(direction.x, direction.y);
				}
				else {
					direction = new Point( -1, 0);
					isMoving = false;
				}
				sprPlayer.play("left", true);
			}
			
			if (isMoving) {
				x += direction.x;
				y += direction.y;
				
				if ( collide("walls", x, y) || collide("npc", x, y) ) {
					x -= direction.x;
					y -= direction.y;
					isMoving = false;
				}
				
				
				if (direction.y > 0 && y >= nextPosition.y) {
					isMoving = false;
				}
				else if (direction.y < 0 && y <= nextPosition.y) {
					isMoving = false;
				}
				if (direction.x > 0 && x >= nextPosition.x) {
					isMoving = false;
				}
				if (direction.x < 0 && x <= nextPosition.x) {
					isMoving = false;
				}
				
			}
			
			
			
			traceText.text = 
			direction.toString() + 
			"\n" + isMoving.toString() +
			"\n" + nextPosition.toString();
			
			if ( collide("npc", x + direction.x, y + direction.y) ) {
				if ( Input.pressed(Key.Z) ) {
					MyEntity.id.txt.text = "Chateando con jack";
				}
			}
			
			super.update();
		}
	}

}