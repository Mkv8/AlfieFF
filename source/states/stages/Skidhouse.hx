package states.stages;

import objects.Character;
import backend.BaseStage;

import shaders.GameShaders;
import hxcodec.VideoSprite;
import openfl.display.BlendMode;
import backend.BaseStage;
import states.stages.objects.*;
import flixel.effects.particles.FlxEmitter;


class Skidhouse extends BaseStage {
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	var couch:BGSprite;
	var bg:BGSprite;
	var n64:BGSprite;
	var pump:BGSprite;

	var concept:BGSprite;

	var multiply:BGSprite;

	var blackscreen:BGSprite;

	public var videoSprite:VideoSprite;

	var animtimer:FlxTimer;


	override function create() {
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		// concept = new BGSprite('forest/concept', 0, 0, 1, 1);
		// concept.updateHitbox();
		// add(concept);

		bg = new BGSprite('skidHouse/JCbg', 0, 0, 1, 1);
		bg.updateHitbox();
		bg.antialiasing = ClientPrefs.data.antialiasing;

		bg.alpha = 1;
		add(bg);


		pump = new BGSprite('skidHouse/pump', 0, 390, 1, 1, ['pumpIdle']);
		pump.updateHitbox();
		pump.antialiasing = ClientPrefs.data.antialiasing;

		add(pump);
	}

	override function createPost() {
		// Use this function to layer things above characters

		n64 = new BGSprite('skidHouse/n64', 1760, 780, 1, 1);
		n64.updateHitbox();
		n64.antialiasing = ClientPrefs.data.antialiasing;
		add(n64);


		couch = new BGSprite('skidHouse/couch', -55, 690, 1, 1);
		couch.updateHitbox();
		couch.antialiasing = ClientPrefs.data.antialiasing;
		add(couch);


		videoSprite = new VideoSprite();
		videoSprite.playVideo(Paths.video("kaiintro"),false,false,true);//cached but not gonna start to play
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
		blackscreen.alpha = 1;
		add(blackscreen);


		multiply = new BGSprite('skidHouse/KaiMult', 0, 0, 1, 1);
		multiply.updateHitbox();
		//multiply.alpha = 0.44;
		multiply.blend = BlendMode.MULTIPLY;
		add(multiply);

		concept = new BGSprite('skidHouse/concept', 0, 0, 1, 1);
		concept.updateHitbox();
		concept.alpha = 0.3;
		concept.antialiasing = ClientPrefs.data.antialiasing;
		//add(concept);
	}

	override function update(elapsed:Float)
	{
		FlxG.game.filtersEnabled = ClientPrefs.data.shaders;
		GameShaders.CHROMATIC_ABBERATION.chromOff = 3.5;
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
				FlxTween.tween(blackscreen, {alpha: 0}, 0.8);
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
					boyfriend.playAnim('turnOff', true);
					boyfriend.dontInterrupt = true;
					//if this is supposed to happen mid song u have to add a timer that disables the dont interrupt and plays whatever animation hes supposed to play
					animtimer = new FlxTimer().start(5, function(tmr:FlxTimer)
						{
							boyfriend.dontInterrupt = false;
							//boyfriend.playAnim('danceLeft', true);
							boyfriend.animation.pause();
						});
					//like this ^^^^
				}
		}


	}

	override function beatHit() {
		everyoneDance();


		switch (curBeat) {

			case 30:
				{
					FlxTween.tween(blackscreen, {alpha: 1}, 0.5);

				}

			case 36:
				{
					FlxTween.tween(blackscreen, {alpha: 0}, 3.5);

				}
			case 40:
				{
					songDeets();
				}
			case 561:
				{
					FlxTween.tween(blackscreen, {alpha: 1}, 1);

				}


			}
	}

	function everyoneDance() {
		if (!ClientPrefs.data.lowQuality) {
			pump.dance();
		}
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

		songTitle = new FlxText(20, 200, FlxG.width - 100, 'Jammed Cartridge', 48);
		songTitle.setFormat(Paths.font("vcr.ttf"), 46, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		songTitle.scrollFactor.set();
		songTitle.alpha = 0;
		songTitle.borderColor = 0xFF3F0000;
		songTitle.borderSize = 3;
		songTitle.cameras = [camOther];

		musician = new FlxText(110, 300, FlxG.width - 100, 'Song: Meroth & Pixelated Engie', 32);
		musician.setFormat(Paths.font("vcr.ttf"), 32, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		musician.scrollFactor.set();
		musician.alpha = 0;
		musician.borderColor = 0xFF3F0000;
		musician.borderSize = 3;
		musician.cameras = [camOther];

		charter = new FlxText(110, 350, FlxG.width - 100, 'Charter: sire_kirbz', 32);
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
