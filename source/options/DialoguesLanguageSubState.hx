package options;

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
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class DialoguesLanguageSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Cutscene Language';
		rpcTitle = 'Cutscene Language Menu'; //for Discord Rich Presence

		var option:Option = new Option('Language :',
			"Which language should be used for the dialogue cutscenes ?",
			'cutsceneLanguage',
			'string',
			'English',
			['English', 'French', 'Spanish', 'Danish', 'Korean', 'Chinese', 'Japanese','Polish']);
		addOption(option);
		super();
	}

}