package;

import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.system.FlxSound;
#if FEATURE_DISCORD
import Discord.DiscordClient;
#end

class Prologue extends MusicBeatState
{
	var curImage:Int;
	var curBg:FlxSprite;
	var creepyMusic:FlxSound;
	var started:Bool;

	var textStuff:Array<String>;
	var coolText:FlxText;

	override public function create()
	{
		trace('we in da prologue');
		curImage = 0;

		DiscordClient.changePresence("In the Prologue", null);

		curBg = new FlxSprite(0, 0).loadGraphic(Paths.image('Prologue/${curImage}', 'date-night masses'));
		add(curBg);
		curBg.setGraphicSize(FlxG.width);
		curBg.updateHitbox();

		creepyMusic = new FlxSound().loadEmbedded(Paths.music('Subliminal', 'date-night masses'));
		creepyMusic.fadeIn(1.3, 0, 0.9);

		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			started = true;
		});

		textStuff = [
			'',
			"Sarv?",
			"Why did you do it Ruv...",
			"It's all your fault Ruv. You're so unfair.",
			"Sarv... no! I didn't!",
			"IT'S ALL\nYOUR\nFAULT",
			"Sarv no!",
			"YOU BROKE OUR VOW"
		];

		coolText = new FlxText(FlxG.width / 2, 430, Std.int(FlxG.width * 0.6), textStuff[0], 32);
		coolText.screenCenter(X);
		coolText.alignment = CENTER;
		add(coolText);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (PlayerSettings.player1.controls.ACCEPT && started)
		{
			curImage++;

			switch (curImage)
			{
				case 8:
					creepyMusic.stop();
					nextImage();
				case 11:
					nextImage();
					new FlxTimer().start(2, function(tmr:FlxTimer)
					{
						LoadingState.loadAndSwitchState(new PlayState());
					});
				default:
					nextImage();
			}
		}
		super.update(elapsed);
	}

	function nextImage():Void
	{
		curBg.loadGraphic(Paths.image('Prologue/${curImage}', 'date-night masses'));
		curBg.setGraphicSize(FlxG.width);
		curBg.updateHitbox();

		textStuff.remove(textStuff[0]);
		coolText.text = textStuff[0];
	}
}
