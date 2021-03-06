package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class GameOverState extends FlxTransitionableState
{
	var bfX:Float = 0;
	var bfY:Float = 0;

	public function new(x:Float, y:Float)
	{
		super();

		bfX = x;
		bfY = y;
	}

	override function create()
	{


		#if debug
		var debugMark:Alphabet = new Alphabet(0,0,"DEBUG",false,false,false);
		debugMark.alpha = 0.4;
		add(debugMark);
		#end
		var bf:Boyfriend = new Boyfriend(bfX, bfY);
		// bf.scrollFactor.set();
		add(bf);
		bf.playAnim('firstDeath'); 

		FlxG.camera.follow(bf, LOCKON, 0.001);
		/* 
			var restart:FlxSprite = new FlxSprite(500, 50).loadGraphic(AssetPaths.restart.png);
			restart.setGraphicSize(Std.int(restart.width * 0.6));
			restart.updateHitbox();
			restart.alpha = 0;
			restart.antialiasing = true;
			// add(restart); */

		FlxG.sound.music.fadeOut(2, FlxG.sound.music.volume * 0.6);

		// FlxTween.tween(restart, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
		// FlxTween.tween(restart, {y: restart.y + 40}, 7, {ease: FlxEase.quartInOut, type: PINGPONG});

		super.create();
	}

	private var fading:Bool = false;

	override function update(elapsed:Float)
	{
		var pressed:Bool = FlxG.keys.justPressed.ANY;

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if(FlxG.save.data.noDeathScreen)
			{
				fading = true;
				FlxG.sound.music.fadeOut(0.5, 0, function(twn:FlxTween)
				{
					FlxG.sound.music.stop();
					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
	
	

		if (gamepad != null)
		{
			if (gamepad.justPressed.ANY)
				pressed = true;
		}

		pressed = false;

		if (pressed && !fading)
		{
			fading = true;
			FlxG.sound.music.fadeOut(0.5, 0, function(twn:FlxTween)
			{
				FlxG.sound.music.stop();
				LoadingState.loadAndSwitchState(new PlayState());
				PlayState.resetScore();
			});
		}
		super.update(elapsed);
	}
}
