package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.util.FlxSave;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import haxe.io.Bytes;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5b'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	public static var chosenBG = Std.random(10);
	
	var optionShit:Array<String> = [
		'story_mode',
		#if MODS_ALLOWED /*'mods',*/ #end
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits',
		#if !switch /*'donate',*/ #end
		'options'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		if (StoryMenuState.weekCompleted.get("week1")) {
			optionShit = [
				'story_mode',
				'freeplay', 	
				#if MODS_ALLOWED /*'mods',*/ #end
				#if ACHIEVEMENTS_ALLOWED 'awards', #end
				'credits',
				#if !switch /*'donate',*/ #end
				'options'
			];
		}

		WeekData.setDirectoryFromWeek();
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menu_bg/menuBGset1', 'date-night masses'));
		trace(chosenBG);
		if (chosenBG >= 6 && chosenBG <= 8)
		{
			bg = new FlxSprite(-80).loadGraphic(Paths.image('menu_bg/menuBGset2', 'date-night masses'));
		} 
		else if (chosenBG == 9)
		{
			bg = new FlxSprite(-80).loadGraphic(Paths.image('menu_bg/menuBGset3', 'date-night masses'));
			#if ACHIEVEMENTS_ALLOWED
			Achievements.loadAchievements();
			var achieveID:Int = Achievements.getAchievementIndex('choco_approves');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement('choco_approves');
				ClientPrefs.saveSettings();
			}
			#end
		}

		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menu_bg/menuBGset1-magenta', 'date-night masses'));

		if (chosenBG >= 6 && chosenBG <= 8)
		{
			magenta = new FlxSprite(-80).loadGraphic(Paths.image('menu_bg/menuBGset2-magenta', 'date-night masses'));
		} 
		else if (chosenBG == 9)
		{
			magenta = new FlxSprite(-80).loadGraphic(Paths.image('menu_bg/menuBGset3-magenta', 'date-night masses'));
		}

		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Date-Night Masses v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var achieveID:Int = Achievements.getAchievementIndex('a_new_world');
		if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
			Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
			giveAchievement('a_new_world');
			ClientPrefs.saveSettings();
		}

		achieveID = Achievements.getAchievementIndex('completionist');
		var allAchievements:Array<String> = [
			'a_new_world',
			'happy_ending',
			'ruv_suit',
			'best_ending',
			'buy_his_membership',
			'no_tables_allowed',
			'hi_chat',
			'best_team',
			'dawn_of_a_new_day',
			'his_guardian_angel',
			'two_harmonies_one_song',
			'our_final_hymn',
			'together_forever',
			'whitty_reference',
			'no_skill_issue',
			'you_made_her_cry',
			'ultimate_domination',
			'poggers',
			'choco_approves',
			'ruv_ronv',
			'sarv_ronv'
		];
		if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]) && Achievements.checkAll(allAchievements)) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
			Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
			giveAchievement('completionist');
			ClientPrefs.saveSettings();
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement(achievementName:String) {
		add(new AchievementObject(achievementName, camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace("Giving achievement : " + achievementName); 
	}
	#end

	var selectedSomethin:Bool = false;
	var code:String = "";
	static var stickyPassword:String = "stickysimp";
	static var kikyoPassword:String = "spookykikyo";

	override function update(elapsed:Float)
	{
		if (StoryMenuState.weekCompleted.get("week1")) {
				if (FlxG.keys.justPressed.ANY) {
					code += FlxG.keys.getIsDown()[0].ID.toString().toLowerCase();
					trace("current guess is " + code);
				}
				if (stickyPassword.startsWith(code) || kikyoPassword.startsWith(code)) {
					if (code == stickyPassword && !FlxG.save.data.stickyUnlocked) {
						trace('lets go you guessed the stickyPassword lmfao');
						//FlxG.save.data.fState = !FlxG.save.data.fState;
						FlxG.save.data.stickyUnlocked = true;
						FlxG.switchState(new StoryMenuState());
						trace(FlxG.save.data.stickyUnlocked); 
						code = '';
					} else if (code == kikyoPassword && !FlxG.save.data.kikyoUnlocked) {
						trace('lets go you guessed the kikyoPassword lmfao');
						//FlxG.save.data.fState = !FlxG.save.data.fState;
						FlxG.save.data.kikyoUnlocked = true;
						FlxG.switchState(new StoryMenuState());
						trace(FlxG.save.data.kikyoUnlocked);
						code = '';
					}

				} else {
					if (code.length > 2/*code.length > stickyPassword.length && code.length > kikyoPassword.length*/) {
						trace('password reset, you suck at guessing');
						code = '';
					}
				}
			}

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new DNMCreditsState());
									case 'options':
										MusicBeatState.switchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
