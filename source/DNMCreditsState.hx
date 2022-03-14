package;

import lime.tools.Architecture;
#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.tweens.FlxTween;
import Achievements;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class DNMCreditsState extends MusicBeatState
{
	var curSelected:Int = -1;
	var page = 0;

	private var grpOptions:FlxTypedGroup<FlxText>;
	private var grpTwitter:FlxTypedGroup<FlxText>;
	private var iconArray:Array<FlxSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];
	private var titleStuff:Array<String> = [];

	var bg:FlxSprite;
    var book:FlxSprite;
	var descText:FlxText;

	var dialogueText:FlxText;
	var pageText:FlxText;
	var pagetitleText:FlxText;
	var pagetitleText2:FlxText;

	var intendedColor:Int;
	var colorTween:FlxTween;

	private var camAchievement:FlxCamera;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		FlxG.sound.playMusic(Paths.music('Until_Stardust', 'date-night masses'), 0);
		FlxG.sound.music.fadeIn(4, 0, 0.7);

		bg = new FlxSprite(0,0).loadGraphic(Paths.image('credits/background', 'date-night masses'));
        bg.scale.x = 0.5;
        bg.scale.y = 0.5;
        bg.screenCenter();
        //bg.x = -500;
        //bg.y = -500;
		add(bg);

        book = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/book', 'date-night masses'));
        //book.screenCenter();
        book.scale.x = 0.28;
        book.scale.y = 0.28;
        book.screenCenter();
        book.x += 290;
        //book.y = -500;
		add(book);

		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);

		grpTwitter = new FlxTypedGroup<FlxText>();
		add(grpTwitter);

		#if MODS_ALLOWED
		//trace("finding mod shit");
		for (folder in Paths.getModDirectories())
		{
			var creditsFile:String = Paths.mods(folder + '/data/credits.txt');
			if (FileSystem.exists(creditsFile))
			{
				var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
				for(i in firstarray)
				{
					var arr:Array<String> = i.replace('\\n', '\n').split("::");
					if(arr.length >= 5) arr.push(folder);
					creditsStuff.push(arr);
				}
				creditsStuff.push(['']);
			}
		}
		#end

		var unpleasant:Array<String> = [
			'Directors',
			'Artists',
			'',
			'',
			'',
			'Composers',
			'',
			'charters',
			'Coders',
			'Voice Actors',
			'MFM Team',
			'Helpers',
			'',
			'Awesomes',
			'',
			'Psych Team',
			'',
			'Contributors',
			"Funkin' Crew",
			"",
		];

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['Temp',				'temp',				'Director, writer, Sarv VA',							'https://twitter.com/tt_thewriter',					"I'm probably your mom","I do the funni voices and write the silly stories","Ruvente Supremacy"],
			['Belgian',				'belgian',			'Co-Director and charter', 								'https://twitter.com/belgianredacted',				"Tengen toppa gurren lagann mod pls","Hi mom I made funny arrows go brrr","It comes with an eggroll"],
			['Discord',				'discord',			'Fan MFM community discord server and host of DNM team','https://discord.gg/mid-fightmasses'],

			['ArtTrash',			'art',				'BG assets',											'https://twitter.com/ArtTrash1',					'haha funny retrospecter cereal',"i want noodles now ngl","persona 5 my beloved"],
			['Confusa',				'confusa',			'Stage 1 BG',											'https://twitter.com/ConfusedConfusa'],
			['BWDragon',			'bwd',				'Concept poses and stages 1 and 2 BGs',					'https://twitter.com/Thatsky_Dragon',				'This modding experience was worth every anxiety attack along the way',"Oh wow, you noticed me...have a lovely day :3","STOP STEALING OTHER'S WORK DAMMIT"],

			['GarbageChoco',		'choco',			'icons, portraits, bubbles, cutscenes, pose concepts,\nstage 4 concepts stage 4 BG and cameos',				'https://twitter.com/GarbageChoco',	"\nMY SPEED CAUSED ME CARPEL TUNNEL :)","\ncommit artson","\nbuff sarvente is my magnum opus"],
			['Cygthera', 			'cygthera',			'Stage 3 background',									'https://twitter.com/Cygthera',						'Many thanks to the MFM team for allowing me to work on this!',"help i've fallen into lancer ttrpg hell and cant get out", 'theres a bunch of really really cool people on this team go shoo look at them already'],
			['Isa',					'isa',				'icons, storymode assets, backgrounds,\nDNM logo and Spanish Translation',	'https://twitter.com/isalia291','\nhope you enjoyed, thanks for everything!','\nsticky said my banner looked nice i win',"\nkitty woo"],

			['Koiumina',			'kayden',				'album cover art and stage 1 poses (demo)',			'https://twitter.com/Koiumina1'],
			['Artceps',				'artceps',			'Ruv animator',											'https://twitter.com/MayflyingMink',				"The dedication and energy into this mod, don't regret a thing","Ruv's gloves can die","Ruv's gloves can die"],
			['Spinbit',				'spinbit',			'Sarv animator',										'https://twitter.com/_Spinbit',						'Teehee, I do the funny animating','Icecream nun and oreo man my beloved','Animate crashed on me atleast 50 times'],

			['NemoInABottle',		'nemo',					'sticky pritesheets',								'https://twitter.com/NemoInABottle'],
			['OhSoVanilla',			'ohsovanilla',			'Stage 4 animator',									'https://twitter.com/OhSoVanilla64',				'Hihi!! I amimate!!!','Sarvente is my wife','I love ice cream!!'],
			[''],

			['Implosion',			'faceimplosion',	'Composer of matins and serafim, credit song, pause song\nand video editor',		'https://twitter.com/ImplosionFace',				"\n52455741544348","\n544845","\n50524f4c4f475545"],
			['LawfulMango',			'lawfulnessupstairs','Composer of harmony',									'https://twitter.com/LawfulnessU',					"If you can't tell, I like mangos",	"Purposely mispelled mangoes as mangos","Purposely mispelled mangoes as mangos"],
			['NotARock',			'rock',				'credit song',											'https://twitter.com/RockRockBoulder'],

			['IdioticSugar',		'idioticsugar',		'Composer of Rosebass',									'https://twitter.com/idioticsugar',				"I make music and Belgian wants to kill me","I used to simp for Kratos from GOW","listen to Ken Ashcorp"],
			['Mike geno',			'mike',				'Composer of Clandestine-ditty',						'https://twitter.com/electro_mike'],
			['Seli',				'seli',				'Composer of together',									'https://twitter.com/SeliSeliSelina'],

			['Belgian',				'belgian',			'Co-Director and charter', 								'https://twitter.com/belgianredacted',				"Tengen toppa gurren lagann mod pls","Hi mom I made funny arrows go brrr","It comes with an eggroll"],
			['Noer',				'noer',				'Charter, playtester and Creative Consultant',			'https://twitter.com/ThisIsNoerlol',				'Without me this mod would be called "mid-night dating"',"sic ur a piss baby lol","My basedness is a mental thing i cant control it"],
			['Cerbera',				'cerbera',			'Rosebass charter and chart corrector',					'https://twitter.com/Cerbera_fnf'],

			['Corrun',				'corrun',			'Coding and French translation',						'https://twitter.com/Corrun_UT',					'Excellency is not an art, but a habit.','500 hours on this mod. I regret nothing.','tomato dog my beloved'],
			['Panda',				'pad',				'Coding',												'https://twitter.com/Pandanomania'],
			[''],

			['Temp',				'temp',				'Director, writer, Sarvente VA',						'https://twitter.com/tt_thewriter',					"I'm probably your mom","I do the funni voices and write the silly stories","Ruvente Supremacy"],
			['MacDowall',			'cougar',			'Voice actor for Ruvyzvat',								'https://twitter.com/CougarMacDowal1'],
			[''],

			['Dokki', 				'dokki',			'Artist of MFM',										''],
			['Mike geno',			'mike',				'Musician of MFM',										'https://twitter.com/electro_mike'],
			['Kuro',				'kuro',				'Programmer of MFM',									'https://twitter.com/Kuroao_Anomal'],

			['Sonzai',				'',					'Playtester and Hoster of the discord \nserver the team worked in',	'https://twitter.com/sonzai_buredo'],
			['Shift',				'',					'Korean translator',									'https://twitter.com/Shift7a_4'],
			['Star',				'',					'Chinese translator',									'https://twitter.com/NihilityStar'],

			['Kade',				'',					'Maker of Kade Engine (used for demo)',					'https://twitter.com/kade0912'],
			['Oxydation',			'',					'Art Consultant',										'https://twitter.com/Nishaniie'],
			['KerbeYoshu',			'',					'Gamejolt banner',										'https://twitter.com/KerbeYoshu'],

			['TentaRJ',				'',					'Gamejolt integration\n(not used in the end)',			'https://twitter.com/TentaRJ'],
			['Nosadx',				'',					'recruitment helper',									'https://twitter.com/poop47845836'],
			['LordShaojiVIII',		'',					'Maker and Keeper of the DNM wiki page',				'https://twitter.com/ArtistVIII'],

			['Sticky',				'',					'Dedicated supporter from start to end,\nsticky death sound',				'https://twitter.com/StickyBM'],
			['Kikyo',				'',					'Dedicated supporter from start to end',				'https://twitter.com/KikyoBerry'],
			[''],

			['Shadow Mario',		'',					'Main Programmer of Psych Engine',						'https://twitter.com/Shadow_Mario_'],
			['RiverOaken',			'',					'Main Artist/Animator of Psych Engine',					'https://twitter.com/river_oaken'],
			['bb-panzu',			'',					'Additional Programmer of Psych Engine',				'https://twitter.com/bbsub3'],

			['shubs',				'',					'New Input System Programmer',							'https://twitter.com/yoshubs'],
			['SqirraRNG',			'',					'Chart Editor\'s Sound Waveform base',					'https://twitter.com/gedehari'],
			['iFlicky',				'',					'Delay/Combo Menu Song Composer\nand Dialogue Sounds',	'https://twitter.com/flicky_i'],

			['PolybiusProxy',		'',					'.MP4 Video Loader Extension',							'https://twitter.com/polybiusproxy'],
			['Keoiki',				'',					'Note Splash Animations',								'https://twitter.com/Keoiki_'],
			[''],

			['ninjamuffin99',		'',					"Programmer of Friday Night Funkin'",					'https://twitter.com/ninja_muffin99'],
			['PhantomArcade',		'',					"Animator of Friday Night Funkin'",						'https://twitter.com/PhantomArcade3K'],
			[''],

			['evilsk8r',			'',					"Artist of Friday Night Funkin'",						'https://twitter.com/evilsk8r'],
			['kawaisprite',			'',					"Composer of Friday Night Funkin'",						'https://twitter.com/kawaisprite'],
			[''],
		];
		
		pageText = new FlxText(0,0,FlxG.width,"page " + (page + 1),8);
		pageText.setFormat(Paths.font("vcr.ttf"), 28, FlxColor.BLACK, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		pageText.screenCenter();
		pageText.x += 1080;
		pageText.y += 130;
		add(pageText);

		pagetitleText = new FlxText(0,0,FlxG.width,"",8);
		pagetitleText.setFormat(Paths.font("vcr.ttf"), 36, FlxColor.BLACK, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		pagetitleText.screenCenter();
		pagetitleText.x += 640;
		pagetitleText.y += -130;
		add(pagetitleText);

		pagetitleText2 = new FlxText(0,0,FlxG.width,"",8);
		pagetitleText2.setFormat(Paths.font("vcr.ttf"), 36, FlxColor.BLACK, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		pagetitleText2.screenCenter();
		pagetitleText2.x += 950;
		pagetitleText2.y += -130;
		add(pagetitleText2);

		for(i in unpleasant){
			titleStuff.push(i);
		}

		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{ 
			var column = i % 6;
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:FlxText = new FlxText(0,0,FlxG.width,creditsStuff[i][0],8);
			optionText.setFormat(Paths.font("vcr.ttf"), 28, 0xFFe55777, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			optionText.screenCenter();
			optionText.x += 710;
			if (column >= 3) {
				optionText.x += 320;
				column -= 3;
			}
			if (creditsStuff[i][0] == '' || creditsStuff[i][1] == '') {
				optionText.x -= 70;
			}

			optionText.y += -70 + column * 70;
			grpOptions.add(optionText);

			var twitter;
			if (creditsStuff[i][0] == '' || !creditsStuff[i][3].startsWith('https://twitter.com/')) {
				twitter = "";
			} else {
				twitter = "@" + creditsStuff[i][3].substring(20);
			}
			var twitterText:FlxText = new FlxText(0,0,FlxG.width,twitter,8);
			twitterText.setFormat(Paths.font("vcr.ttf"), 14, 0xFFe55777, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			twitterText.screenCenter();
			twitterText.x = optionText.x;
			twitterText.y = optionText.y + optionText.size - 2;
			grpTwitter.add(twitterText);
			/*
			if(creditsStuff[i][5] != null)
			{
				Paths.currentModDirectory = creditsStuff[i][5];
			}
			*/

			var icon:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('credits/empty'));
			if (creditsStuff[i][0] != '' && creditsStuff[i][1] != '') {
				icon = new FlxSprite(0,0).loadGraphic(Paths.image('credits/' + creditsStuff[i][1]));
			}
			icon.scale.x = 0.5;
			icon.scale.y = 0.5;
			icon.x = optionText.x - 120;
			icon.y = optionText.y - 50;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);
			Paths.currentModDirectory = '';

			if(curSelected == -1) curSelected = i;
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		dialogueText = new FlxText(50, descText.y + descText.size, 1180, "", 32);
		dialogueText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		dialogueText.scrollFactor.set();
		dialogueText.borderSize = 2.4;
		add(dialogueText);

		//bg.color = getCurrentBGColor();
		//intendedColor = bg.color;
		changeSelection();

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);
		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, "Directionnal arrows to naviguate / Press ENTER to check the twitter page.", 18);
		text.setFormat(Paths.font("vcr.ttf"), 18, FlxColor.WHITE, CENTER);
		text.scrollFactor.set();
		add(text);

		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.add(camAchievement);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var leftP = controls.UI_LEFT_P;
		var rightP = controls.UI_RIGHT_P;

		if (upP)
		{
			changeSelection(-1,0);
		}
		if (downP)
		{
			changeSelection(1,0);
		}
		if (rightP)
		{
			changeSelection(0,1);
		}
		if (leftP)
		{
			changeSelection(0,-1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.sound.playMusic(Paths.music('Affinity', 'date-night masses'), 0);
			FlxG.sound.music.fadeIn(4, 0, 0.7);
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0, changecolumn:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		if (curSelected % 3 == 2 && change > 0) {
			change = 0;
		} 
		else if (curSelected % 3 == 0 && change < 0) 
		{
			change = 0;
		} 

		curSelected += change;
		curSelected += changecolumn * 3;

		/*
		var skipChange = 0;
		var skipChangeColumn = 0;

		while (creditsStuff[curSelected][0] == '' && (curSelected >= creditsStuff.length || curSelected < 0)) {
			curSelected += change + (changecolumn * 3);
			skipChange += change;
			skipChangeColumn += changecolumn;
		}


		
		if (curSelected < 0) curSelected -= change + skipChange + (changecolumn * 3) + (skipChangeColumn * 3);
		if (curSelected >= creditsStuff.length) curSelected -= change + skipChange + (changecolumn * 3) + (skipChangeColumn * 3);
		*/
		if (curSelected < 0) curSelected -= change + (changecolumn * 3);
		if (curSelected >= creditsStuff.length) curSelected -= change + (changecolumn * 3);
		if (creditsStuff[curSelected][0] == '') curSelected -= change + (changecolumn * 3);
		trace(curSelected);

		if (curSelected < page * 6) page --;
		else if (curSelected >= (page + 1) * 6) page ++;

		#if ACHIEVEMENTS_ALLOWED
		if (page == 9) {
			Achievements.loadAchievements();
			var achieveID:Int = Achievements.getAchievementIndex('best_team');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement('best_team');
				ClientPrefs.saveSettings();
			}
		}
		#end

		var bullShit:Int = 0;
		
		changePage();

		descText.text = creditsStuff[curSelected][2];

		var dialogueValue = Std.random(3) + 4;
		if (creditsStuff[curSelected][dialogueValue] == '' || creditsStuff[curSelected][dialogueValue] == null) dialogueText.text = '';
		else {
			if (creditsStuff[curSelected][dialogueValue].startsWith("\n")) {
				dialogueText.text = '\n"' + creditsStuff[curSelected][dialogueValue].substr(1) + '"';
			} else {
				dialogueText.text = '"' + creditsStuff[curSelected][dialogueValue] + '"';
			}
		}
	}

	function changePage() {
		var i = 0;

		for (item in grpTwitter.members)
		{
			if (pageDisplay(i, 6)) item.visible = true;
			else {
				item.visible = false;
			}

			if (i == curSelected) {
				item.setFormat(Paths.font("vcr.ttf"), 14, 0xFFe55777, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			} else {
				item.setFormat(Paths.font("vcr.ttf"), 14, FlxColor.BLACK, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
			}
			i ++;
		}
		i = 0;

		for (item in grpOptions.members)
		{
			if (pageDisplay(i, 6)) item.visible = true;
			else {
				item.visible = false;
			}

			if (i == curSelected) {
				item.setFormat(Paths.font("vcr.ttf"), 28, 0xFFe55777, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			} else {
				item.setFormat(Paths.font("vcr.ttf"), 28, FlxColor.BLACK, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
			}
			i ++;
		}

		for (j in 0...iconArray.length)
		{ 
			if (creditsStuff[j][0] != '' && pageDisplay(j, 6)) iconArray[j].visible = true;
			else {
				iconArray[j].visible = false;
			}
		}

		pagetitleText.text = titleStuff[page * 2];
		pagetitleText2.text = titleStuff[page * 2 + 1];
		pageText.text = 'page ' + (page + 1) + "/" + titleStuff.length/2;
	}

	function pageDisplay(compare:Int, pageLength:Int):Bool {
		return compare >= page * pageLength && compare < (page + 1) * pageLength;
	}

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
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