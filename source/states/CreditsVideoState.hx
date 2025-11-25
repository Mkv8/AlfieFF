package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;
import objects.HealthIcon;
import objects.MusicPlayer;
import substates.GameplayChangersSubstate;
import substates.ResetScoreSubState;
import flixel.math.FlxMath;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import hxcodec.VideoSprite;

class CreditsVideoState extends MusicBeatState {


	var panelNum:Int = 0;
	var panels:Array<FlxSprite> = [];
	var object:FlxSprite = null;
	var debugText:FlxText;
	var pressEnterText:FlxText;
	var canSpam:Bool = true;
	var data:Array<Dynamic> = [];
	var forceNumber = 0;
	var shader:Array<BitmapFilter> = [new ShaderFilter(new shaders.PostProcessing()),];
	var curveShader = new shaders.CurveShader();
	var player:MusicPlayer;
	public static var itsgivingendcard:Bool;

	public var videoSprite:VideoSprite;

	override function create() {

		videoSprite = new VideoSprite();
		videoSprite.playVideo(Paths.video("creditsVideo"),false,false,true);//cached but not gonna start to play
		videoSprite.scale.set(0.8,0.8);
		//videoSprite.screenCenter();
		videoSprite.x = -145;
		videoSprite.y = -90;
		videoSprite.visible = true;
		videoSprite.antialiasing = ClientPrefs.data.antialiasing;
		add(videoSprite);
		videoSprite.bitmap.startPos = Std.int(Conductor.songPosition);
		videoSprite.finishCallback = function() {
		exit();
		}

		var blackscreen:BGSprite;
		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.alpha = 1;
		add(blackscreen);

		FlxTween.tween(blackscreen, {
			alpha: 0
		}, 1, {
			ease: FlxEase.quartInOut,
			startDelay: 0.5
		});	

		var videoStart:FlxTimer;
		videoStart = new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{videoSprite.bitmap.playCached(); trace('is it playing lmao');}, 0);
		

		super.create();
		FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

		FlxG.camera.setFilters([new ShaderFilter(curveShader)]);
		FlxG.camera.filtersEnabled = true;

		curveShader.chromOff = 2;

	}


	override function update(elapsed:Float) {



		var back = FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.ESCAPE;

		if (back) {
			FlxG.sound.play(Paths.sound('cancelMenu'));

			var transitionSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        	transitionSprite.alpha = 0;
        	add(transitionSprite);
			FlxTween.tween(transitionSprite, {alpha: 1}, 1, {ease: FlxEase.quartOut, onComplete:function(twn:FlxTween) {exit();}});
			canSpam = false;
		}

		super.update(elapsed);
	}


var went:Bool = false;
function exit(){

    if (went)
        return;

    went=true;
		videoSprite.destroy();
		if (FlxG.sound.music != null)
		{FlxG.sound.music.stop();}
		FlxG.sound.playMusic(Paths.music('freakyMenu'));
		MusicBeatState.switchState(new MainMenuState());
}

}
