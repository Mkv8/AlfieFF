package states.stages;

import openfl.display.BlendMode;
import backend.BaseStage;
import states.stages.objects.*;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxEmitter;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

class Forest extends BaseStage {
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	var foregroundTrees:BGSprite;
	var bgfront:BGSprite;
	var bgback1:BGSprite;
	var bgback2:BGSprite;
	var aceton:BGSprite;
	var kailip:BGSprite;
	var boombox:BGSprite;
	var log:BGSprite;
	
	var leaf: LeafParticle = new LeafParticle();
	var emitter: FlxEmitter = new FlxEmitter(0, 0);

	var concept:BGSprite;

	var addLight:BGSprite;
	var multiplyDark:BGSprite;
	var overlay1:BGSprite;

	var whiteText:BGSprite;
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

		bgback2 = new BGSprite('forest/bg3', 120, 110, 0.6, 1);
		bgback2.updateHitbox();
		bgback2.alpha = 1;
		add(bgback2);

		bgback1 = new BGSprite('forest/bg2', 120, 110, 0.8, 1);
		bgback1.updateHitbox();
		bgback1.alpha = 1;
		add(bgback1);

		bgfront = new BGSprite('forest/bg1', 120, 110, 1, 1);
		bgfront.updateHitbox();
		bgfront.alpha = 1;
		add(bgfront);

		boombox = new BGSprite('forest/boomboxSprite', 750, 620, 1, 1, ['boomIdle']);
		boombox.updateHitbox();
		add(boombox);

		log = new BGSprite('forest/log', 700, 790, 1, 1);
		log.updateHitbox();
		log.alpha = 1;
		add(log);

		aceton = new BGSprite('forest/aceton', 1800, 480, 1, 1, ['Aceton']);
		aceton.updateHitbox();
		add(aceton);

		kailip = new BGSprite('forest/kailip', 220, 610, 1, 1, ['Kailip']);
		kailip.updateHitbox();
		add(kailip);
	}

	override function createPost() {
		// Use this function to layer things above characters!
		overlay1 = new BGSprite('forest/hardlight40', 0, 0, 1, 1);
		overlay1.updateHitbox();
		overlay1.alpha = 1;
		overlay1.blend = BlendMode.MULTIPLY;
		add(overlay1);

		multiplyDark = new BGSprite('forest/multiply34', 0, 0, 1, 1);
		multiplyDark.updateHitbox();
		multiplyDark.alpha = 0.44;
		multiplyDark.blend = BlendMode.MULTIPLY;
		add(multiplyDark);

		addLight = new BGSprite('forest/add60', 0, 0, 1, 1);
		addLight.updateHitbox();
		addLight.alpha = 0.45;
		addLight.blend = BlendMode.ADD;
		add(addLight);

		emitter.launchMode = FlxEmitterMode.SQUARE;
		emitter.velocity.set(50, 150, 100, 200);
		emitter.scale.set(0.5, 0.5, 1, 1, 0.5, 0.5, 0.75, 0.75);
		//emitter.drag.set(0, 0, 0, 0, 5, 5, 10, 10);
		emitter.width = 1280 + 300;
		emitter.x = (FlxG.width / 2) - (emitter.width / 2);
		emitter.alpha.set(1, 1, 1, 1);
		emitter.lifespan.set(10, 15);
		emitter.particleClass = LeafParticle;
		//emitter.loadParticles(Paths.image('Particles/Particle' + i), 500, 16, true);
		for (j in 0...25) { // precache
			emitter.add(leaf);
		}
		emitter.y -= LeafParticle.maxHeight;

		emitter.start(false, 0.6, 100000);
		add(emitter);

		foregroundTrees = new BGSprite('forest/foregroundTrees', 0, 0, 1, 1);
		foregroundTrees.updateHitbox();
		add(foregroundTrees);

		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.cameras = [camOther];
		blackscreen.alpha = 1;
		add(blackscreen);

		whiteText = new BGSprite('forest/whiteText', 0, 0, 1, 1, ['alfie', 'thanks'], true);
		whiteText.updateHitbox();
		whiteText.cameras = [camOther];
		whiteText.screenCenter();
		whiteText.alpha = 0.00001;
		
		add(whiteText);

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

			case 1:
				{
					whiteText.animation.play('alfie');
					FlxTween.tween(whiteText, {alpha: 1}, 1.5);
				}

			case 14:
				{
					whiteText.alpha = 0.00001;
				}

			case 16:
				{
					FlxG.camera.flash(FlxColor.WHITE,1,false);
					blackscreen.alpha = 0.00001;
					blackscreen.cameras = [camHUD];
					whiteText.cameras = [camHUD];
				}

			case 18:
				{
					songDeets();					
				}	

			case 179:
				{
					blackscreen.alpha = 1;
				}	
				
			case 180:
				{
					blackscreen.alpha = 0.00001;
					boyfriend.color = 0xFF000000;
					dad.color = 0xFF000000;
					gf.color = 0xFF000000;
					for(leaf in emitter.members) leaf.color = 0xFF000000;
					//foregroundTrees.alpha = 0.00001
					kailip.alpha = 0.00001;
					aceton.alpha = 0.00001;
					//log.alpha = 0.00001
					boombox.alpha = 0.00001;
					bgback1.color = 0xFFFF2E2E;
					bgback2.color = 0xFFFF2E2E;
					bgfront.color = 0xFFFF2E2E;
					log.color = 0xFFFF2E2E;


				}	

			case 222:
				{
					FlxTween.tween(blackscreen, {alpha: 1}, 0.5);
				}
				
			case 224:
				{
					FlxG.camera.flash(FlxColor.WHITE,1,false);
					blackscreen.alpha = 0.00001;
					boyfriend.color = 0xFFFFFFFF;
					dad.color = 0xFFFFFFFF;
					gf.color = 0xFFFFFFFF;
					for(leaf in emitter.members) leaf.color = 0xFFFFFFFF;
					//foregroundTrees.alpha = 1;
					kailip.alpha = 1;
					aceton.alpha = 1;
					//log.alpha = 1;
					boombox.alpha = 1;
					bgback1.color = 0xFFFFFFFF;
					bgback2.color = 0xFFFFFFFF;
					bgfront.color = 0xFFFFFFFF;
					log.color = 0xFFFFFFFF;

				}		

			case 416:
				{
					whiteText.alpha = 1;
					blackscreen.alpha = 1;
					whiteText.animation.play('thanks');
				}

			case 421:
				{
					FlxTween.tween(whiteText, {alpha: 0}, 1);
				}

			
			}
	}

	function everyoneDance() {
		if (!ClientPrefs.data.lowQuality) {
			boombox.dance();
			aceton.dance();
			kailip.dance();
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

		songTitle = new FlxText(20, 200, FlxG.width - 100, 'Forest Fire (New Mix)', 48);
		songTitle.setFormat(Paths.font("vcr.ttf"), 46, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		songTitle.scrollFactor.set();
		songTitle.alpha = 0;
		songTitle.borderColor = 0xFF3F0000;
		songTitle.borderSize = 3;
		songTitle.cameras = [camOther];

		musician = new FlxText(110, 300, FlxG.width - 100, 'Song: SplatterDash', 32);
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
