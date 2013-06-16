package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author noogberserk
	 */
	public class DialogBox extends Entity 
	{
		public static var id:DialogBox;
		
		public var textImage:Text;
		public var characterImage:Image;
		public var text:String;
		private var isOpen:Boolean;
		
		public function DialogBox() 
		{
			id = this;
			text = "some text";
			isOpen = true;
			textImage = new Text("", 50, FP.screen.height - 50);
			
			super(0, 0, textImage);
		}
		override public function update():void 
		{
			textImage.text = text;
			if (isOpen) visible = true;
			else visible = false;
			super.update();
		}
		
	}

}