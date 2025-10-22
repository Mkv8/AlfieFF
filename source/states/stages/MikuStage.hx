package states.stages;

import openfl.display.BlendMode;
import backend.BaseStage;
import states.stages.objects.*;
import shaders.PostProcessing;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

// import.shaders.example_mods.shaders.PostProcessing;
class MikuStage extends BaseStage {
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	
	//main stuff
	var mikuS:BGSprite;
	var alfieS:BGSprite;
	var noises:BGSprite;


	//world is mine
	var wimbg1:BGSprite;
	var wimdance:BGSprite;

	//aishite

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
		wimbg1 = new BGSprite('miku/worldismine1', 0, 0, 1, 1);
		wimbg1.updateHitbox();
		wimbg1.antialiasing = ClientPrefs.data.antialiasing;
		wimbg1.alpha = 1;
		wimbg1.scale.set(1.5, 1.5);

		add(wimbg1);

		wimdance = new BGSprite('miku/wimDance', 50, 80, 1, 1, ['dance'], true);
		wimdance.updateHitbox();
		wimdance.alpha = 1;
		wimdance.antialiasing = ClientPrefs.data.antialiasing;
		wimdance.animation.play('dance', true, false);
		wimdance.scale.set(1.5, 1.5);
		add(wimdance);


		mikuS = new BGSprite('miku/mikuS', -50, 130, 1, 1, ['mikuS'], true);
		mikuS.updateHitbox();
		mikuS.alpha = 0;
		mikuS.antialiasing = ClientPrefs.data.antialiasing;
		mikuS.animation.play('mikuS', true, false);
		mikuS.scale.set(1.5, 1.5);
		add(mikuS);

		alfieS = new BGSprite('miku/alfieS', 1000, 175, 1, 1, ['alfieS'], true);
		alfieS.updateHitbox();
		alfieS.alpha = 0;
		alfieS.antialiasing = ClientPrefs.data.antialiasing;
		alfieS.animation.play('alfieS', true, false);
		alfieS.scale.set(1.5, 1.5);
		add(alfieS);


		
	}

	override function createPost() {
		// Use this function to layer things above characters!


		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.camera = game.camHUD;
		blackscreen.alpha = 0;
		add(blackscreen);

		noises = new BGSprite('miku/noises', -600, -600, 1, 1, ['noises'], true);
		noises.updateHitbox();
		noises.alpha = 0;
		noises.scale.set(2.5, 2.5);
		noises.antialiasing = ClientPrefs.data.antialiasing;
		noises.animation.play('noises', true, false);
		add(noises);
		
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
			{

			}
		}
	}

	override function beatHit() {
		everyoneDance();

		switch (curBeat) {
			case 198:
				{
					FlxTween.tween(noises, {alpha: 1}, 6 * Conductor.stepCrochet / 1000);

				}
			case 200:
				{
					noises.alpha = 0;
					FlxG.camera.flash(FlxColor.WHITE,1,false);
					wimdance.animation.curAnim.curFrame = 0;
					wimdance.animation.resume();
				}

		}
	}

	function everyoneDance() {
		if (!ClientPrefs.data.lowQuality) {
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
