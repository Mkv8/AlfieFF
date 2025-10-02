package states.stages;

import objects.Character;
import backend.BaseStage;

import hxcodec.VideoSprite;
import openfl.display.BlendMode;
import backend.BaseStage;
import states.stages.objects.*;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxEmitter;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import objects.StrumNote;
import Shaders;
import openfl.Lib;
import utils.TransNdll;
import lime.app.Application;

class Desktop extends BaseStage {

	//var bg:BGSprite;
	var crack:BGSprite;
	var introtext:BGSprite;
	var lasteye:BGSprite;


	var blackscreen:BGSprite;

	public var introVideo:VideoSprite;
	public var midVideo:VideoSprite;

	var animtimer:FlxTimer;
	var gs:ReplaceCol;

	//THIS IS COMMENTED SHADER CODE
	//I COMMENTED IT BECAUSE I THINK THE CHROMATIC ABBERRATION EFFECT MIGHT LOOK BAD HERE, IF YOU THINK WE SHOULD KEEP IT, FEEL FREE TO PLAY AROUND WITH IT
	//EVEN THOUGH I DISABLED THE SHADERS, FOR SOME REASON THE SCANLINE EFFECT WON'T GO AWAY, IDK WHY

	/*var shader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.PostProcessing()),
	];*/

	/*var curveShader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.CurveShader()),
	];*/

	//var curveShader = new shaders.CurveShader();

	function windowsFullscreen()
	{
		Lib.application.window.fullscreen = false;
	}

	override function create() {

		game.destroyFunction = function():Void  {
			TransNdll.setWindowTransparent(false);
			Lib.application.window.resizable = true;
			Lib.application.window.borderless = false;
			Application.current.window.title = Main.appTitle;
			Application.current.window.onFullscreen.remove(windowsFullscreen);
			Main.fpsVar.x = 10;
			Lib.application.window.maximized = false;
			new FlxTimer().start(0.05, function(tmr:FlxTimer)
			{
				Lib.application.window.maximized = true;
			});
			trace("destroying desktop stage");
		};

		

		/*bg = new BGSprite(null, 0, 0, 1, 1); //idk if this is even needed but i made a black bg anyways
		bg.makeGraphic(Std.int(FlxG.width), Std.int(FlxG.height), FlxColor.BLACK); 
		bg.screenCenter(XY);
		bg.updateHitbox();
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.alpha = 1;
		add(bg);*/

		Lib.application.window.fullscreen = false;
		Lib.application.window.maximized = false;
		new FlxTimer().start(0.05, function(tmr:FlxTimer)
		{
			Lib.application.window.maximized = true;
		});

		introtext = new BGSprite('eotbAssets/introText', -340, -220, 1, 1, ['textExport']); 
		introtext.updateHitbox();
		introtext.scale.set(1.35,1.35);
		introtext.antialiasing = ClientPrefs.data.antialiasing;
		add(introtext);
		introtext.animation.pause();

		lasteye = new BGSprite('eotbAssets/lastWindow', 0, 720, 1,1, ['eye'],true); //This is for outro, gonna let u position this one cuz idk how ur gonna do it
		lasteye.updateHitbox();
		lasteye.antialiasing = ClientPrefs.data.antialiasing;
		lasteye.animation.play("eye",true);
		lasteye.alpha = 0;
		lasteye.cameras = [camOther];
		add(lasteye);

		crack = new BGSprite('eotbAssets/lastPhaseCrack', -440, -250, 1, 1, ['LAST SHARDS']); 
		crack.updateHitbox();
		crack.alpha = 0;
		crack.scale.set(1.35,1.35);
		crack.antialiasing = ClientPrefs.data.antialiasing;
		//This is for when he breaks the screen near the end, im gonna ask you to position this better cuz im not entirely sure how its gonna look when its all done...
		add(crack);

		gs = new ReplaceCol();
		gs.set([16,20,0],[0,0,0],0,[16,20,0],[0,0,0],0);

		Application.current.window.onFullscreen.add(windowsFullscreen);
	}

	override function createPost() {


		introVideo = new VideoSprite();
		introVideo.playVideo(Paths.video("EOTBintro"),false,false,true);
		introVideo.cameras = [camOther];
		introVideo.scale.set(1,1);
		introVideo.x = 0;
		introVideo.y= 0;   
		
		introVideo.antialiasing = ClientPrefs.data.antialiasing;
		add(introVideo);

		midVideo = new VideoSprite();
		midVideo.playVideo(Paths.video("EOTBmidCutscene"),false,false,true);
		midVideo.cameras = [camVideo];
		midVideo.scale.set(1,1);
		midVideo.shader = gs.shader;
		midVideo.x = 0;
		midVideo.y= 0;   
		
		midVideo.antialiasing = ClientPrefs.data.antialiasing;
		add(midVideo);


		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.cameras = [camOther];
		blackscreen.alpha = 1;
		add(blackscreen);

		//THIS IS COMMENTED SHADER CODE
		/*FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

		PlayState.instance.camHUD.setFilters([new ShaderFilter(curveShader)]);
		PlayState.instance.camHUD.filtersEnabled = true;

		PlayState.instance.camGame.setFilters([new ShaderFilter(curveShader)]);
		PlayState.instance.camGame.filtersEnabled = true;

		curveShader.chromOff = 3.5;*/

		
	}

	override function update(elapsed:Float) {
		// Code here
	}

	override function countdownTick(count:Countdown, num:Int)
		{
			switch(count)
			{
				case THREE: //num 0
				case TWO: //num 1
				case ONE: //num 2
				case GO: //num 3
				case START: //num 4
				{
				camHUD.alpha = 0;
				introVideo.bitmap.startPos = Std.int(Conductor.songPosition);
				introVideo.bitmap.playCached();
				introVideo.alpha = 1;
				dad.alpha = 0;
					for (i in 0...4)
					{
    				switch (i)
   					{
			        case 0:
						PlayState.playerStrums.members[i].x = 250;
        			case 1:
						PlayState.playerStrums.members[i].x = 400;
        			case 2:
						PlayState.playerStrums.members[i].x = 750;
					case 3:
						PlayState.playerStrums.members[i].x = 900;
    				}
					}
				FlxTween.tween(blackscreen, {alpha: 0}, 0.5);
				
				animtimer = new FlxTimer().start(16, function(tmr:FlxTimer)
						{
							introVideo.alpha = 0;
							introVideo.kill();
						});
			}
			}
	}


	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit() {

			switch (curStep) {
	
				case 136:
					{
						FlxTween.tween(introtext, {alpha: 1}, 0.5);
						introtext.animation.play('textExport', true, false);
						FlxTween.tween(dad, {alpha: 1}, 0.5);
						dad.dontInterrupt = true;
						dad.animation.play('open', true);
						dad.animation.pause();
						
	

					}

				case 168:
					dad.animation.play('open', true);
					dad.animation.finishCallback = function(name:String) 
					{
						dad.dontInterrupt = false;
					};
	
				case 896:
					{
						FlxTween.tween(midVideo, {alpha: 1}, 1);
						midVideo.bitmap.startPos = Std.int(Conductor.songPosition);
						midVideo.bitmap.playCached();
						FlxTween.tween(dad, {alpha: 0}, 1.5);
						FlxTween.tween(camHUD, {alpha: 0}, 0.5);
						PlayState.scoreTxt.visible = false;

						Lib.application.window.resizable = false;

						Lib.application.window.fullscreen = false;
						new FlxTimer().start(0.05, function(tmr:FlxTimer)
						{
							Lib.application.window.maximized = true;
						});
						Application.current.window.title = "???";
					}	
								

				case 950:
					TransNdll.setWindowTransparent(true);
				case 961:
					{
						
						Lib.application.window.borderless = true;
						Main.fpsVar.x = -1280;
						
						dad.alpha = 1;
						FlxTween.tween(camHUD, {alpha: 1}, 0.5);
						//This is the part where the glass shards fall, he is already visible, so I set his alpha to 1, you dont need to do anything here.
					}				
					
	
				case 2240:
					{
						crack.alpha = 1;
						crack.animation.play('LAST SHARDS', true, false); 
						crack.animation.finishCallback = function(name:String){
							crack.destroy();
						}
						new FlxTimer().start(0.03, function(tmr:FlxTimer)
						{
							TransNdll.setWindowTransparent(false);
							Lib.application.window.y = 0;
							Lib.application.window.height = Lib.application.window.height + 32;
							for (camera in FlxG.cameras.list) camera.y += 32;
							camOther.y -= 32;
						});
						
						//Lib.application.window.borderless = false;
						//Main.fpsVar.x = 10;
						//THIS IS WHERE HE HITS THE SCREEN
					}	
				case 2256:
					dad.alpha = 0;
				case 2307:
					{
						
						dad.setZoom(0.875, 0.875); //I feel like this doesn't work, or at least I didn't see any difference, can you check?
					}	
				case 2336:
					{
						FlxTween.tween(dad, {alpha: 1}, 1);
					}	
				case 3392:
					{
						game.fakeBotplay = true;
						dad.dontInterrupt = true;
						dad.animation.pause();
						var shkint = 4;
						FlxTween.num(0, 0, 5.8, {}, function (v:Float) {
							Lib.application.window.y = extraY + FlxG.random.int(-shkint,shkint);
							Lib.application.window.x =FlxG.random.int(-shkint,shkint);
						});
						blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.WHITE);
						blackscreen.alpha = 0.55;
						blackscreen.cameras = [camOther];
						crack.visible = false;
						//THIS IS WHERE HE BUGS OUT AND THE SONG ENDS... 
						//Can you make him disappear in some way? either fade him out or move him in some way, I'm leavin this to your personal preference
					}	
				case 3432:	
					FlxTween.num(extraY, Lib.application.window.display.bounds.height*1.5, 2, {ease:FlxEase.cubeInOut}, function (v:Float) {
						extraY = Std.int(v);
					});
				case 3460:
					TransNdll.setWindowTransparent(true);
					Lib.application.window.borderless = true;
					dad.visible = camHUD.visible = blackscreen.visible = false;
					Main.fpsVar.x = -1280;
					game.camZooming = false;
				case 3465:
					Lib.application.window.y = 0;
				case 3472:
					{
						//ENDING OF THE SONG: This is the end of the song, what happens here is that a window shows up with the lasteye sprite, the window comes from
						//the bottom of the screen and tweens to the middle, where the eye is just looking at you for a while, at around Step 3600, the window starts getting smaller as he disappears
						//the song ends after that.
						lasteye.alpha = 1;
						FlxTween.num(720, 0, 3, {ease:FlxEase.sineOut}, function (v:Float) {
							lasteye.y = v;
						});

						var elapsed = 0.0;
						FlxTween.num(0, 0, 60, {}, function (v:Float) {
							elapsed += FlxG.elapsed;
							lasteye.scale.set(0.6+Math.sin(elapsed)*0.0215,!changeY ? (0.6+Math.cos(elapsed)*0.0215) : Yto);
							if (!changeY)
								Yto = curY = 0.6+Math.cos(elapsed)*0.0215;
						});
					}	
				case 3600:
					changeY = true;
					FlxTween.num(curY, 0, 2.4, {ease:FlxEase.sineOut}, function (v:Float) {
						Yto = v;
					});						
			}
	
	}

	var extraY = 0;
	var curY = 0.0;
	var changeY = false;
	var Yto = 0.0;

	override function beatHit() {
		everyoneDance();

		
		switch (curBeat) {
			case 48:
				{
					FlxTween.tween(introtext, {alpha: 0}, 1.5);
					FlxTween.tween(camHUD, {alpha: 1}, 1.5);

				}
			
			}
	}

	function everyoneDance() {

	}

	override function sectionHit() {
		// Code here
	}

	// Substates for pausing/resuming tweens and timers


	override function onFocusLost()
		{
			// Code here
			if (introVideo != null)
				introVideo.bitmap.pause();
			
			if (midVideo != null)
				midVideo.bitmap.pause();			
		}
	
		override function onFocus()
		{
			if (introVideo != null && !paused)
				introVideo.bitmap.resume();

			if (midVideo != null && !paused)
				midVideo.bitmap.resume();
		}
	

	override function closeSubState() {
		if(paused)
			{
				if (introVideo != null && introVideo.alpha == 1)
					introVideo.bitmap.resume();

				if (midVideo != null && midVideo.alpha == 1)
					midVideo.bitmap.resume();				
			}
	}

	override function openSubState(SubState:flixel.FlxSubState) {
		if(paused)
			{
				if (introVideo != null)
					introVideo.bitmap.pause();

				if (midVideo != null)
					midVideo.bitmap.pause();				
			}
	}

	// For events
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float) {
		switch (eventName) {
			case "My Event":
		}
	}

	override function eventPushed(event:objects.Note.EventNote) {
		// used for preloading assets used on events that doesn't need different assets based on its values
		switch (event.event) {
			case "My Event":
				// precacheImage('myImage') //preloads images/myImage.png
				// precacheSound('mySound') //preloads sounds/mySound.ogg
				// precacheMusic('myMusic') //preloads music/myMusic.ogg
		}
	}

	override function eventPushedUnique(event:objects.Note.EventNote) {
		// used for preloading assets used on events where its values affect what assets should be preloaded
		switch (event.event) {
			case "My Event":
				switch (event.value1) {
					// If value 1 is "blah blah", it will preload these assets:
					case 'blah blah':
						// precacheImage('myImageOne') //preloads images/myImageOne.png
						// precacheSound('mySoundOne') //preloads sounds/mySoundOne.ogg
						// precacheMusic('myMusicOne') //preloads music/myMusicOne.ogg

						// If value 1 is "coolswag", it will preload these assets:
					case 'coolswag':
						// precacheImage('myImageTwo') //preloads images/myImageTwo.png
						// precacheSound('mySoundTwo') //preloads sounds/mySoundTwo.ogg
						// precacheMusic('myMusicTwo') //preloads music/myMusicTwo.ogg

						// If value 1 is not "blah blah" or "coolswag", it will preload these assets:
					default:
						// precacheImage('myImageThree') //preloads images/myImageThree.png
						// precacheSound('mySoundThree') //preloads sounds/mySoundThree.ogg
						// precacheMusic('myMusicThree') //preloads music/myMusicThree.ogg
				}
		}
	}
}
