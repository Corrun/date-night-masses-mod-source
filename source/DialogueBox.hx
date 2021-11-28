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

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		trace(dialogueList);
		switch (PlayState.SONG.songId.toLowerCase())
		{
			case 'matins':
				sound = new FlxSound().loadEmbedded(Paths.music('Morning', 'date-night masses'));
				sound.volume = 0;
				FlxG.sound.list.add(sound);
				sound.fadeIn(1, 0, 0.8);
			case 'senpai':
				sound = new FlxSound().loadEmbedded(Paths.music('Lunchbox'), true);
				sound.volume = 0;
				FlxG.sound.list.add(sound);
				sound.fadeIn(1, 0, 0.8);
			case 'thorns':
				sound = new FlxSound().loadEmbedded(Paths.music('LunchboxScary'), true);
				sound.volume = 0;
				FlxG.sound.list.add(sound);
				sound.fadeIn(1, 0, 0.8);
		}

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
		switch (PlayState.SONG.songId.toLowerCase())
		{
			case 'matins':
				hasDialog = true;
				hasVoice = true;
				box.frames = Paths.getSparrowAtlas('portraits/textbox', 'date-night masses');
				box.animation.addByPrefix('ruv', 'textbox ruv', 24, false);
				box.animation.addByPrefix('sarv', 'textbox sarvente', 24, false);
				box.animation.addByPrefix('other', 'textbox other', 24, false);
				box.scale.set(0.7, 0.7);
				box.updateHitbox();

			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.loadImage('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;

		if (!hasDialog)
			return;

		if (PlayState.SONG.songId.toLowerCase() == 'senpai'
			|| PlayState.SONG.songId.toLowerCase() == 'roses'
			|| PlayState.SONG.songId.toLowerCase() == 'thorns')
		{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * CoolUtil.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * CoolUtil.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;

			box.animation.play('normalOpen');
			box.setGraphicSize(Std.int(box.width * CoolUtil.daPixelZoom * 0.9));
			box.updateHitbox();
			add(box);

			box.screenCenter(X);
			box.y += box.height / 2;
			portraitLeft.screenCenter(X);
			skipText = new FlxText(10, 10, Std.int(FlxG.width * 0.6), "", 16);
			skipText.font = 'Pixel Arial 11 Bold';
			skipText.color = 0x000000;
			skipText.text = 'Press backspace to skip';
			add(skipText);
			handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.loadImage('weeb/pixelUI/hand_textbox'));
			add(handSelect);
		}
		else if (PlayState.SONG.songId.toLowerCase() == 'matins')
		{
			// background setup
			if (PlayState.end == false)
			{
				bg = new FlxSprite(0, 0).loadGraphic(Paths.image('cutscene_animatics/song1_beforeplay', 'date-night masses'));
				PlayState.end = true;
				bg.setGraphicSize(FlxG.width);
				bg.updateHitbox();
			}
			else
			{
				bg = new FlxSprite(-75, -40).loadGraphic(Paths.image('cutscene_animatics/song1_afterplay', 'date-night masses'));
				bg.setGraphicSize(Std.int(FlxG.width * 1.15));
				bg.updateHitbox();
			}
			add(bg);

			// Sarvente Portrait setup
			portraitLeft = new FlxSprite(200, 150);
			portraitLeft.frames = Paths.getSparrowAtlas('portraits/sarvPortrait', 'date-night masses');

			portraitLeft.animation.addByPrefix('sarvCheerful', 'sarv Cheerful', 24, false);
			portraitLeft.animation.addByPrefix('sarvConfused', 'sarv Confused', 24, false);
			portraitLeft.animation.addByPrefix('sarvDelighted', 'sarv Delighted', 24, false);

			portraitLeft.animation.addByPrefix('sarvDateCheerful', 'sarv DateCheerful', 24, false);
			portraitLeft.animation.addByPrefix('sarvDateConfused', 'sarv DateConfused', 24, false);
			portraitLeft.animation.addByPrefix('sarvDateDelighted', 'sarv DateDelighted', 24, false);

			// portraitLeft.setGraphicSize(Std.int(portraitLeft.height * 0.5));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			// Ruv Portrait setup
			portraitRight = new FlxSprite(800, 130);
			portraitRight.frames = Paths.getSparrowAtlas('portraits/ruvPortrait', 'date-night masses');

			portraitRight.animation.addByPrefix('ruvContent', 'ruv Content', 24, false);
			portraitRight.animation.addByPrefix('ruvNerv', 'ruv Nerv', 24, false);
			portraitRight.animation.addByPrefix('ruvNeutral', 'ruv Neutral', 24, false);

			portraitRight.animation.addByPrefix('ruvDateContent', 'ruv DateContent', 24, false);
			portraitRight.animation.addByPrefix('ruvDateNervous', 'ruv DateNerv', 24, false);
			portraitRight.animation.addByPrefix('ruvDateNeutral', 'ruv DateNeutral', 24, false);

			portraitRight.animation.addByPrefix('ron', 'ruv Ronv', 24, false);

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
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.songId.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.songId.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
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
			// if (PlayState.SONG.songId.toLowerCase() == 'matins')
			// remove(bg);
			isEnding = true;
			switch (PlayState.SONG.songId.toLowerCase())
			{
				case "senpai" | "thorns":
					sound.fadeOut(2.2, 0);
				case "roses":
					trace("roses");
				case "matins":
					sound.fadeOut(4, 0);
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
			// remove(bg);

			// FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.songId.toLowerCase() == 'senpai' || PlayState.SONG.songId.toLowerCase() == 'thorns')
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
			portraitRight.animation.play(curCharacter);
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
			portraitLeft.animation.play(curCharacter);
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
}
