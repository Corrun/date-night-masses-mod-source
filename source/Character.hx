package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.Assets as OpenFlAssets;
import haxe.Json;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';
	public var barColor:FlxColor;

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		barColor = isPlayer ? 0xFF66FF33 : 0xFFFF0000;
		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = FlxG.save.data.antialiasing;

		switch (curCharacter)
		{
			case 'kikyo':
				var tex = Paths.getSparrowAtlas('characters/Kikyo_assets', 'shared');
				frames = tex;

				animation.addByPrefix('idle', 'Kikyo IDLE', 24, false);
				animation.addByPrefix('singUP', 'Kikyo UP', 24, false);
				animation.addByPrefix('singLEFT', 'Kikyo LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Kikyo RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'Kikyo DOWN', 24, false);
				// flipX = true;

				loadOffsetFile(curCharacter);

				playAnim('idle');
				barColor = 0xFF442785;

			case "cringeSticky":
				var tex = Paths.getSparrowAtlas('characters/stickybm', 'shared');
				frames = tex;

				animation.addByPrefix('idle', 'stickybm idle', 24, false);
				animation.addByPrefix('singUP', 'stickybm sing up', 24, false);
				animation.addByPrefix('singLEFT', 'stickybm sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'stickybm sing right', 24, false);
				animation.addByPrefix('singDOWN', 'stickybm sing down', 24, false);

				animation.addByPrefix('firstDeath', "stickybm sing right", 24, false);
				animation.addByPrefix('deathLoop', "stickybm sing down", 24, false);
				animation.addByPrefix('deathConfirm', "stickybm sing down", 24, false);
				// flipX = true;

				playAnim('idle');
				barColor = 0xFF5AA06B;

			case "sticky":
				var tex = Paths.getSparrowAtlas('characters/Ruvvy', 'shared');
				frames = tex;

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, false);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);
				flipX = true;
				playAnim('idle');

				barColor = 0xFF5AA06B;

			case "ruv":
				tex = Paths.getSparrowAtlas('characters/ruv', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'ruv idle', 36);
				animation.addByPrefix('singUP', 'ruv up', 30);
				animation.addByPrefix('singRIGHT', 'ruv right', 20);
				animation.addByPrefix('singDOWN', 'ruv down', 20);
				animation.addByPrefix('singLEFT', 'ruv left', 30);

				animation.addByPrefix('singUPmiss', 'ruv miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'ruv miss', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'ruv miss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'ruv miss', 24, false);

				animation.addByPrefix('firstDeath', "deadruv firstDeath", 12, false);
				animation.addByPrefix('deathLoop', "deadruv deathLoop", 12, false);
				animation.addByPrefix('deathConfirm', "deadruv deathConfirm", 12, false);
				flipX = true;
				playAnim('idle');

				barColor = 0xFFa798af;
			case "deadruv":
				tex = Paths.getSparrowAtlas('characters/deadRuv', 'shared');
				frames = tex;
				animation.addByPrefix('firstDeath', 'deadRuv firstDeath', 24);
				animation.addByPrefix('deathLoop', 'deadRuv deathLoop', 24);
				animation.addByPrefix('deathConfirm', 'deadruv deathConfirm', 24);

				playAnim('firstDeath');
				barColor = 0xFFa798af;

			case "table-sarv":
				tex = Paths.getSparrowAtlas('characters/TableSarv', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'TableSarv idle', 12);
				animation.addByPrefix('singUP', 'TableSarv up', 12);
				animation.addByPrefix('singRIGHT', 'TableSarv right', 12);
				animation.addByPrefix('singDOWN', 'TableSarv down', 12);
				animation.addByPrefix('singLEFT', 'TableSarv left', 12);

				playAnim('idle');

				barColor = 0xFFd49dbd;
			case "buffsarv":
				tex = Paths.getSparrowAtlas('characters/buffsarv', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'arch0000', 12);
				animation.addByPrefix('singUP', 'arch0000', 12);
				animation.addByPrefix('singRIGHT', 'arch0001', 12);
				animation.addByPrefix('singDOWN', 'arch0002', 12);
				animation.addByPrefix('singLEFT', 'arch0003', 12);

				playAnim('idle');

				barColor = 0xFFd49dbd;
			default:
				parseDataFile();
		}

		if (curCharacter == 'table-sarv')
			this.scale.set(1.4, 1.4);
		if (curCharacter.startsWith('bf'))
			dance();

		if (isPlayer && frames != null)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	function parseDataFile()
	{
		Debug.logInfo('Generating character (${curCharacter}) from JSON data...');

		// Load the data from JSON and cast it to a struct we can easily read.
		var jsonData = Paths.loadJSON('characters/${curCharacter}');
		if (jsonData == null)
		{
			Debug.logError('Failed to parse JSON data for character ${curCharacter}');
			return;
		}

		var data:CharacterData = cast jsonData;

		var tex:FlxAtlasFrames = Paths.getSparrowAtlas(data.asset, 'shared');
		frames = tex;
		if (frames != null)
			for (anim in data.animations)
			{
				var frameRate = anim.frameRate == null ? 24 : anim.frameRate;
				var looped = anim.looped == null ? false : anim.looped;
				var flipX = anim.flipX == null ? false : anim.flipX;
				var flipY = anim.flipY == null ? false : anim.flipY;

				if (anim.frameIndices != null)
				{
					animation.addByIndices(anim.name, anim.prefix, anim.frameIndices, "", frameRate, looped, flipX, flipY);
				}
				else
				{
					animation.addByPrefix(anim.name, anim.prefix, frameRate, looped, flipX, flipY);
				}

				animOffsets[anim.name] = anim.offsets == null ? [0, 0] : anim.offsets;
			}

		barColor = FlxColor.fromString(data.barColor);

		playAnim(data.startingAnim);
	}

	public function loadOffsetFile(character:String, library:String = 'shared')
	{
		var offset:Array<String> = CoolUtil.coolTextFile(Paths.txt('images/characters/' + character + "Offsets", library));

		for (i in 0...offset.length)
		{
			var data:Array<String> = offset[i].split(' ');
			addOffset(data[0], Std.parseInt(data[1]), Std.parseInt(data[2]));
		}
	}

	override function update(elapsed:Float)
	{
		if (curCharacter != 'deadRuv')
		{
			if (!isPlayer)
			{
				if (animation.curAnim.name.startsWith('sing'))
				{
					holdTimer += elapsed;
				}

				if (curCharacter.endsWith('-car')
					&& !animation.curAnim.name.startsWith('sing')
					&& animation.curAnim.finished
					&& animation.getByName('idleHair') != null)
					playAnim('idleHair');

				if (animation.getByName('idleLoop') != null)
				{
					if (!animation.curAnim.name.startsWith('sing') && animation.curAnim.finished)
						playAnim('idleLoop');
				}

				var dadVar:Float = 4;

				if (curCharacter == 'dad')
					dadVar = 6.1;
				else if (curCharacter == 'gf' || curCharacter == 'spooky')
					dadVar = 4.1; // fix double dances
				if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
				{
					if (curCharacter == 'gf' || curCharacter == 'spooky')
						playAnim('danceLeft'); // overridden by dance correctly later
					dance();
					holdTimer = 0;
				}
			}

			switch (curCharacter)
			{
				case 'gf':
					if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					{
						danced = true;
						playAnim('danceRight');
					}
			}

			super.update(elapsed);
		}
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance(forced:Bool = false, altAnim:Bool = false)
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair') && !animation.curAnim.name.startsWith('sing'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'spooky':
					if (!animation.curAnim.name.startsWith('sing'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				/*
					// new dance code is gonna end up cutting off animation with the idle
					// so here's example code that'll fix it. just adjust it to ya character 'n shit
					case 'custom character':
						if (!animation.curAnim.name.endsWith('custom animation'))
							playAnim('idle', forced);
				 */
				default:
					if (altAnim && animation.getByName('idle-alt') != null)
						playAnim('idle-alt', forced);
					else
						playAnim('idle', forced);
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (AnimName.endsWith('alt') && animation.getByName(AnimName) == null)
		{
			#if debug
			FlxG.log.warn(['Such alt animation doesnt exist: ' + AnimName]);
			#end
			AnimName = AnimName.split('-')[0];
		}

		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}

typedef CharacterData =
{
	var name:String;
	var asset:String;
	var startingAnim:String;

	/**
	 * The color of this character's health bar.
	 */
	var barColor:String;

	var animations:Array<AnimationData>;
}

typedef AnimationData =
{
	var name:String;
	var prefix:String;
	var ?offsets:Array<Int>;

	/**
	 * Whether this animation is looped.
	 * @default false
	 */
	var ?looped:Bool;

	var ?flipX:Bool;
	var ?flipY:Bool;

	/**
	 * The frame rate of this animation.
	 		* @default 24
	 */
	var ?frameRate:Int;

	var ?frameIndices:Array<Int>;
}
