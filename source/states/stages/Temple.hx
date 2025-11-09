package states.stages;

import objects.Character;
import backend.BaseStage;

import openfl.display.BlendMode;
import backend.BaseStage;
import states.stages.objects.*;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxEmitter;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

class Temple extends BaseStage {
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	var templeSky:BGSprite;
	var templeBack:BGSprite;
	var templeFront:BGSprite;

	var topTemple:BGSprite;
	var sidePillar:BGSprite;
	var fgRubble:BGSprite;

	var concept:BGSprite;

	var multiply:BGSprite;
	var addlight:BGSprite;

	var fgsky:BGSprite;

	var blackscreen:BGSprite;

	var otherblackscreen:BGSprite;

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

		templeSky = new BGSprite('kaiTemple/templeSky', 0, 0, 0.8, 1);
		templeSky.scale.set(1.5, 1.5);
		templeSky.updateHitbox();
		templeSky.antialiasing = ClientPrefs.data.antialiasing;

		templeSky.alpha = 1;
		add(templeSky);
		//-----
		templeBack = new BGSprite('kaiTemple/templeBack', 0, 0, 0.9, 1);
		templeBack.scale.set(1.5, 1.5);
		templeBack.updateHitbox();
		templeBack.antialiasing = ClientPrefs.data.antialiasing;

		templeBack.alpha = 1;
		add(templeBack);
		//-----
		templeFront = new BGSprite('kaiTemple/templeFront', 0, 0, 1, 1);
		templeFront.scale.set(1.5, 1.5);
		templeFront.updateHitbox();
		templeFront.antialiasing = ClientPrefs.data.antialiasing;

		templeFront.alpha = 1;
		add(templeFront);
	}

	override function createPost() {
		// Use this function to layer things above characters
		
		multiply = new BGSprite('kaiTemple/templeMultiply', 0, 0, 1, 1);
		multiply.scale.set(1.5, 1.5);
		multiply.updateHitbox();
		//multiply.alpha = 0.44;
		multiply.blend = BlendMode.MULTIPLY;
		add(multiply);

		addlight = new BGSprite('kaiTemple/templeAdd', 0, 0, 1, 1);
		addlight.scale.set(1.5, 1.5);
		addlight.updateHitbox();
		addlight.blend = BlendMode.ADD;
		add(addlight);

		sidePillar = new BGSprite('kaiTemple/sidePillar', -40, 30, 0.9, 1);
		sidePillar.scale.set(1.5, 1.5);
		sidePillar.updateHitbox();
		sidePillar.antialiasing = ClientPrefs.data.antialiasing;

		sidePillar.alpha = 1;
		add(sidePillar);
		//-----
		fgRubble = new BGSprite('kaiTemple/fgRubble', 0, 1915, 0.75, 1);
		fgRubble.scale.set(1.5, 1.5);
		fgRubble.updateHitbox();
		fgRubble.antialiasing = ClientPrefs.data.antialiasing;

		fgRubble.alpha = 1;
		add(fgRubble);
		//-----
		topTemple = new BGSprite('kaiTemple/TopTemple', 0, -75, 1, 1);
		topTemple.scale.set(1.5, 1.5);
		topTemple.updateHitbox();
		topTemple.antialiasing = ClientPrefs.data.antialiasing;

		topTemple.alpha = 1;
		add(topTemple);
		//-----

		otherblackscreen = new BGSprite(null, 0, -1000, 1, 1);
		otherblackscreen.makeGraphic(3000, 3000, FlxColor.BLACK);
		otherblackscreen.alpha = 1;
		add(otherblackscreen);
		
		fgsky = new BGSprite('kaiTemple/sky', 0, -1500, 1, 1);
		fgsky.scale.set(1.65, 1.65);
		fgsky.updateHitbox();
		//fgsky.screenCenter(X);
		fgsky.antialiasing = ClientPrefs.data.antialiasing;

		fgsky.alpha = 1;
		add(fgsky);

		concept = new BGSprite('kaiTemple/concept', 0, -75, 1, 1);
		concept.scale.set(1.5, 1.5);
		concept.updateHitbox();
		concept.alpha = 0.3;
		concept.antialiasing = ClientPrefs.data.antialiasing;
		//add(concept);

		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.cameras = [camOther];
		blackscreen.alpha = 1;
		add(blackscreen);

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

				}
			}
	}


	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit() {

		switch (curStep) {

			case 1:
				{
					camHUD.alpha = 0;
				}
		}


	}

	override function beatHit() {
		everyoneDance();

		
		switch (curBeat) {

			case 1:
				{
					FlxTween.tween(blackscreen, {alpha: 0}, 2.5);

				}
			
			case 5: 
				{
					songDeets();
				}	
			case 12:
				FlxTween.tween(fgsky, {
					y: -3500
				}, 3.2, {
					ease: FlxEase.cubeIn
				});

			case 18:
				{
					//FlxTween.tween(blackscreen, {alpha: 1}, 1);

				}
				
			case 26:
				{
					blackscreen.alpha = 0;
					remove(fgsky);
					remove(otherblackscreen);
				}

			case 28:
				{
					FlxTween.tween(camHUD, {alpha: 1}, 1);
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

		songTitle = new FlxText(20, 200, FlxG.width - 100, 'Anemoia', 48);
		songTitle.setFormat(Paths.font("vcr.ttf"), 46, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		songTitle.scrollFactor.set();
		songTitle.alpha = 0;
		songTitle.borderColor = 0xFF3F0000;
		songTitle.borderSize = 3;
		songTitle.cameras = [camOther];

		musician = new FlxText(110, 300, FlxG.width - 100, 'Song: Stardust Tunes', 32);
		musician.setFormat(Paths.font("vcr.ttf"), 32, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		musician.scrollFactor.set();
		musician.alpha = 0;
		musician.borderColor = 0xFF3F0000;
		musician.borderSize = 3;		
		musician.cameras = [camOther];

		charter = new FlxText(110, 350, FlxG.width - 100, 'Charter: Sire Kirb', 32);
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
			
		}
	
		override function onFocus()
		{
		
		}
	

	override function closeSubState() {
		if(paused)
			{
			
			}
	}

	override function openSubState(SubState:flixel.FlxSubState) {
		if(paused)
			{
				
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
