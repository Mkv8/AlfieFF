package states.stages;

import openfl.display.BlendMode;
import backend.BaseStage;
import states.stages.objects.*;
import shaders.PostProcessing;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

// import.shaders.example_mods.shaders.PostProcessing;
class Rooftop extends BaseStage {
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	var transition:BGSprite;
	var ground:BGSprite;
	var buildings:BGSprite;
	var moon:BGSprite;
	var sky:BGSprite;
	var plane:BGSprite;
	var clouds:BGSprite;

	var multiplynight:BGSprite;
	var addspotlight:BGSprite;

	var blackscreen:BGSprite;

	var blueGlow:BGSprite;
	var redGlow:BGSprite;

	var stoplights:Bool = false;

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

		sky = new BGSprite('rooftop/sky', 0, 0, 1, 1);
		sky.updateHitbox();
		sky.alpha = 1;
		add(sky);

		buildings = new BGSprite('rooftop/buildings', 0, 0, 1, 1);
		buildings.updateHitbox();
		buildings.alpha = 1;
		add(buildings);

		blueGlow = new BGSprite('rooftop/blueGlow', 0, 0, 1, 1);
		blueGlow.updateHitbox();
		blueGlow.alpha = 0.00001;
		blueGlow.blend = BlendMode.ADD;
		add(blueGlow);

		redGlow = new BGSprite('rooftop/redGlow', 0, 0, 1, 1);
		redGlow.updateHitbox();
		redGlow.alpha = 0.00001;
		redGlow.blend = BlendMode.ADD;
		add(redGlow);

		ground = new BGSprite('rooftop/ground', 0, 0, 1, 1);
		ground.updateHitbox();
		ground.alpha = 1;
		add(ground);

		moon = new BGSprite('rooftop/moon', 1380, 10, 1, 1);
		moon.updateHitbox();
		moon.alpha = 1;
		add(moon);

		plane = new BGSprite('rooftop/plane', -1200, 405, 1, 1);
		plane.updateHitbox();
		plane.scale.set(0.75, 0.9);
		plane.alpha = 1;
		add(plane);

		clouds = new BGSprite('rooftop/clouds', -2150, 150, 1, 1);
		clouds.updateHitbox();
		clouds.alpha = 0.75;
		add(clouds);
	}

	override function createPost() {
		// Use this function to layer things above characters!

		multiplynight = new BGSprite('rooftop/kisstonmultiply', 0, 0, 1, 1);
		multiplynight.updateHitbox();
		multiplynight.alpha = 1;
		multiplynight.blend = BlendMode.MULTIPLY;
		add(multiplynight);

		addspotlight = new BGSprite('rooftop/kisstonadd', 0, 0, 1, 1);
		addspotlight.updateHitbox();
		addspotlight.alpha = 1;
		addspotlight.blend = BlendMode.ADD;
		add(addspotlight);

		transition = new BGSprite('rooftop/transition', 0, -1511, 1, 1);
		transition.updateHitbox();
		transition.alpha = 1;
		add(transition);

		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.camera = game.camHUD;
		add(blackscreen);

		FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

		PlayState.instance.camHUD.setFilters([new ShaderFilter(curveShader)]);
		PlayState.instance.camHUD.filtersEnabled = true;

		PlayState.instance.camGame.setFilters([new ShaderFilter(curveShader)]);
		PlayState.instance.camGame.filtersEnabled = true;

		curveShader.chromOff = 4;
	}

	override function destroy() {
		super.destroy();
		FlxG.game.filtersEnabled = false;
	}

	override function update(elapsed:Float) {
		// Code here
	}

	/*override function countdownTick(count:BaseStage.Countdown, num:Int)
		{
			switch(count)
			{
				case THREE: //num 0
				case TWO: //num 1
				case ONE: //num 2
				case GO: //num 3
				case START: //num 4
			}
	}*/
	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit() {
		switch (curStep) {
			case 122:
				transition.alpha = 0.00001;
				blackscreen.alpha = 0.00001;
		}
	}

	override function beatHit() {
		everyoneDance();

		switch (curBeat) {
			case 1:
				{
					policeLights();
					stoplights = true;
					FlxTween.tween(blackscreen, {
						alpha: 0
					}, 1);
				}

			case 16:
				{
					FlxTween.tween(transition, {
						y: 600
					}, 3.4, {
						ease: FlxEase.cubeIn
					});
				}

			case 21 | 570:
				{
					FlxTween.tween(blackscreen, {
						alpha: 1
					}, 1, {
						ease: FlxEase.cubeIn
					});
				}

			case 120 | 408:
				{
					clouds.x = -2250;
					FlxTween.tween(clouds, {
						x: 2600
					}, 33);
				}

			case 204:
				{
					FlxTween.tween(plane, {
						x: 4000
					}, 22);
				}

			case 96 | 260 | 516:
				{
					//this starts the function
					stoplights = false;
					policeLights();
				}
				

			case 224 | 482:
				{
					//this stops the function
					stoplights = true;
				}

		}
	}

	function everyoneDance() {
		if (!ClientPrefs.data.lowQuality) {
		}
	}

	function policeLights() {
		var glowtimer2:FlxTimer;

		if (stoplights)
			{
			return;
			}
		
		blueGlow.alpha = 1;
		FlxTween.tween(blueGlow, {alpha: 0}, 0.9, {onComplete: function(twn:FlxTween) {
			glowtimer2 = new FlxTimer().start(0.4, function(tmr:FlxTimer)
				{
					redGlow.alpha = 1;
					FlxTween.tween(redGlow, {alpha: 0}, 0.9, {onComplete: function(twn:FlxTween) {policeLights();}});
				});
		}});
		

	}

	override function sectionHit() {
		// Code here
	}

	// Substates for pausing/resuming tweens and timers
	override function closeSubState() {
		if (paused) {
			// timer.active = true;
			// tween.active = true;
		}
	}

	override function openSubState(SubState:flixel.FlxSubState) {
		if (paused) {
			// timer.active = false;
			// tween.active = false;
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
