package;

import openfl.ui.Mouse;
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
import GameJolt;


class Achievement extends FlxSpriteGroup
{
	var NameThing:FlxText;
	var DescThingy:FlxText;
	var Name:String;
	var Sprites:Array<FlxSprite> = [];

	public var trophyName:String;
	public var description:String;
	public var name:String;

	public function new(dataName:String, NBtrophy:Int)
	{
		trace("not yet");
		super();
		if (GameJoltAPI.getStatus() && KadeEngineData.trophies_unlocked[NBtrophy] == false) {
			trace("got in");
			trophyName = dataName;

			switch(trophyName){
				case 'A New World':
					FlxG.save.data.trophy1 = true;
					description = "Congratulation for opening the DNM mod for the first time !\nAnd thank you for downloading it !!";
					name = "RuvRonv";
					GameJoltAPI.getTrophy(148519);
					trace("get that trophy");
				case 'Happy ending':
					FlxG.save.data.trophy2 = true;
					description = "You have beaten the story mode !!";
					name = "RuvRonv";
					GameJoltAPI.getTrophy(148567);
				case 'Best Team':
					FlxG.save.data.trophy3 = true;
					description = "Thank you for checking all the devs on the credits !!";
					name = "RuvRonv";
					GameJoltAPI.getTrophy(148569);
				case 'Dawn of a New Day':
					FlxG.save.data.trophy4 = true;
					description = "You have FC'ed matins on hard difficulty!!";
					name = "sarvRonv";
					GameJoltAPI.getTrophy(148559);
				case 'His Guardian Angel':
					FlxG.save.data.trophy5 = true;
					description = "You have FC'ed serafim on hard difficulty !!";
					name = "sarvRonv";
					GameJoltAPI.getTrophy(148560);
				case 'Two Harmonies, One Song':
					FlxG.save.data.trophy6 = true;
					description = "You have FC'ed harmony on hard difficulty !!";
					name = "sarvRonv";
					GameJoltAPI.getTrophy(148561);
				case 'Together Forever':
					FlxG.save.data.trophy7 = true;
					description = "You have FC'ed clandestine-ditty on hard difficulty !!";
					name = "sarvRonv";
					GameJoltAPI.getTrophy(148562);
				case 'Our Final Hymn':
					FlxG.save.data.trophy8 = true;
					description = "Congratulation for opening the DNM mod for the first time !\nAnd thank you for downloading it !!";
					name = "sarvRonv";
					GameJoltAPI.getTrophy(148563);
				case 'Certified No Skill Issue':
					FlxG.save.data.trophy9 = true;
					description = "Congratulations !!\nyou have FC'ed all songs on hard mode.";
					name = "bothRonv";
					GameJoltAPI.getTrophy(148558);
				case 'Completionist':
					FlxG.save.data.trophy10 = true;
					description = "Congratulation on getting every last one of the trophies !!\n
					We are truly grateful to you for taking the time searching and collecting every 9 available trophies.";
					name = "bothRonv";
					GameJoltAPI.getTrophy(148564);
			}

			KadeEngineData.trophies_unlocked[NBtrophy] = true;

			trace ("it's drawn");
			var bg:FlxSprite = new FlxSprite(FlxG.width - 400, FlxG.height + 200).makeGraphic(4000, 1800, 0xFFAEAEAE);
			bg.screenCenter();
			bg.updateHitbox();
			bg.scrollFactor.set();
			bg.visible = true;
			add(bg);
			FlxTween.tween(bg,{y: FlxG.height - 180},2,{ease: FlxEase.elasticInOut});

			var newSprite:FlxSprite = new FlxSprite(FlxG.width - 400, FlxG.height + 180).loadGraphic(Paths.image('trophies/' + name, 'date-night masses'));
			newSprite.setGraphicSize(Std.int(newSprite.width * 2));
			newSprite.updateHitbox();
			newSprite.scrollFactor.set();
			newSprite.visible = false;
			//Sprites.push(newSprite);
			add(newSprite);
			FlxTween.tween(newSprite,{y: FlxG.height - 180},2,{ease: FlxEase.elasticInOut});

			bg.visible = true;
			newSprite.visible = true;

			NameThing = new FlxText(FlxG.width - 270, FlxG.height + 180, 0, trophyName, 32);
			NameThing.scrollFactor.set();
			NameThing.setFormat("VCR OSD Mono", 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			add(NameThing);
			FlxTween.tween(NameThing,{y: FlxG.height - 180},2,{ease: FlxEase.elasticInOut});

			DescThingy = new FlxText(NameThing.x, NameThing.y + 40, 0, description, 15);
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
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}