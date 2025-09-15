package states.stages;

import openfl.display.BlendMode;
import backend.BaseStage;
import states.stages.objects.*;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxEmitter;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

class FilipGarage extends BaseStage {
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	var filipBG:BGSprite;
	var couch:BGSprite;
	var boombox:BGSprite;
	var gfBob:BGSprite;
	var alfieBob:BGSprite;

	var concept:BGSprite;

	var multiplyDark:BGSprite;

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
		// concept = new BGSprite('forest/concept', 0, 0, 1, 1);
		// concept.updateHitbox();
		// add(concept);

		filipBG = new BGSprite('filipGarage/filipBG', 0, 0, 1, 1);
		filipBG.updateHitbox();
		filipBG.alpha = 1;
		filipBG.antialiasing = ClientPrefs.data.antialiasing;
		add(filipBG);

		couch = new BGSprite('filipGarage/couch', 115, 480, 1, 1);
		couch.updateHitbox();
		couch.alpha = 1;
		couch.antialiasing = ClientPrefs.data.antialiasing;
		add(couch);

		boombox = new BGSprite('filipGarage/filipBoombox', 1200, 540, 1, 1, ['bounce']);
		boombox.updateHitbox();
		boombox.antialiasing = ClientPrefs.data.antialiasing;
		add(boombox);

		gfBob = new BGSprite('filipGarage/gfBob', 510, 470, 1, 1, ['danceLeft', 'danceRight']);
		gfBob.updateHitbox();
		gfBob.antialiasing = ClientPrefs.data.antialiasing;
		add(gfBob);

		alfieBob = new BGSprite('filipGarage/alfieBob', 160, 440, 1, 1, ['evenidle', 'oddidle']);
		alfieBob.updateHitbox();
		alfieBob.antialiasing = ClientPrefs.data.antialiasing;
		add(alfieBob);
	}

	override function createPost() {
		// Use this function to layer things above characters!

		multiplyDark = new BGSprite('filipGarage/multiplyFilip', 0, 0, 1, 1);
		multiplyDark.updateHitbox();
		multiplyDark.alpha = 1;
		multiplyDark.blend = BlendMode.MULTIPLY;
		add(multiplyDark);

		concept = new BGSprite('filipGarage/filipConcept', 0, 0, 1, 1);
		concept.updateHitbox();
		concept.alpha = 0.2;
		//add(concept);

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

			case 326:
				{
					dad.alpha = 1;
					alfieBob.alpha = 0;
					//whiteText.animation.play('alfie');
					//FlxTween.tween(whiteText, {alpha: 1}, 1.5);
				}

			
			}
	}

	function everyoneDance() {
		


		if (!ClientPrefs.data.lowQuality) {
			if (curBeat % 2 == 1) { gfBob.animation.play('danceLeft', true, false); } //else { gfBob.animation.play('danceRight', true, false); }
			if (curBeat % 2 == 0) { alfieBob.animation.play('evenidle', true, false); } else { alfieBob.animation.play('oddidle', true, false); }
			if (curBeat % 2 == 1) {boombox.dance();}
		}
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
