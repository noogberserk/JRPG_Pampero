package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;

	public class MyEntity extends Entity
	{
		public var txt:Text;
		public static var id:MyEntity;
		private var writing:Boolean;
		
		public function MyEntity(textString:String = "")
		{
			id = this;
			txt = new Text(textString);
			graphic = txt;
			txt.y = 5;
			writing = false;
		}

		override public function update():void
		{
			if (Input.pressed(Key.ENTER)) {
				writing = !writing
				txt.color = FP.rand(0xFFFFFF);
			}
			if (Input.pressed(Key.DELETE)) {
				Input.keyString = "";
			}
			
			if (writing) {
				txt.color =  0xFFFFFF;
				txt.text = Input.keyString;
			}
			else {
				Input.keyString = txt.text;
			}
		}
	}
}