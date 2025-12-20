package states.stages;

import shaders.GameShaders;
import openfl.display.BlendMode;
import backend.BaseStage;
import states.stages.objects.*;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxEmitter;


class AiStage extends BaseStage {
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	var backisland:BGSprite;
	var bg:BGSprite;
	var block1:BGSprite;
	var block2:BGSprite;
	var board:BGSprite;
	var diamond1:BGSprite;
	var diamond2:BGSprite;
	var diamond3:BGSprite;
	var diamond4:BGSprite;
	var greenGrid:BGSprite;
	var pinkGrid:BGSprite;
	var heart:BGSprite;
	var mainIsland:BGSprite;
	var littleStage:BGSprite;
	var theseFuckingThings:BGSprite;

	var pringleplatform:BGSprite;

	var leaves:BGSprite;

	var concept:BGSprite;

	var multiplyDark:BGSprite;
	var shadow:BGSprite;
	var vignette:BGSprite;
	var blackscreen:BGSprite;


	override function create() {
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		// concept = new BGSprite('forest/concept', 0, 0, 1, 1);
		// concept.updateHitbox();
		// add(concept);
		bg = new BGSprite('aiStage/Bg', 0, 0, 1, 1);
		bg.scale.x = 2845;
		bg.updateHitbox();
		bg.alpha = 1;
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg);

		greenGrid = new BGSprite('aiStage/greenGrid', 0, 0, 1, 1);
		greenGrid.updateHitbox();
		greenGrid.alpha = 1;
		greenGrid.antialiasing = ClientPrefs.data.antialiasing;
		add(greenGrid);

		pinkGrid = new BGSprite('aiStage/pinkGrid', 0, 0, 1, 1);
		pinkGrid.updateHitbox();
		pinkGrid.alpha = 1;
		pinkGrid.antialiasing = ClientPrefs.data.antialiasing;
		add(pinkGrid);

		heart = new BGSprite('aiStage/heart', 1400, 0, 1, 1);
		heart.updateHitbox();
		heart.alpha = 1;
		heart.antialiasing = ClientPrefs.data.antialiasing;
		add(heart);

		theseFuckingThings = new BGSprite('aiStage/theseFuckinThingsBlur', 220, 135, 1, 1);
		theseFuckingThings.updateHitbox();
		theseFuckingThings.alpha = 1;
		theseFuckingThings.antialiasing = ClientPrefs.data.antialiasing;
		add(theseFuckingThings);

		diamond1 = new BGSprite('aiStage/diamond1', 710, 310, 1, 1);
		diamond1.updateHitbox();
		diamond1.alpha = 1;
		diamond1.antialiasing = ClientPrefs.data.antialiasing;
		add(diamond1);
		FlxTween.tween(diamond1, {y: diamond1.y - 16}, 1.5, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
		FlxTween.angle(diamond1, -3.5, 0, 3.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});

		diamond2 = new BGSprite('aiStage/diamond2', 990, 450, 1, 1);
		diamond2.updateHitbox();
		diamond2.alpha = 1;
		diamond2.antialiasing = ClientPrefs.data.antialiasing;
		add(diamond2);
		FlxTween.tween(diamond2, {y: diamond2.y + 14}, 1.5, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
		FlxTween.angle(diamond2, 3.5, 0, 3.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});

		diamond3 = new BGSprite('aiStage/diamond3', 1200, 320, 1, 1);
		diamond3.updateHitbox();
		diamond3.alpha = 1;
		diamond3.antialiasing = ClientPrefs.data.antialiasing;
		add(diamond3);
		FlxTween.tween(diamond3, {y: diamond3.y - 20}, 1.5, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
		FlxTween.angle(diamond3, -3.5, 0, 3.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});

		diamond4 = new BGSprite('aiStage/diamond4', 1670, 350, 1, 1);
		diamond4.updateHitbox();
		diamond4.alpha = 1;
		diamond4.antialiasing = ClientPrefs.data.antialiasing;
		add(diamond4);
		FlxTween.tween(diamond4, {y: diamond4.y + 20}, 1.5, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
		FlxTween.angle(diamond4, 3.5, 0, 3.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});

		backisland = new BGSprite('aiStage/backIsland', -120, 50, 1, 1);
		backisland.updateHitbox();
		backisland.alpha = 1;
		backisland.antialiasing = ClientPrefs.data.antialiasing;
		add(backisland);
		FlxTween.tween(backisland, {y: backisland.y - 40}, 3.5, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
		FlxTween.angle(backisland, -6.5, 0, 3.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});

		littleStage = new BGSprite('aiStage/notTheStageLol', 1200, 430, 1, 1);
		littleStage.updateHitbox();
		littleStage.alpha = 1;
		littleStage.antialiasing = ClientPrefs.data.antialiasing;
		add(littleStage);
		FlxTween.tween(littleStage, {y: littleStage.y + 15}, 3.5, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});

		block1 = new BGSprite('aiStage/block1', 2120, 570, 1, 1);
		block1.updateHitbox();
		block1.alpha = 1;
		block1.antialiasing = ClientPrefs.data.antialiasing;
		add(block1);
		FlxTween.tween(block1, {y: block1.y - 15}, 1.5, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
		FlxTween.angle(block1, 4.5, 0, 3.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});

		block2 = new BGSprite('aiStage/block2', 1100, 790, 1, 1);
		block2.updateHitbox();
		block2.alpha = 1;
		block2.antialiasing = ClientPrefs.data.antialiasing;
		add(block2);
		FlxTween.tween(block2, {y: block2.y + 20}, 1.5, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
		FlxTween.angle(block2, -4.5, 0, 3.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});

		leaves = new BGSprite('aiStage/leaves', 1526, 0, 1, 1, ['leaves'], true);
		leaves.updateHitbox();
		leaves.alpha = 1;
		leaves.antialiasing = ClientPrefs.data.antialiasing;
		leaves.animation.play('leaves', true, false);
		add(leaves);

		pringleplatform = new BGSprite('aiStage/pringlePlatform', 1300, 1080, 1, 1);
		pringleplatform.updateHitbox();
		pringleplatform.alpha = 1;
		pringleplatform.antialiasing = ClientPrefs.data.antialiasing;
		add(pringleplatform);

		mainIsland = new BGSprite('aiStage/mainIsland', 0, 55, 1, 1);
		mainIsland.updateHitbox();
		mainIsland.alpha = 1;
		mainIsland.antialiasing = ClientPrefs.data.antialiasing;
		add(mainIsland);

		board = new BGSprite('aiStage/board', 390, 530, 1, 1);
		board.updateHitbox();
		board.alpha = 1;
		board.antialiasing = ClientPrefs.data.antialiasing;
		add(board);

	}

	override function createPost() {
		// Use this function to layer things above characters!

		multiplyDark = new BGSprite('aiStage/multiply', 0, 0, 1, 1);
		multiplyDark.updateHitbox();
		multiplyDark.alpha = 1;
		multiplyDark.blend = BlendMode.MULTIPLY;
		add(multiplyDark);

		shadow = new BGSprite('aiStage/shadow', 0, 0, 1, 1);
		shadow.updateHitbox();
		shadow.alpha = 1;
		shadow.blend = BlendMode.MULTIPLY;
		add(shadow);

		vignette = new BGSprite('aiStage/vignette', 0, 0, 1, 1);
		vignette.updateHitbox();
		vignette.screenCenter();
		vignette.alpha = 0;
		vignette.cameras = [camOther];
		vignette.blend = BlendMode.MULTIPLY;
		add(vignette);

		concept = new BGSprite('aiStage/conceptFull', 0, 0, 1, 1);
		concept.updateHitbox();
		concept.alpha = 0.3;
		//add(concept);

		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.cameras = [camOther];
		blackscreen.alpha = 0;
		add(blackscreen);
		FlxG.game.filtersEnabled = ClientPrefs.data.shaders;
		GameShaders.CHROMATIC_ABBERATION.chromOff = 3.5;
	}

	override function update(elapsed:Float)
	{

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

			case 24:
				{
					songDeets();
				}

			case 112:
				{
					FlxTween.tween(pringleplatform, { y: 680}, 1.2, {ease: FlxEase.quartInOut});
					FlxTween.tween(gf, { y: 534}, 2.4, {ease: FlxEase.quartInOut});
				}

			case 249:
				{
					FlxTween.tween(vignette, {alpha: 1}, 1.5, {ease: FlxEase.quartIn});
				}
			case 312:
				{
					FlxTween.tween(vignette, {alpha: 0}, 1.5, {ease: FlxEase.quartInOut});
				}
			case 408:
				{
					FlxTween.tween(vignette, {alpha: 1}, 3, {ease: FlxEase.quartInOut});
				}
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

		songTitle = new FlxText(20, 200, FlxG.width - 100, 'Dreamcatcher', 48);
		songTitle.setFormat(Paths.font("vcr.ttf"), 46, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		songTitle.scrollFactor.set();
		songTitle.alpha = 0;
		songTitle.borderColor = 0xFF3F0000;
		songTitle.borderSize = 3;
		songTitle.cameras = [camOther];

		musician = new FlxText(110, 300, FlxG.width - 100, 'Song: Zeroh & Jospi', 32);
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
	function everyoneDance() {
		/*if (!ClientPrefs.data.lowQuality) {
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
