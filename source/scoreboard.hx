package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.media.Sound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;


class Achievement extends FlxSpriteGroup
{
	var NameThing:FlxText;
	var DescThingy:FlxText;
	var Name:String;
	var Sprites:Array<FlxSprite> = [];

	public function new(yooo:String, desc:String,name:String, dataName:String)
	{
		super();

		var bg:FlxSprite = new FlxSprite(FlxG.width - 400, FlxG.height + 200).makeGraphic(400, 180, 0xFFAEAEAE);
		bg.updateHitbox();
		bg.scrollFactor.set();
		bg.visible = false;
		add(bg);
		FlxTween.tween(bg,{y: FlxG.height - 180},2,{ease: FlxEase.elasticInOut});

		var newSprite:FlxSprite = new FlxSprite(FlxG.width - 400, FlxG.height + 180).loadGraphic(Paths.image('trophies/RuvRonv', 'date-night masses'));
		newSprite.setGraphicSize(Std.int(newSprite.width * 2));
		newSprite.updateHitbox();
		newSprite.scrollFactor.set();
		newSprite.visible = false;
		//Sprites.push(newSprite);
		add(newSprite);
		FlxTween.tween(newSprite,{y: FlxG.height - 180},2,{ease: FlxEase.elasticInOut});

		var name = name;
		trace(name);

		bg.visible = true;
		newSprite.visible = true;

		NameThing = new FlxText(FlxG.width - 270, FlxG.height + 180, 0, yooo, 32);
		NameThing.scrollFactor.set();
		NameThing.setFormat("VCR OSD Mono", 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(NameThing);
		FlxTween.tween(NameThing,{y: FlxG.height - 180},2,{ease: FlxEase.elasticInOut});

		DescThingy = new FlxText(NameThing.x, NameThing.y + 40, 0, desc, 15);
		DescThingy.scrollFactor.set();
		DescThingy.setFormat("VCR OSD Mono", 15, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(DescThingy);
		//FlxTween.tween(DescThingy,{y: FlxG.height - 180},2,{ease: FlxEase.elasticInOut});
		
		new FlxTimer().start(4, function(tmr:FlxTimer)
		{
			FlxTween.tween(newSprite,{y: FlxG.height + 200},2,{ease: FlxEase.elasticInOut});
			FlxTween.tween(bg,{y: FlxG.height + 200},2,{ease: FlxEase.elasticInOut});
			FlxTween.tween(NameThing,{y: FlxG.height + 200},2,{ease: FlxEase.elasticInOut});
			FlxTween.tween(DescThingy,{y: FlxG.height + 200},2,{ease: FlxEase.elasticInOut});

			new FlxTimer().start(4, function(tmr:FlxTimer)
			{
				remove(newSprite);
				remove(bg);
				remove(NameThing);
				remove(DescThingy);
			});
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}