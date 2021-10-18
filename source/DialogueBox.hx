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
	var voiceActing:String = '';
	var textbox = '';
	static var myGlyphs:Array<Int> = [];

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	var sound:FlxSound;
	var voiceAct:FlxSound;
	var bgmus:FlxSound;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				sound = new FlxSound().loadEmbedded(Paths.music('Lunchbox'),true);
				sound.volume = 0;
				FlxG.sound.list.add(sound);
				sound.fadeIn(1, 0, 0.8);
			case 'thorns':
				sound = new FlxSound().loadEmbedded(Paths.music('LunchboxScary'),true);
				sound.volume = 0;
				FlxG.sound.list.add(sound);
				sound.fadeIn(1, 0, 0.8);
			case 'matins':
				bgmus = new FlxSound().loadEmbedded(Paths.dateMusic('Morning'), true);
				bgmus.volume = 0;
				FlxG.sound.list.add(bgmus);
				bgmus.fadeIn(1, 0, 0.8);
			case 'serafim':
				bgmus = new FlxSound().loadEmbedded(Paths.dateMusic('Work'), true);
				bgmus.volume = 0;
				FlxG.sound.list.add(bgmus);
				bgmus.fadeIn(1, 0, 0.8);
			case 'harmony':
				bgmus = new FlxSound().loadEmbedded(Paths.dateMusic('Evening'), true);
				bgmus.volume = 0;
				FlxG.sound.list.add(bgmus);
				bgmus.fadeIn(1, 0, 0.8);

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
		var hasVoice = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
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

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'matins' | 'serafim' | 'harmony':
				hasDialog = true;
				hasVoice = true;
				box.frames = Paths.getSparrowAtlas('weeb/TEXTBOX');
				box.animation.addByPrefix('RuvOpen', 'TEXTBOX RuvNormal', 24, false);
				box.animation.addByIndices('Ruvnormal', 'TEXTBOX RuvNormal', [1], "", 24);
				box.animation.addByPrefix('SarvOpen', 'TEXTBOX Sarvtext', 24, false);
				box.animation.addByIndices('Sarvnormal', 'TEXTBOX Sarvtext', [1], "", 24);
				box.animation.addByPrefix('OtherOpen', 'TEXTBOX RuvQuiet', 24, false);
				box.animation.addByIndices('Othernormal', 'TEXTBOX RuvQuiet', [1], "", 24);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;


		switch (PlayState.SONG.song.toLowerCase()) 
		{
			case 'senpai' | 'roses' | 'thorns':
				portraitLeft = new FlxSprite(-20, 40);
				portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
				portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				portraitLeft.visible = false;

				portraitRight = new FlxSprite(0, 40);
				portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
				portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
				portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
				portraitRight.updateHitbox();
				portraitRight.scrollFactor.set();
				add(portraitRight);
				portraitRight.visible = false;
			case 'matins' | 'serafim' | 'harmony':
				portraitLeft = new FlxSprite(200, 150);
				portraitLeft.frames = Paths.getSparrowAtlas('weeb/sarvPortrait');

				portraitLeft.animation.addByPrefix('sarvCheerful', 'sarv Cheerful', 24, false);
				portraitLeft.animation.addByPrefix('sarvConfused', 'sarv Confused', 24, false);
				portraitLeft.animation.addByPrefix('sarvDateCheerful', 'sarv dateCheerful', 24, false);
				portraitLeft.animation.addByPrefix('sarvDateConfused', 'sarv DateConfused', 24, false);
				portraitLeft.animation.addByPrefix('sarvDateDelighted', 'sarv DateDelighted', 24, false);
				portraitLeft.animation.addByPrefix('sarvDelighted', 'sarv delighted', 24, false);

				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
				portraitLeft.setGraphicSize(Std.int(portraitLeft.height * PlayState.daPixelZoom * 0.15));
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				portraitLeft.visible = false;

				portraitRight = new FlxSprite(800, 150);
				portraitRight.frames = Paths.getSparrowAtlas('weeb/ruvPortrait');

				portraitRight.animation.addByPrefix('ruvContent', 'ruv Content', 24, false);
				portraitRight.animation.addByPrefix('ruvDateContent', 'ruv DateContent', 24, false);
				portraitRight.animation.addByPrefix('ruvDateNerv', 'ruv DateNerv', 24, false);
				portraitRight.animation.addByPrefix('ruvDateNeutral', 'ruv DateNeutral', 24, false);
				portraitRight.animation.addByPrefix('ruvNerv', 'ruv Nerv', 24, false);
				portraitRight.animation.addByPrefix('ruvNeutral', 'ruv Neutral', 24, false);
				portraitRight.animation.addByPrefix('ruvRonv', 'ruv Ronv', 24, false);

				portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.12));
				portraitRight.setGraphicSize(Std.int(portraitRight.height * PlayState.daPixelZoom * 0.12));
				portraitRight.updateHitbox();
				portraitRight.scrollFactor.set();
				add(portraitRight);
				portraitRight.visible = false;
		}

		switch (PlayState.SONG.song.toLowerCase()) 
		{
			case 'senpai' | 'roses' | 'thorns':
				box.animation.play('RuvOpen');
			default:
				box.animation.play('normal');
		}


		switch (PlayState.SONG.song.toLowerCase()) 
		{
			case 'senpai' | 'roses' | 'thorns':
				box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		} 
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		switch (PlayState.SONG.song.toLowerCase()) 
		{
			case 'senpai' | 'roses' | 'thorns':
			portraitLeft.screenCenter(X);
		}

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns') {
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		} else {
			dropText = new FlxText(242, 432, Std.int(FlxG.width * 0.6), "", 32);
		}
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns') {
			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		} else {
			swagDialogue = new FlxTypeText(240, 430, Std.int(FlxG.width * 0.6), "", 32);
		}
		if (!hasVoice) {
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		}
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
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;
		
		if (box.animation.curAnim != null)
		{
			switch (box.animation.curAnim.name)
			{
			case 'RuvOpen':
				box.animation.play('Ruvnormal');
				box.updateHitbox();
			case 'SarvOpen':
				box.animation.play('Sarvnormal');
				box.updateHitbox();
			case 'OtherOpen':
				box.animation.play('Othernormal');
				box.updateHitbox();
			case 'normalOpen':
				box.animation.play('normal');
				updateHitbox();
			}
			dialogueOpened = true;
		}
		
		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);

			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;
					if (voiceAct != null) voiceAct.destroy();

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						sound.fadeOut(2.2, 0);

					if (PlayState.SONG.song.toLowerCase	() == 'matins' || PlayState.SONG.song.toLowerCase() == 'serafim' || PlayState.SONG.song.toLowerCase() == 'harmony') {
						bgmus.fadeOut(2.2, 0);
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
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				if (voiceAct != null) voiceAct.destroy();
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

/*		if (voiceActing != '') {
			voiceAct = FlxG.sound.load(Paths.sound('Voices/$voiceActing'));
			voiceAct.play();
		}
*/
		box.alpha = 0;
		switch (textbox)
		{
			case 'ruv':
				box.animation.play('RuvOpen');
				box.x = 20;
				box.y = 340;
				box.scale.set(0.95, 0.95);
			case 'sarv':
				box.animation.play('SarvOpen');
				box.x = 20;
				box.y = 330;
				box.scale.set(0.9, 0.9);
			case 'other':
				box.animation.play('OtherOpen');
				box.x = 20;
				box.y = 330;
				box.scale.set(0.9, 0.9);
			default:
				box.animation.play('normalOpen');
				box.x = 0;
				box.y = 0;
		}
		box.alpha = 1;
		

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.animation.play('enter');
					portraitLeft.visible = true;
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.animation.play('enter');
					portraitRight.visible = true;
				}
			case 'ruvContent': 
				portraitLeft.visible = false;
				portraitRight.animation.play('ruvContent');
				portraitRight.visible = true;
			case 'ruvDateContent':
				portraitLeft.visible = false;
				portraitRight.animation.play('ruvDateContent');
				portraitRight.visible = true;
			case 'ruvDateNerv':
				portraitLeft.visible = false;
				portraitRight.animation.play('ruvDateNerv');
				portraitRight.visible = true;
			case 'ruvDateNeutral':
				portraitLeft.visible = false;
				portraitRight.animation.play('ruvDateNeutral');
				portraitRight.visible = true;
			case 'ruvNerv':
				portraitLeft.visible = false;
				portraitRight.animation.play('ruvNerv');
				portraitRight.visible = true;
			case 'ruvNeutral':
				portraitLeft.visible = false;
				portraitRight.animation.play('ruvNeutral');
				portraitRight.visible = true;
			case 'ruvRonv':
				portraitLeft.visible = false;
				portraitRight.animation.play('ruvRonv');
				portraitRight.visible = true;
			case 'sarvCheerful': 
				portraitRight.visible = false;
				portraitLeft.animation.play('sarvCheerful');
				portraitLeft.visible = true;
			case 'sarvConfused':
				portraitRight.visible = false;
				portraitLeft.animation.play('sarvConfused');
				portraitLeft.visible = true;
			case 'sarvDateCheerful':
				portraitRight.visible = false;
				portraitLeft.animation.play('sarvDateCheerful');
				portraitLeft.visible = true;
			case 'sarvDateConfused':
				portraitRight.visible = false;
				portraitLeft.animation.play('sarvDateConfused');
				portraitLeft.visible = true;
			case 'sarvDateDelighted':
				portraitRight.visible = false;
				portraitLeft.animation.play('sarvDateDelighted');
				portraitLeft.visible = true;
			case 'sarvDelighted':
				portraitRight.visible = false;
				portraitLeft.animation.play('sarvDelighted');
				portraitLeft.visible = true;
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = splitName[2]; //dialogueList[0].substr(splitName[1].length + 2).trim();
		textbox = splitName[3];
		voiceActing = splitName[4];
	}
}