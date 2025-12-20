package backend;

import flixel.util.FlxGradient;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;

	var isTransIn:Bool = false;

	var transBlack:FlxSolid;
	var transBlack2:FlxSolid;
	var transWhite:FlxSolid;
	var transIdle:FlxTimer;
	var transGradient:FlxSprite;

	var duration:Float;

	public function new(duration:Float, isTransIn:Bool) {
		this.duration = duration;
		this.isTransIn = isTransIn;
		super();
	}

	override function create() {
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
		var width:Int = Std.int(FlxG.width / Math.max(camera.zoom, 0.001));
		var height:Int = Std.int(FlxG.height / Math.max(camera.zoom, 0.001));

		transWhite = new FlxSolid().makeSolid(FlxG.width, FlxG.height, FlxColor.WHITE);
		transWhite.updateHitbox();
		transWhite.scrollFactor.set();
		transWhite.screenCenter(XY);
		transWhite.alpha = 0;
		add(transWhite);

		transBlack = new FlxSolid().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
		transBlack.updateHitbox();
		transBlack.scrollFactor.set();
		transBlack.screenCenter(X);
		transBlack.alpha = 1;
		add(transBlack);

		transBlack2 = new FlxSolid().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
		transBlack2.updateHitbox();
		transBlack2.scrollFactor.set();
		transBlack2.screenCenter(X);
		transBlack2.alpha = 1;
		add(transBlack2);



		if (!isTransIn)
		{
		transWhite.alpha = 0;
		transBlack.y = -FlxG.height; //top bar
		transBlack2.y = FlxG.height; //bot bar

		FlxTween.tween(transBlack, {y: -(FlxG.height/2)}, duration, {ease: FlxEase.quartInOut});

		FlxTween.tween(transBlack2, {y: (FlxG.height/2)}, duration, {ease: FlxEase.quartInOut});

		FlxTween.tween(transWhite, {alpha: 1}, duration, {ease: FlxEase.quartInOut, onComplete:function(twn:FlxTween) 
			{
			for (i in FlxG.cameras.list)
            i.alpha = 0;
			close();
			if (finishCallback != null)
			finishCallback();
			finishCallback = null;	
			killll();
			}});
		}
		if (isTransIn)
		{
		transWhite.alpha = 1;
		transBlack.y = -(FlxG.height/2); //top bar
		transBlack2.y = (FlxG.height/2); //bot bar
			for (i in FlxG.cameras.list)
            i.alpha = 1; 
		FlxTween.tween(transBlack, {y: -FlxG.height}, duration, {ease: FlxEase.quartInOut});

		FlxTween.tween(transBlack2, {y: FlxG.height}, duration, {ease: FlxEase.quartInOut});

		FlxTween.tween(transWhite, {alpha: 0}, duration, {ease: FlxEase.quartInOut, onComplete:function(twn:FlxTween) 
			{
			close();
			if (finishCallback != null)
			finishCallback();
			finishCallback = null;	
			killll();
			}
		});		
		

		//transIdle = new FlxTimer().start(duration, function(tmr:FlxTimer)
		//{

		//}, 0);
		}


		super.create();
	}

	function killll() {
		transWhite.kill();
		transWhite.destroy();
		transBlack.kill();
		transBlack.destroy();
		transBlack2.kill();
		transBlack2.destroy();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);



		/*final height:Float = FlxG.height * Math.max(camera.zoom, 0.001);
		final targetPos1:Float = transBlack.height + 50 * Math.max(camera.zoom, 0.001);
		final targetPos2:Float = -transBlack2.height - 50 * Math.max(camera.zoom, 0.001);


		if (duration > 0)
		{
			transBlack.y += (height + targetPos1) * elapsed / duration;
			transBlack2.y -= (height + targetPos2) * elapsed / duration;
		}
		else
		{
			transBlack.y += (targetPos1) * elapsed;
			transBlack2.y += (targetPos2) * elapsed;		
		}
		if (isTransIn)
		{
			transBlack.y = transBlack.y + transBlack.height;
			transBlack2.y = -transBlack2.y + transBlack2.height;
		}
		else
		{
			transBlack.y = transBlack.y - transBlack.height;
			transBlack2.y = -transBlack2.y - transBlack.height;
		}
		if (transBlack.y >= targetPos1) {
			close();
			if (finishCallback != null)
				finishCallback();
			finishCallback = null;
		}*/
	}
}
