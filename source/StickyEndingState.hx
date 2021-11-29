/*package;

	import openfl.utils.Future;
	import openfl.media.Sound;
	import flixel.system.FlxSound;
	#if FEATURE_STEPMANIA
	import smTools.SMFile;
	#end
	#if FEATURE_FILESYSTEM
	import sys.FileSystem;
	import sys.io.File;
	#end
	import Song.SongData;
	import flixel.input.gamepad.FlxGamepad;
	import flash.text.TextField;
	import flixel.FlxG;
	import flixel.FlxSprite;
	import flixel.addons.display.FlxGridOverlay;
	import flixel.group.FlxGroup.FlxTypedGroup;
	import flixel.math.FlxMath;
	import flixel.text.FlxText;
	import flixel.util.FlxColor;
	import flixel.util.FlxTimer;
	#if FEATURE_DISCORD
	import Discord.DiscordClient;
	#end

	using StringTools;

	class StickyEndingState extends MusicBeatState
	{
	override function create()
	{
		var bg:FlxSprite;

		if (PlayState.misses == 0)
		{
			bg = new FlxSprite().loadGraphic(Paths.image('sticky_endings/good_ending', 'date-night masses'));
		}
		else
		{
			bg = new FlxSprite().loadGraphic(Paths.image('sticky_endings/bad_ending', 'date-night masses'));
			// FlxG.sound.playMusic(Paths.music('gameover_1.21_sticky', 'date-night masses'));
		}
		add(bg);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (controls.BACK)
		{
			if (PlayState.isStoryMode)
			{
				FlxG.switchState(new StoryMenuState());
				clean();
			}
			else
			{
				FlxG.switchState(new FreeplayState());
				clean();
			}
		}

		if (controls.ACCEPT)
		{
			endBullshit();
		}
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			PlayState.startTime = 0;
			isEnding = true;
			// FlxG.sound.music.stop();
			// FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.1, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
					PlayState.stageTesting = false;
				});
			});
		}
	}
}*/

package;

import flixel.*;

/**
 * ...
 * @author bbpanzu
 */
class StickyEndingState extends MusicBeatState
{
	public function new()
	{
		super();
		bgColor = 0xFF4D1B30;
	}

	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("date/ending"));
		if (PlayState.misses == 0)
		{
			bg = new FlxSprite().loadGraphic(Paths.image('sticky_endings/good_ending', 'date-night masses'));
		}
		else
		{
			bg = new FlxSprite().loadGraphic(Paths.image('sticky_endings/bad_ending', 'date-night masses'));
			FlxG.sound.playMusic(Paths.music('gameover_1.21_sticky', 'date-night masses'));
		}
		add(bg);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (PlayState.isStoryMode && controls.ACCEPT)
		{
			FlxG.switchState(new StoryMenuState());
		}
		else if (controls.ACCEPT)
		{
			FlxG.switchState(new FreeplayState());
		}
	}
}
