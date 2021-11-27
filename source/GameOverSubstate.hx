package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Character;
	var ruv:RuvDeath;
	var camFollow:FlxObject;
	var daBf:String = '';

	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.Stage.curStage;
		switch (PlayState.boyfriend.curCharacter)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'ruv':
				daBf = 'deadruv';
			case 'sticky':
				daBf = 'sticky';
			default:
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;

		if (daBf == 'deadruv')
		{
			ruv = new RuvDeath(x, y);
			add(ruv);
			camFollow = new FlxObject(ruv.getGraphicMidpoint().x, ruv.getGraphicMidpoint().y, 1, 1);
			add(camFollow);
			ruv.playAnim('firstDeath');
		}
		else
		{
			bf = new Character(x, y, daBf);
			add(bf);
			camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
			add(camFollow);
			bf.playAnim('firstDeath');
		}

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;
	}

	var startVibin:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (FlxG.save.data.InstantRespawn)
		{
			LoadingState.loadAndSwitchState(new PlayState());
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
			{
				GameplayCustomizeState.freeplayBf = 'bf';
				GameplayCustomizeState.freeplayDad = 'dad';
				GameplayCustomizeState.freeplayGf = 'gf';
				GameplayCustomizeState.freeplayNoteStyle = 'normal';
				GameplayCustomizeState.freeplayStage = 'stage';
				GameplayCustomizeState.freeplaySong = 'bopeebo';
				GameplayCustomizeState.freeplayWeek = 1;
				FlxG.switchState(new StoryMenuState());
			}
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
			PlayState.stageTesting = false;
		}

		if (daBf == 'deadruv')
		{
			if (ruv.animation.curAnim.name == 'firstDeath' && ruv.animation.curAnim.curFrame == 12)
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.01);
			}
			if (ruv.animation.curAnim.name == 'firstDeath' && ruv.animation.curAnim.finished)
			{
				FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
				startVibin = true;
			}
		}
		else
		{
			if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.01);
			}
			if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
			{
				FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
				startVibin = true;
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		if (startVibin && !isEnding)
		{
			if (daBf == 'ruv')
			{
				ruv.playAnim('deathLoop', true);
			}
			else
			{
				bf.playAnim('deathLoop', true);
			}
		}
		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			PlayState.startTime = 0;
			isEnding = true;
			if (daBf == 'ruv')
			{
				ruv.playAnim('deathConfirm');
			}
			else
			{
				bf.playAnim('deathConfirm', true);
			}
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
					PlayState.stageTesting = false;
				});
			});
		}
	}
}
