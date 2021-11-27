package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class RuvDeath extends FlxSprite
{
	var tex:FlxAtlasFrames;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		tex = Paths.getSparrowAtlas('characters/deadRuv', 'shared');
		frames = tex;
		animation.addByPrefix('firstDeath', 'deadRuv firstDeath', 24);
		animation.addByPrefix('deathLoop', 'deadRuv deathLoop', 24);
		animation.addByPrefix('deathConfirm', 'deadruv deathConfirm', 24);

		playAnim('firstDeath');
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);
	}
}
