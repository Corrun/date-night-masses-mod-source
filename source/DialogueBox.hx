package;

import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxCamera;
import Achievements;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;
	var skipText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
	var bg:FlxSprite;

	var sound:FlxSound;
	var voiceAct:FlxSound;

	var actingString:String;
	var currentAnim:String;

	var hasVoice = false;

	private var camAchievement:FlxCamera;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		trace(dialogueList);
		
		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);

		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'matins':
				hasDialog = true;
				hasVoice = true;
				box.frames = Paths.getSparrowAtlas('portraits/TEXTBOX', 'date-night masses');
				box.animation.addByPrefix('ruv', 'TEXTBOX RuvNormal', 24, false);
				box.animation.addByPrefix('sarv', 'TEXTBOX SarvText', 24, false);
				box.animation.addByPrefix('other', 'TEXTBOX RuvQuiet', 24, false);
				box.scale.set(0.7, 0.7);
				box.updateHitbox();
			case 'serafim':
				hasDialog = true;
				hasVoice = true;
				box.frames = Paths.getSparrowAtlas('portraits/TEXTBOX', 'date-night masses');
				box.animation.addByPrefix('ruv', 'TEXTBOX RuvNormal', 24, false);
				box.animation.addByPrefix('sarv', 'TEXTBOX SarvText', 24, false);
				box.animation.addByPrefix('other', 'TEXTBOX RuvQuiet', 24, false);
				box.scale.set(0.7, 0.7);
				box.updateHitbox();
			case 'harmony':
				hasDialog = true;
				hasVoice = true;
				box.frames = Paths.getSparrowAtlas('portraits/TEXTBOX', 'date-night masses');
				box.animation.addByPrefix('ruv', 'TEXTBOX RuvNormal', 24, false);
				box.animation.addByPrefix('sarv', 'TEXTBOX SarvText', 24, false);
				box.animation.addByPrefix('other', 'TEXTBOX RuvQuiet', 24, false);
				box.scale.set(0.7, 0.7);
				box.updateHitbox();
		}

		this.dialogueList = dialogueList;

		if (!hasDialog)
			return;


	
		if (PlayState.SONG.song.toLowerCase() == 'matins' || PlayState.SONG.song.toLowerCase() == 'serafim' || PlayState.SONG.song.toLowerCase() == 'harmony')
		{
			// Sarvente Portrait setup
			portraitLeft = new FlxSprite(200, 150);
			portraitLeft.frames = Paths.getSparrowAtlas('portraits/sarvPortrait', 'date-night masses');

			portraitLeft.animation.addByPrefix('sarvCheerful', 'sarv Cheerful0', 24, false);
			portraitLeft.animation.addByPrefix('sarvConfused', 'sarv Confused0', 24, false);
			portraitLeft.animation.addByPrefix('sarvDelighted', 'sarv Delighted0', 24, false);

			portraitLeft.animation.addByPrefix('sarvDateCheerful', 'sarv DateCheerful0', 24, false);
			portraitLeft.animation.addByPrefix('sarvDateConfused', 'sarv DateConfused0', 24, false);
			portraitLeft.animation.addByPrefix('sarvDateDelighted', 'sarv DateDelighted0', 24, false);

			portraitLeft.animation.addByPrefix('sorv', 'sarv Ronv0', 24, false);

			// portraitLeft.setGraphicSize(Std.int(portraitLeft.height * 0.5));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			// Ruv Portrait setup
			portraitRight = new FlxSprite(800, 130);
			portraitRight.frames = Paths.getSparrowAtlas('portraits/ruvPortrait', 'date-night masses');

			portraitRight.animation.addByPrefix('ruvContent', 'ruv Content0', 24, false);
			portraitRight.animation.addByPrefix('ruvNerv', 'ruv Nerv0', 24, false);
			portraitRight.animation.addByPrefix('ruvNeutral', 'ruv Neutral0', 24, false);

			portraitRight.animation.addByPrefix('ruvDateContent', 'ruv DateContent0', 24, false);
			portraitRight.animation.addByPrefix('ruvDateNervous', 'ruv DateNerv0', 24, false);
			portraitRight.animation.addByPrefix('ruvDateNeutral', 'ruv DateNeutral0', 24, false);

			portraitRight.animation.addByPrefix('ronv', 'ruv Ronv0', 24, false);

			// portraitRight.setGraphicSize(Std.int(portraitRight.height * 0.5));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;

			box.setGraphicSize(Std.int(box.width * 1.25));
			box.updateHitbox();
			add(box);

			box.screenCenter(X);
			box.y = FlxG.height - box.height * 0.9;

			skipText = new FlxText(10, 10, Std.int(FlxG.width * 0.6), "", 16);
			skipText.font = 'Pixel Arial 11 Bold';
			skipText.color = 0x000000;
			skipText.text = 'press back to skip';
			add(skipText);
		}

		dropText = new FlxText(242, 432, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 430, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);

		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;
		FlxG.cameras.add(camAchievement);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;
	var musicStarted:Bool = false;
	override function update(elapsed:Float)
	{
		if (!musicStarted) {
			switch (PlayState.SONG.song.toLowerCase())
			{
			case 'matins':
				sound = new FlxSound().loadEmbedded(Paths.music('Morning', 'date-night masses'));
				sound.volume = 0;
				FlxG.sound.list.add(sound);
				sound.fadeIn(1, 0, 0.8);
			case 'serafim':
				sound = new FlxSound().loadEmbedded(Paths.music('Work', 'date-night masses'));
				sound.volume = 0;
				FlxG.sound.list.add(sound);
				sound.fadeIn(1, 0, 0.8);
			case 'harmony':
				sound = new FlxSound().loadEmbedded(Paths.music('Evening', 'date-night masses'));
				sound.volume = 0;
				FlxG.sound.list.add(sound);
				sound.fadeIn(1, 0, 0.8);
			}
		musicStarted = true;
		}
		

		dropText.text = swagDialogue.text;

		dialogueOpened = true;

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
			portraitLeft.visible = false;
			portraitRight.visible = true;
			/*
				portraitLeft.x = box.x + portraitLeft.x * 0.2;
				portraitLeft.y = box.y - portraitLeft.height * 0.6;
				portraitRight.x = FlxG.width - portraitRight.width * 2;
				portraitRight.y = box.y - portraitRight.height * 0.6;
			 */
		}
		if (PlayerSettings.player1.controls.BACK && isEnding != true)
		{
			remove(dialogue);
			// if (PlayState.SONG.song.toLowerCase() == 'matins')
			// remove(bg);
			isEnding = true;
			switch (PlayState.SONG.song.toLowerCase())
			{
				
				case "matins": 
					sound.fadeOut(1, 0);
					voiceAct.fadeOut(1, 0);
				case "serafim":
					sound.fadeOut(1, 0);
					voiceAct.fadeOut(1, 0);
				case "harmony":
					sound.fadeOut(1, 0);
					voiceAct.fadeOut(1, 0);
				default:
					trace("other song");
			}
			new FlxTimer().start(0.2, function(tmr:FlxTimer)
			{
				box.alpha -= 1 / 5;
				bgFade.alpha -= 1 / 5 * 0.7;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				swagDialogue.alpha -= 1 / 5;
				dropText.alpha = swagDialogue.alpha;
			}, 5);

			new FlxTimer().start(1.2, function(tmr:FlxTimer)
			{
				finishThing();
				kill();
			});
		}
		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
			voiceAct.pause();
			// remove(bg);

			// FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'matins' || PlayState.SONG.song.toLowerCase() == 'serafim' || PlayState.SONG.song.toLowerCase() == 'harmony')
						sound.fadeOut(2.2, 0);
					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}

		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		

		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		if (curCharacter.startsWith('ruv'))
		{
			var chanceRonv = Std.random(100);
			if (chanceRonv < 5) {
				portraitRight.animation.play('ronv');
				#if ACHIEVEMENTS_ALLOWED
				Achievements.loadAchievements();
				var achieveID:Int = Achievements.getAchievementIndex('ruv_ronv');
				if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { 
					Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
					giveAchievement('ruv_ronv');
					ClientPrefs.saveSettings();
				}
				#end
			} else {
				portraitRight.animation.play(curCharacter);
			}
			box.animation.play('ruv');
			portraitRight.visible = true;
			box.x = 20;
			box.y = 340;
			box.scale.set(0.95, 0.95);
			portraitLeft.alpha = 0.5;
			portraitRight.alpha = 1;
			box.updateHitbox();
		}
		else if (curCharacter.startsWith('sarv'))
		{
			var chanceSorv = Std.random(100);
			if (chanceSorv < 5) {
				portraitLeft.animation.play('sorv');
				#if ACHIEVEMENTS_ALLOWED
				Achievements.loadAchievements();
				var achieveID:Int = Achievements.getAchievementIndex('sarv_ronv');
				if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { 
					Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
					giveAchievement('sarv_ronv');
					ClientPrefs.saveSettings();
				}
				#end
			} else {
				portraitLeft.animation.play(curCharacter);
			}
			box.animation.play('sarv');
			portraitLeft.visible = true;
			box.x = 20;
			box.y = 330;
			box.scale.set(0.9, 0.9);
			portraitLeft.alpha = 1;
			portraitRight.alpha = 0.5;
			box.updateHitbox();
		}

		if (hasVoice)
		{
			voiceAct = new FlxSound().loadEmbedded(Paths.sound('Voices/$actingString', 'date-night masses'));
			voiceAct.volume = 1;
			FlxG.sound.list.add(voiceAct);
			voiceAct.play();
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = splitName[2];
		actingString = splitName[3];

		// dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();

		trace("splitted = " + splitName);
		trace("character = " + curCharacter);
		trace("dialogue = " + dialogueList[0]);
		trace("voice acting = " + actingString);
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
