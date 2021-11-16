package;
import GameJolt.GameJoltAPI;
import flixel.input.gamepad.FlxGamepad;
import tentools.api.FlxGameJolt as GJApi;
import openfl.display.BitmapData;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import flash.filters.GlowFilter;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Assets;
import GameJolt;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	public static var language:String = "English"; 

	var optionShit:Array<String> = ['story mode', 'credits', 'options'];

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;
	public var value:Int = 0;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.7" + nightly;
	public static var gameVer:String = "0.2.7.1";
	public static var chosenMenu = Std.random(10);

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
		clean();
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		trace(FlxG.save.data.fState);

		if (FlxG.save.data.fState > 0) {
			optionShit = ['story mode', 'freeplay', 'credits', 'options'];
		}
		
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('mp3'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite;

		bg = new FlxSprite(-100).loadGraphic(Paths.image('menuBGset1'));

		if (chosenMenu >= 7 && chosenMenu <= 9) {
			bg = new FlxSprite(-100).loadGraphic(Paths.image('menuBGset2'));
		} 

		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = FlxG.save.data.antialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		if (chosenMenu >= 0 && chosenMenu <= 6) {
			magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuBGset1-magenta'));
		} else if (chosenMenu >= 7 && chosenMenu <= 9) {
			magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuBGset2-magenta'));
		}

		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.10;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = FlxG.save.data.antialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = FlxG.save.data.antialiasing;
			if (firstStart)
				FlxTween.tween(menuItem,{y: 60 + (i * 160)},1 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
						finishedFunnyMove = true; 
						changeItem();
					}});
			else
				menuItem.y = 60 + (i * 160);
		}

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();
		
		
			var curCharacter:String = "안";
			trace(curCharacter);
			//var DescThing = new FlxText(FlxG.width /2, FlxG.height/2, 0, curCharacter, 15);
			//DescThing.scrollFactor.set();
			//DescThing.setFormat(Paths.font("Roboto-Black"), 50, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			//add(DescThing);

			//__hbBuffer.addUTF16(untyped __cpp__('(uintptr_t){0}', curCharacter.wc_str()),curCharacter.length, 0, -1);
		
		
		
		super.create();
	}

	var selectedSomethin:Bool = false;
	var code:String = "";
	static var password:String = "FREEPLAY";

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}
			}

			if (FlxG.keys.justPressed.UP)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				trace(value);
				switch (value) {
					case 0:
						var a = new Achievement("A New World", value);
						trace("confirm2");
					case 1:
						var a = new Achievement("Happy ending", value);
					case 2:
						var a = new Achievement("Best Team", value);
					case 3:
						var a = new Achievement("Dawn of a New Day", value);
					case 4:
						var a = new Achievement("His Guardian Angel", value);
					case 5:
						var a = new Achievement("Two Harmonies, One Song", value);
					case 6:
						var a = new Achievement("Our Final Hymn", value);
					case 7:
						var a = new Achievement("Together Forever", value);
					case 8:
						var a = new Achievement("Certified No Skill Issue", value);
						trace("confirm2");

				}
				value ++;
				//FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == '')
				{
					fancyOpenURL("https://fridaynightfunking.fandom.com/wiki/Date-Night_Masses");
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					
					if (FlxG.save.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
				}
			}
		if (FlxG.keys.justPressed.ANY) {
			code += FlxG.keys.getIsDown()[0].ID.toString().toUpperCase();
			trace("current guess is " + code);
		}
			if (password.startsWith(code)) {
				if (code == password) {
					trace('lets go you guessed the password lmfao');
					FlxG.save.data.fState = 3;
					FlxG.switchState(new FreeplayState());
					trace(FlxG.save.data.fState);
					code = '';
				}
			}
			else {
				if (code.length >= 2) {
					trace('password reset, you suck at guessing');
					code = '';
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'freeplay':
				FlxG.switchState(new FreeplayState());

				trace("Freeplay Menu Selected");
			case 'credits':
				//FlxG.switchState(new GameJolt());
				FlxG.switchState(new CreditsMenuState());
			case 'options':
				FlxG.switchState(new OptionsMenu());
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				//camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
