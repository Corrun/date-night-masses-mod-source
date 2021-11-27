package;

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
#if FEATURE_DISCORD
import Discord.DiscordClient;
#end

using StringTools;

class StickyEndingState extends MusicBeatState
{
	override function create()
	{
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('sticky_endings/bad_ending', 'date-night masses'));

		if (PlayState.misses == 0)
		{
			bg = new FlxSprite().loadGraphic(Paths.image('sticky_endings/good_ending', 'date-night masses'));
		}
		add(bg);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (controls.BACK || controls.ACCEPT)
		{
			FlxG.switchState(new StoryMenuState());
		}
	}
}
