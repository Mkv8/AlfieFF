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

class MansionTop extends BaseStage {
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	var cloudbig:BGSprite;
	var cloudsmall:BGSprite;
	var bg:BGSprite;
	var rooftop:BGSprite;
	var shootingstar:BGSprite;
	var spotlight:BGSprite;

	var circle1:BGSprite;
	var circle2:BGSprite;
	var circle3:BGSprite;


	var concept:BGSprite;

	var multiply:BGSprite;

	var topBar:BGSprite;
	var botBar:BGSprite;
	var blackscreen:BGSprite;

	public var videoSprite:VideoSprite;

	var animtimer:FlxTimer;



	var shader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.PostProcessing()),
	];

	/*var curveShader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.CurveShader()),
	];*/

	var curveShader = new shaders.CurveShader();

	override function create() {
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		// concept = new BGSprite('forest/concept', 0, 0, 1, 1);
		// concept.updateHitbox();
		// add(concept);

		bg = new BGSprite('nikkurooftop/bgRooftop', 0, 0, 1, 1);
		bg.updateHitbox();
		bg.scale.set(1.1, 1.1);
		bg.antialiasing = ClientPrefs.data.antialiasing;

		bg.alpha = 1;
		add(bg);

		cloudbig = new BGSprite('nikkurooftop/cloudBig', -500, 400, 1, 1);
		cloudbig.updateHitbox();
		cloudbig.scale.set(1.1, 1.1);
		cloudbig.antialiasing = ClientPrefs.data.antialiasing;

		cloudbig.alpha = 1;
		add(cloudbig);

		cloudsmall = new BGSprite('nikkurooftop/cloudSmall', -500, 100, 1, 1);
		cloudsmall.updateHitbox();
		cloudsmall.scale.set(1.1, 1.1);
		cloudsmall.antialiasing = ClientPrefs.data.antialiasing;

		cloudsmall.alpha = 1;
		add(cloudsmall);

		rooftop = new BGSprite('nikkurooftop/rooftopAsset', 0, 0, 1, 1);
		rooftop.updateHitbox();
		rooftop.scale.set(1.1, 1.1);
		rooftop.antialiasing = ClientPrefs.data.antialiasing;

		rooftop.alpha = 1;
		add(rooftop);

		spotlight = new BGSprite('nikkurooftop/spotlight', 0, 0, 1, 1);
		spotlight.updateHitbox();
		spotlight.scale.set(1.1, 1.1);
		spotlight.antialiasing = ClientPrefs.data.antialiasing;
		spotlight.blend = BlendMode.MULTIPLY;
		spotlight.alpha = 1;
		//add(spotlight);

		circle1 = new BGSprite('nikkurooftop/circle1', 0, 0, 1, 1);
		circle1.updateHitbox();
		circle1.scale.set(1.1, 1.1);
		circle1.antialiasing = ClientPrefs.data.antialiasing;

		circle1.alpha = 0;
		add(circle1);

		circle2 = new BGSprite('nikkurooftop/circle2', 0, 0, 1, 1);
		circle2.updateHitbox();
		circle2.scale.set(1.1, 1.1);
		circle2.antialiasing = ClientPrefs.data.antialiasing;

		circle2.alpha = 0;
		add(circle2);

		circle3 = new BGSprite('nikkurooftop/circle3', 0, 0, 1, 1);
		circle3.updateHitbox();
		circle3.scale.set(1.1, 1.1);
		circle3.antialiasing = ClientPrefs.data.antialiasing;

		circle3.alpha = 0;
		add(circle3);

		shootingstar = new BGSprite('nikkurooftop/shootingstar', 1200, 250, 1, 1, ['shoot']);
		shootingstar.updateHitbox();
		shootingstar.scale.set(1.2, 1.2);
		shootingstar.antialiasing = ClientPrefs.data.antialiasing;
		shootingstar.alpha = 1;

		add(shootingstar);
	}

	override function createPost() {
		// Use this function to layer things above characters


		multiply = new BGSprite('nikkurooftop/rooftopMultiply', 0, 0, 1, 1);
		multiply.updateHitbox();
		bg.scale.set(1.1, 1.1);
		//multiply.alpha = 0.44;
		multiply.blend = BlendMode.MULTIPLY;
		add(multiply);

		concept = new BGSprite('nikkurooftop/concept', 0, 0, 1, 1);
		concept.updateHitbox();
		concept.alpha = 0.3;
		concept.antialiasing = ClientPrefs.data.antialiasing;
		//add(concept);

		videoSprite = new VideoSprite();
		videoSprite.playVideo(Paths.video("nikkuIntro"),false,false,true);//cached but not gonna start to play
		videoSprite.cameras = [camOther];
		videoSprite.scale.set(1,1);
		//videoSprite.screenCenter();
		videoSprite.x = 0;
		videoSprite.y= 0;   
		
		videoSprite.antialiasing = ClientPrefs.data.antialiasing;
		add(videoSprite);

		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.cameras = [camOther];
		blackscreen.alpha = 0;
		add(blackscreen);

		topBar = new BGSprite(null, 0, -360, 1, 1);
		topBar.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height), FlxColor.BLACK);
		topBar.alpha = 1;
		topBar.cameras = [camOther];
		add(topBar);

		botBar = new BGSprite(null, 0, 360, 1, 1);
		botBar.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 2), FlxColor.BLACK);
		botBar.alpha = 1;
		botBar.cameras = [camOther];
		add(botBar);




		FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

		PlayState.instance.camHUD.setFilters([new ShaderFilter(curveShader)]);
		PlayState.instance.camHUD.filtersEnabled = true;

		PlayState.instance.camGame.setFilters([new ShaderFilter(curveShader)]);
		PlayState.instance.camGame.filtersEnabled = true;

		curveShader.chromOff = 3.5;

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
				videoSprite.bitmap.startPos = Std.int(Conductor.songPosition);
				videoSprite.bitmap.playCached();
				videoSprite.alpha = 1;
				//FlxTween.tween(blackscreen, {alpha: 0}, 0.5);
			}
			}
	}


	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit() {

		switch (curStep) {

			case 2213:
				{
					
				}
		}


	}

	override function beatHit() {
		everyoneDance();

		
		switch (curBeat) {

			case 2:
				{
					//camHUD.alpha = 0;

					FlxTween.tween(botBar, {y: 750}, 0.7, {ease: FlxEase.cubeInOut});
					FlxTween.tween(topBar, {y: -750}, 0.7, {ease: FlxEase.cubeInOut});
					for (i in 0...4)
					{
					PlayState.playerStrums.members[i].x -= 650;
					PlayState.opponentStrums.members[i].x += 650;
					}

				}

			case 28 | 377:
				{
					FlxTween.tween(botBar, {y: -360}, 0.9, {ease: FlxEase.cubeInOut});
					FlxTween.tween(topBar, {y: 360}, 0.9, {ease: FlxEase.cubeInOut});

				}

			case 32:
				{
					//topBar.cameras = [camGame];
					//botBar.cameras = [camGame];
					FlxTween.tween(botBar, {y: 750}, 1, {ease: FlxEase.cubeInOut});
					FlxTween.tween(topBar, {y: -750}, 1, {ease: FlxEase.cubeInOut});

				}	
			case 42: 
				{
					songDeets();
				}
			case 60 | 170 |  286 | 360:
				{
					shootingstar.animation.play('shoot', true, false, 0);
				}

			case 90 | 220 | 289:
				{
					cloudbig.x = -500;
					FlxTween.tween(cloudbig, {x: 2000}, 12);
				}

			case 120 | 190 | 315:
				{
					cloudsmall.x = -500;
					FlxTween.tween(cloudsmall, {x: 2000}, 12);
				}

			case 248:
				{
					FlxTween.tween(circle1, {alpha: 1}, 4 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeIn});
				}
			case 258:
				{
					FlxTween.tween(circle2, {alpha: 1}, 4 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeIn});
				}
			case 262:
				{
					FlxTween.tween(circle3, {alpha: 1}, 4 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeIn});
				}
			case 281:
				{
					FlxTween.tween(circle1, {alpha: 0}, 20 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeInOut});
					FlxTween.tween(circle2, {alpha: 0}, 20 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeInOut});
					FlxTween.tween(circle3, {alpha: 0}, 20 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeInOut});
				}
				
			
			}
	}

	function everyoneDance() {
		
	}

	function songDeets() {
		var songTitle:FlxText;
		var musician:FlxText;
		var charter:FlxText;
		var moontitle:BGSprite;
		var bartitle:BGSprite;
		var introTimer:FlxTimer;

		moontitle = new BGSprite('moonintro', 350, 100, 1, 1);
		moontitle.updateHitbox();
		moontitle.antialiasing = ClientPrefs.data.antialiasing;
		moontitle.alpha = 0;
		moontitle.angle = -5;
		moontitle.cameras = [camOther];
		moontitle.scale.set(0.8, 0.8);

		songTitle = new FlxText(20, 200, FlxG.width - 100, 'Rooftop Talkshop', 48);
		songTitle.setFormat(Paths.font("vcr.ttf"), 46, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		songTitle.scrollFactor.set();
		songTitle.alpha = 0;
		songTitle.borderColor = 0xFF3F0000;
		songTitle.borderSize = 3;
		songTitle.cameras = [camOther];

		musician = new FlxText(110, 300, FlxG.width - 100, 'Song: Gracio', 32);
		musician.setFormat(Paths.font("vcr.ttf"), 32, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		musician.scrollFactor.set();
		musician.alpha = 0;
		musician.borderColor = 0xFF3F0000;
		musician.borderSize = 3;		
		musician.cameras = [camOther];

		charter = new FlxText(110, 350, FlxG.width - 100, 'Charter: Chubby & PavDrop (Events)', 32);
		charter.setFormat(Paths.font("vcr.ttf"), 32, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		charter.scrollFactor.set();
		charter.alpha = 0;
		charter.borderColor = 0xFF3F0000;
		charter.borderSize = 3;		
		charter.cameras = [camOther];
		
		add(moontitle);
		add(songTitle);
		add(musician);		
		add(charter);		

		//STARTING TWEENS
		FlxTween.tween(moontitle, {
			alpha: 0.5,
			angle: 0
		}, 0.8, {
			ease: FlxEase.quartInOut,
		});		

		FlxTween.tween(songTitle, {
			alpha: 1,
			x: songTitle.x + 50
		}, 0.8, {
			ease: FlxEase.quartInOut,
			startDelay: 0.2
		});		


		FlxTween.tween(musician, {
			alpha: 1,
			x: musician.x - 50
		}, 0.8, {
			ease: FlxEase.quartInOut,
			startDelay: 0.4
		});				
		FlxTween.tween(charter, {
			alpha: 1,
			x: charter.x - 50
		}, 0.8, {
			ease: FlxEase.quartInOut,
			startDelay: 0.4
		});			
		
		
		//-----------------------------

		//ENDING TWEENS
		FlxTween.tween(moontitle, {
			alpha: 0,
			angle:  5			
		}, 1.2, {
			ease: FlxEase.quartInOut,
			startDelay: 2.5
		});		

		FlxTween.tween(songTitle, {
			alpha: 0,
			x: songTitle.x + 70,
			angle:  5			
		}, 1.2, {
			ease: FlxEase.quartInOut,
			startDelay: 2.5
		});		


		FlxTween.tween(musician, {
			alpha: 0,
			x: musician.x - 70,
			angle: 5
		}, 1.2, {
			ease: FlxEase.quartInOut,
			startDelay: 2.5
		});				
		FlxTween.tween(charter, {
			alpha: 0,
			x: charter.x - 70,
			angle: 5
		}, 1.2, {
			ease: FlxEase.quartInOut,
			startDelay: 2.5
		});


		//-----------------------------


		introTimer = new FlxTimer().start(4, function(tmr:FlxTimer)
			{
				moontitle.destroy();				
				songTitle.destroy();
				musician.destroy();
				charter.destroy();

			}, 0);
	}	
	override function sectionHit() {
		// Code here
	}

	// Substates for pausing/resuming tweens and timers


	override function onFocusLost()
		{
			// Code here
			if (videoSprite != null)
				videoSprite.bitmap.pause();
		}
	
		override function onFocus()
		{
			if (videoSprite != null && !paused)
				videoSprite.bitmap.resume();
		}
	

	override function closeSubState() {
		if(paused)
			{
				if (videoSprite != null && videoSprite.alpha == 1)
					videoSprite.bitmap.resume();
			}
	}

	override function openSubState(SubState:flixel.FlxSubState) {
		if(paused)
			{
				if (videoSprite != null)
					videoSprite.bitmap.pause();
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
