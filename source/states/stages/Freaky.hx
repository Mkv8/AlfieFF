package states.stages;

import openfl.display.BlendMode;
import backend.BaseStage;
import states.stages.objects.*;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxEmitter;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

class Freaky extends BaseStage {
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var bg:BGSprite;
	var moon:BGSprite;

	var leaf: StarParticle = new StarParticle();
	var emitter: FlxEmitter = new FlxEmitter(0, 0);



	var blackUI:BGSprite;
	var blackscreen:BGSprite;

	

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

		/*bgback2 = new BGSprite('forest/bg3', 120, 110, 0.6, 1);
		bgback2.updateHitbox();
		bgback2.alpha = 1;
		add(bgback2);

		boombox = new BGSprite('forest/boomboxSprite', 750, 620, 1, 1, ['boomIdle']);
		boombox.updateHitbox();
		add(boombox);*/

		bg = new BGSprite('title bg', 1, 1, 1, 1);
		bg.updateHitbox();
		bg.alpha = 1;
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scale.set(0.67, 0.67);
		bg.screenCenter();
		add(bg);

		moon = new BGSprite('titlemoon', 545, -280, 1, 1);
		moon.updateHitbox();
		moon.alpha = 1;
		moon.antialiasing = ClientPrefs.data.antialiasing;
		moon.scale.set(0.60, 0.60);
		add(moon);
	}

	override function createPost() {
		// Use this function to layer things above characters!

		emitter.launchMode = FlxEmitterMode.SQUARE;
		emitter.velocity.set(50, 150, 100, 200);
		emitter.scale.set(0.5, 0.5, 1, 1, 0.5, 0.5, 0.75, 0.75);
		//emitter.drag.set(0, 0, 0, 0, 5, 5, 10, 10);
		emitter.width = 1280 + 300;
		emitter.x = (FlxG.width / 2) - (emitter.width / 2);
		emitter.alpha.set(1, 1, 1, 1);
		emitter.lifespan.set(10, 15);
		emitter.particleClass = StarParticle;
		//emitter.loadParticles(Paths.image('Particles/Particle' + i), 500, 16, true);
		for (j in 0...25) { // precache
			emitter.add(leaf);
		}
		emitter.y -= StarParticle.maxHeight;

		emitter.start(false, 0.6, 100000);
		add(emitter);

		blackUI = new BGSprite(null, 0, 0, 1, 1);
		blackUI.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackUI.camera = game.camHUD;
		blackUI.alpha = 1;
		add(blackUI);

		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.cameras = [camOther];
		blackscreen.alpha = 0;
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
		// Code here
	}

	override function beatHit() {
		everyoneDance();

		
		switch (curBeat) {

			case 4:
				{
					FlxTween.tween(blackUI, {alpha: 0}, 3, {ease: FlxEase.cubeIn});

				}
			
			}
	}

	function everyoneDance() {
		/*if (!ClientPrefs.data.lowQuality) {
			boombox.dance();
			aceton.dance();
			kailip.dance();
		}*/
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
