import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.FlxSprite;

class OptionsDirect extends MusicBeatState
{
	override function create()
	{
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = true;

		var menuBG = new FlxSprite().loadGraphic(Paths.image('menu_bg/menuBGset1-desat', 'date-night masses'));

		if (MainMenuState.chosenMenu >= 7 && MainMenuState.chosenMenu <= 9)
		{
			menuBG = new FlxSprite().loadGraphic(Paths.image('menu_bg/menuBGset2-desat', 'date-night masses'));
		}

		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = FlxG.save.data.antialiasing;
		add(menuBG);

		openSubState(new OptionsMenu());
	}
}
