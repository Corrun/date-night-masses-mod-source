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
import Achievements;
import flixel.FlxCamera;
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

class ArchEndingState extends MusicBeatState
{
	private var camAchievement:FlxCamera;

	override function create()
	{
		var bg:FlxSprite = new FlxSprite();

		camAchievement = new FlxCamera();
		//camAchievement.bgColor.alpha = 0;

		if (PlayState.instance.songMisses == 0)
		{
			bg = new FlxSprite().loadGraphic(Paths.image('archventeEndings/good_ending', 'date-night masses'));
			add(bg);
			#if ACHIEVEMENTS_ALLOWED
				Achievements.loadAchievements();
				var achieveID:Int = Achievements.getAchievementIndex('buy_his_membership');
				if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
					Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
					giveAchievement('buy_his_membership');
					ClientPrefs.saveSettings();
				}
			#end
		} else {
			bg = new FlxSprite().loadGraphic(Paths.image('archventeEndings/bad_ending', 'date-night masses'));
			add(bg);
			#if ACHIEVEMENTS_ALLOWED
				Achievements.loadAchievements();
				var achieveID:Int = Achievements.getAchievementIndex('best_ending');
				if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
					Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
					giveAchievement('best_ending');
					ClientPrefs.saveSettings();
				}
			#end
		}
		FlxG.cameras.add(camAchievement);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (controls.BACK || controls.ACCEPT)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			MusicBeatState.switchState(new StoryMenuState());
		}
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement(achievementName:String) {
		add(new AchievementObject(achievementName, camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace("Giving achievement : " + achievementName);
	}
	#end
}