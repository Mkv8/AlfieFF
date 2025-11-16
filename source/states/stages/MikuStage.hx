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
	
	//chars
	var mikuS:BGSprite;
	var alfieS:BGSprite;
	var noises:BGSprite;
	var wimdance:BGSprite;

	var monitoringMikus:BGSprite;
	var monitoringAlfies:BGSprite;
	var monitoringWhites:BGSprite;

	//backgrounds in order
	var mikuTitle:BGSprite;
	var alfieTitle:BGSprite;
	var creds:BGSprite;
	var songTitle:BGSprite;
	
	var mainBG:BGSprite;
	var polkadots:BGSprite;
	var polkadots2:BGSprite;
	var bumpMainBG:BGSprite;

	var mikuBG1:BGSprite;
	var mikuBG2:BGSprite;

	var wimbg1:BGSprite;
	var wimbg2:BGSprite;

	var aishiteBG:BGSprite;

	var monitoringBG1:BGSprite;
	var monitoringBG2:BGSprite;
	var monitoringBG3:BGSprite;
	var monitoringBG4:BGSprite;
	var monitoringBG5:BGSprite;
	var monitoringBG6:BGSprite;
	var lens:BGSprite;

	var blackscreen:BGSprite;
	var whitescreen:BGSprite;

	var mikuTween:FlxTween;
	var alfieTween:FlxTween;

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

		//EVERYTHING IS IN ORDER OF APPEARANCE

		//BACKGROUNDS ------------------------------------------------------
		mikuTitle = new BGSprite('miku/mikuTitle', -300, -170, 1, 1); //DONE
		mikuTitle.updateHitbox();
		mikuTitle.antialiasing = ClientPrefs.data.antialiasing;
		mikuTitle.alpha = 1;
		add(mikuTitle);

		alfieTitle = new BGSprite('miku/alfieTitle', -300, -170, 1, 1); //DONE
		alfieTitle.updateHitbox();
		alfieTitle.antialiasing = ClientPrefs.data.antialiasing;
		alfieTitle.alpha = 0;
		add(alfieTitle);

		songTitle = new BGSprite('miku/songTitle', 800, 80, 1, 1, ['title'], true); //DONE
		songTitle.updateHitbox();
		songTitle.antialiasing = ClientPrefs.data.antialiasing;
		songTitle.alpha = 1;
		songTitle.animation.play('title', true, false);
		add(songTitle);

		creds = new BGSprite('miku/creds', 50, 80, 1, 1, ['creds'], true); //DONE
		creds.updateHitbox();
		creds.antialiasing = ClientPrefs.data.antialiasing;
		creds.alpha = 0;
		creds.animation.play('creds', true, false);
		add(creds);

		//---------

		mainBG = new BGSprite('miku/mainBG', -300, -170, 1, 1); //
		mainBG.updateHitbox();
		mainBG.antialiasing = ClientPrefs.data.antialiasing;
		mainBG.alpha = 0;
		add(mainBG);

		polkadots = new BGSprite('miku/polkadots', 720, 270, 1, 1); //
		polkadots.updateHitbox();
		polkadots.angle = -45;
		polkadots.antialiasing = ClientPrefs.data.antialiasing;
		polkadots.alpha = 0;
		add(polkadots);	
		polkadots2 = new BGSprite('miku/polkadots', -1500, 270, 1, 1); //
		polkadots2.updateHitbox();
		polkadots2.angle = 45;		
		polkadots2.antialiasing = ClientPrefs.data.antialiasing;
		polkadots2.alpha = 0;
		add(polkadots2);	

		bumpMainBG = new BGSprite('miku/bumpMainBG', 275, -95, 1, 1, ['bump'], false); //
		bumpMainBG.updateHitbox();
		bumpMainBG.antialiasing = ClientPrefs.data.antialiasing;
		bumpMainBG.alpha = 0;
		add(bumpMainBG);
		
		//------------

		
		mikuBG1 = new BGSprite('miku/mikuBG1', -300, -170, 1, 1); //
		mikuBG1.updateHitbox();
		mikuBG1.antialiasing = ClientPrefs.data.antialiasing;
		mikuBG1.alpha = 0;
		add(mikuBG1);		


		//-----------

		wimbg1 = new BGSprite('miku/worldismine1', 0, 0, 1, 1); //DONE
		wimbg1.updateHitbox();
		wimbg1.antialiasing = ClientPrefs.data.antialiasing;
		wimbg1.alpha = 0;
		wimbg1.scale.set(1.5, 1.5);
		add(wimbg1);
		wimbg2 = new BGSprite('miku/wimBG', -300, -170, 1, 1); //DONE
		wimbg2.updateHitbox();
		wimbg2.antialiasing = ClientPrefs.data.antialiasing;
		wimbg2.alpha = 0;
		add(wimbg2);

		//----------

		aishiteBG = new BGSprite('miku/aishiteBG', -300, -170, 1, 1); //
		aishiteBG.updateHitbox();
		aishiteBG.antialiasing = ClientPrefs.data.antialiasing;
		aishiteBG.alpha = 0;
		add(aishiteBG);		

		//---------

		monitoringBG1 = new BGSprite('miku/monitoring1', -300, -170, 1, 1); //
		monitoringBG1.updateHitbox();
		monitoringBG1.antialiasing = ClientPrefs.data.antialiasing;
		monitoringBG1.alpha = 0;
		//add(monitoringBG1);

		monitoringBG2 = new BGSprite('miku/monitoring2', -300, -170, 1, 1); //
		monitoringBG2.updateHitbox();
		monitoringBG2.antialiasing = ClientPrefs.data.antialiasing;
		monitoringBG2.alpha = 0;
		//add(monitoringBG2);

		monitoringBG3 = new BGSprite('miku/monitoring3', -300, -170, 1, 1); //
		monitoringBG3.updateHitbox();
		monitoringBG3.antialiasing = ClientPrefs.data.antialiasing;
		monitoringBG3.alpha = 0;
		//add(monitoringBG3);

		monitoringBG4 = new BGSprite('miku/monitoring4', -300, -170, 1, 1); //
		monitoringBG4.updateHitbox();
		monitoringBG4.antialiasing = ClientPrefs.data.antialiasing;
		monitoringBG4.alpha = 0;
		//add(monitoringBG4);

		monitoringBG5 = new BGSprite('miku/monitoring5', -300, -170, 1, 1); //
		monitoringBG5.updateHitbox();
		monitoringBG5.antialiasing = ClientPrefs.data.antialiasing;
		monitoringBG5.alpha = 0;
		//add(monitoringBG5);

		monitoringBG6 = new BGSprite('miku/monitoringDoor', -190, -170, 1, 1); //
		monitoringBG6.updateHitbox();
		monitoringBG6.antialiasing = ClientPrefs.data.antialiasing;
		monitoringBG6.alpha = 0;
		add(monitoringBG6);

		//CHARACTER STUFF --------------------------------------------------
		mikuS = new BGSprite('miku/mikuS', -50, 150, 1, 1, ['mikuS'], true); //DONE
		mikuS.updateHitbox();
		mikuS.alpha = 1;
		mikuS.antialiasing = ClientPrefs.data.antialiasing;
		mikuS.animation.play('mikuS', true, false);
		mikuS.scale.set(1.5, 1.5);
		add(mikuS);

		alfieS = new BGSprite('miku/alfieS', 1000, 195, 1, 1, ['alfieS'], true); //DONE
		alfieS.updateHitbox();
		alfieS.alpha = 0;
		alfieS.antialiasing = ClientPrefs.data.antialiasing;
		alfieS.animation.play('alfieS', true, false);
		alfieS.scale.set(1.5, 1.5);
		add(alfieS);

		wimdance = new BGSprite('miku/wimDance', 50, 80, 1, 1, ['dance'], true); //DONE
		wimdance.updateHitbox();
		wimdance.alpha = 0;
		wimdance.antialiasing = ClientPrefs.data.antialiasing;
		wimdance.animation.play('dance', true, false);
		wimdance.scale.set(1.5, 1.5);
		add(wimdance);

		monitoringWhites = new BGSprite('miku/monitoringWhites', 280, 150, 1, 1, ['whites'], false); //DONE
		monitoringWhites.updateHitbox();
		monitoringWhites.alpha = 0;
		monitoringWhites.antialiasing = ClientPrefs.data.antialiasing;
		monitoringWhites.animation.play('whites', true, false);
		monitoringWhites.animation.pause();
		//add(monitoringWhites);		

		monitoringMikus = new BGSprite('miku/monitoringMikus', -115, -160, 1, 1, ['Mikus'], false); //DONE
		monitoringMikus.updateHitbox();
		monitoringMikus.alpha = 0;
		monitoringMikus.antialiasing = ClientPrefs.data.antialiasing;
		monitoringMikus.animation.play('Mikus', true, false);
		monitoringMikus.animation.pause();
		add(monitoringMikus);	
		
		monitoringAlfies = new BGSprite('miku/monitoringAlfies', -80, -160, 1, 1, ['Alfies'], false); //DONE
		monitoringAlfies.updateHitbox();
		monitoringAlfies.alpha = 0;
		monitoringAlfies.antialiasing = ClientPrefs.data.antialiasing;
		monitoringAlfies.animation.play('Alfies', true, false);
		monitoringAlfies.animation.pause();
		add(monitoringAlfies);				
		
	}

	override function createPost() {
		// Use this function to layer things above characters!
		mikuBG2 = new BGSprite('miku/mikuBG2', -320, -70, 1, 1); //
		mikuBG2.updateHitbox();
		mikuBG2.antialiasing = ClientPrefs.data.antialiasing;
		mikuBG2.scale.set(1.3, 1.3);
		mikuBG2.alpha = 0;
		add(mikuBG2);	

		lens = new BGSprite('miku/lens', -300, -130, 1, 1); //
		lens.updateHitbox();
		lens.antialiasing = ClientPrefs.data.antialiasing;
		lens.scale.set(1.8, 1.8);
		lens.alpha = 0;
		add(lens);		

		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.camera = game.camHUD;
		blackscreen.alpha = 0;
		add(blackscreen);

		whitescreen = new BGSprite(null, 0, 0, 1, 1);
		whitescreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.WHITE);
		whitescreen.camera = game.camHUD;
		whitescreen.alpha = 0;
		add(whitescreen);

		noises = new BGSprite('miku/noises', -600, -600, 1, 1, ['noises'], true);
		noises.updateHitbox();
		noises.alpha = 0;
		noises.scale.set(2.5, 2.5);
		noises.camera = game.camHUD;
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
			case 55:
			{
					mikuTitle.alpha = 1;
					alfieTitle.alpha = 0;
					songTitle.alpha = 1;
					creds.alpha = 0;		
					mikuS.alpha = 1;
					alfieS.alpha = 0;		
			}
			case 58:
			{
					mikuTitle.alpha = 0;
					alfieTitle.alpha = 1;
					songTitle.alpha = 0;
					creds.alpha = 1;		
					mikuS.alpha = 0;
					alfieS.alpha = 1;						
			}
			case 61: 
			{
				blackscreen.alpha = 1;
			}	
			case 64: 
			{
				blackscreen.alpha = 0;
				FlxG.camera.flash(FlxColor.WHITE,1.5,false);
				alfieS.alpha = 0;
				mainBG.alpha = 1;
				polkadots.alpha = 1;
				polkadots2.alpha = 1;
				bumpMainBG.alpha = 1;
				for (i in 0...4)
				{
            	PlayState.playerStrums.members[i].x += 2000;
				}
					for (i in 0...4)
				{
            	PlayState.opponentStrums.members[i].x += 2000;
				}
			}	
			case 70:
			{
				mikuTitle.destroy();
				alfieS.destroy();
				mikuS.destroy();
				alfieTitle.destroy();
				creds.destroy();
				songTitle.destroy();
			}
			case 320:
			{
					for (i in 0...4)
					{
    				switch (i)
   					{
			        case 0:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 250}, 8 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 1:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 400}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 750}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 900}, 14 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}
					for (i in 0...4)
					{
    				switch (i)
   					{
			        case 0:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x - 600}, 6 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 1:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x - 600}, 8 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x - 600}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x - 600}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}					
			}
			case 442: 
			{
				blackscreen.alpha = 1;
				mainBG.alpha = 0;
				polkadots.alpha = 0;
				polkadots2.alpha = 0;
				bumpMainBG.alpha = 0;				
				FlxTween.tween(noises, {alpha: 1}, 4 * Conductor.stepCrochet / 1000);
			}
			case 448: 
			{
				blackscreen.alpha = 0;
				noises.alpha = 0;
				FlxG.camera.flash(FlxColor.WHITE,1,false);				
				mikuBG1.alpha = 1;
				mikuBG2.alpha = 1;
			}
			case 576: 
			{
				FlxG.camera.flash(FlxColor.WHITE,1,false);	
				mikuTween = FlxTween.tween(dad, {y: dad.y - 80}, 2, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});			
				alfieTween  = FlxTween.tween(boyfriend, {y: boyfriend.y - 80}, 2, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut, startDelay: 0.5});	
				mikuBG2.alpha = 0;
			}			
			case 696: 
			{
				FlxTween.tween(noises, {alpha: 1}, 6 * Conductor.stepCrochet / 1000);
			}				
			case 704: 
			{
				mikuTween.cancel();
				alfieTween.cancel();
				noises.alpha = 0;
				FlxG.camera.flash(FlxColor.WHITE,1,false);	
				mikuBG1.alpha = 0;
				mainBG.alpha = 1;
				polkadots.alpha = 1;
				polkadots2.alpha = 1;
				bumpMainBG.alpha = 1;	
					for (i in 0...4)
					{
					switch (i)
   					{
			        case 0:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 732}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut}); //RIGHT SIDE
        			case 1:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 844}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 956}, 14 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 1068}, 16 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}
					for (i in 0...4)
					{
    				switch (i)
   					{
			        case 0:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x + 650}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 1:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x + 650}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x + 650}, 14 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x + 650}, 16 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}						
			}
			case 768:
			{
					for (i in 0...4)
					{
    				switch (i)
   					{
			        case 0:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x - 600}, 8 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 1:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x - 600}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x - 600}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x - 600}, 14 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}					
			}
			case 784:
			{
					for (i in 0...4)
					{
    				switch (i)
   					{
			        case 0:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 250}, 6 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 1:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 400}, 8 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 750}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 900}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}				
			}
			case 896: 
			{
				blackscreen.alpha = 1;

					for (i in 0...4)
					{
					switch (i)
   					{
			        case 0:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 82}, 8 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut}); //LEFT SIDE
        			case 1:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 194}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 306}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 418}, 14 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}
					for (i in 0...4)
					{
    				switch (i)
   					{
			        case 0:
						PlayState.opponentStrums.members[i].x += 2000;
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: 732}, 8 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 1:
						PlayState.opponentStrums.members[i].x += 2000;
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: 844}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						PlayState.opponentStrums.members[i].x += 2000;
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: 956}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						PlayState.opponentStrums.members[i].x += 2000;
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: 1068}, 14 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}						
			}	
			case 920: 
			{
				FlxTween.tween(noises, {alpha: 1}, 6 * Conductor.stepCrochet / 1000);
			}			
			case 928:
			{
				boyfriend.alpha = 1;
				dad.alpha = 1;
				noises.alpha = 0;
				blackscreen.alpha = 0;
				FlxG.camera.flash(FlxColor.WHITE,1,false);				
				wimbg2.alpha = 1;
				wimbg1.alpha = 0;
				wimdance.alpha = 0;
			}
			case 1168:
			{
				wimbg2.alpha = 0;
			}	
			case 1174:
			{
				boyfriend.alpha = 0;
				dad.alpha = 0;
			}			
			case 1180:
			{
				noises.alpha = 1;
			}			
			case 1184:
			{
				FlxTween.tween(noises, {alpha: 0}, 12 * Conductor.stepCrochet / 1000);
				aishiteBG.alpha = 1;
					for (i in 0...4)
					{
    				switch (i)
   					{
			        case 0:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 250}, 8 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 1:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 400}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 750}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 900}, 14 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}
					for (i in 0...4)
					{
    				switch (i)
   					{
			        case 0:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x + 600}, 8 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 1:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x + 600}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x + 600}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: PlayState.opponentStrums.members[i].x + 600}, 14 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}
			}	
			case 1193: 
			{
				FlxTween.tween(boyfriend, {alpha: 1}, 8 * Conductor.stepCrochet / 1000);
			}	
			case 1303: 
			{
				FlxTween.tween(dad, {alpha: 1}, 8 * Conductor.stepCrochet / 1000);
			}										
			case 1512: 
			{
				FlxTween.tween(whitescreen, {alpha: 1}, 16 * Conductor.stepCrochet / 1000);			
			}	
			case 1530:
			{
				add(monitoringBG1);
				add(monitoringBG2);
				add(monitoringBG3);
				add(monitoringBG4);
				add(monitoringBG5);
				add(monitoringWhites);
			}
			case 1535:
			{
				FlxTween.tween(noises, {alpha: 1}, 6 * Conductor.stepCrochet / 1000);
				aishiteBG.alpha = 0;
			}			
			case 1542:
			{
				noises.alpha = 0;
				whitescreen.alpha = 0;
				monitoringBG1.alpha = 1;
				boyfriend.alpha = 0;
				dad.alpha = 0;
				monitoringWhites.alpha = 1;
				monitoringWhites.animation.curAnim.curFrame = 0;
				FlxG.camera.flash(FlxColor.WHITE,1,false);	
				FlxTween.tween(monitoringWhites, {x: monitoringWhites.x - 50}, 25 * Conductor.stepCrochet / 1000);
			}			
			case 1568:
			{
				monitoringBG1.alpha = 0;
				monitoringBG2.alpha = 1;
				monitoringWhites.animation.curAnim.curFrame = 1;
				monitoringWhites.x += 50;
				FlxTween.tween(monitoringWhites, {x: monitoringWhites.x - 50}, 16 * Conductor.stepCrochet / 1000);

			}		
			case 1585:
			{
				monitoringBG2.alpha = 0;
				monitoringBG3.alpha = 1;
				monitoringWhites.animation.curAnim.curFrame = 2;
				monitoringWhites.x += 50;
			}		
			case 1602:
			{
				monitoringBG3.alpha = 0;
				monitoringBG4.alpha = 1;
				monitoringWhites.animation.curAnim.curFrame = 3;
				FlxTween.tween(monitoringWhites, {x: monitoringWhites.x - 50}, 13 * Conductor.stepCrochet / 1000);				
			}			
			case 1616:
			{
				monitoringBG4.alpha = 0;
				monitoringBG5.alpha = 1;
				monitoringWhites.animation.curAnim.curFrame = 4;
				monitoringWhites.x += 50;
				FlxTween.tween(monitoringWhites, {x: monitoringWhites.x - 50}, 14 * Conductor.stepCrochet / 1000);				
			}	
			case 1624: 
			{
				FlxTween.tween(blackscreen, {alpha: 1}, 6 * Conductor.stepCrochet / 1000);			
			}
			//region THE MONITORING SECTION BLOCK OF CODE
			case 1631: 
			{
				monitoringBG1.destroy();
				monitoringBG2.destroy();
				monitoringBG3.destroy();
				monitoringBG4.destroy();
				monitoringBG5.destroy();
				monitoringWhites.destroy();
				blackscreen.alpha = 0;
				lens.alpha = 1;
				monitoringBG6.alpha = 1;
				monitoringMikus.alpha = 1;
				monitoringMikus.animation.curAnim.curFrame = 6;
			}	
			case 1633:
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 5;
			}			
			case 1635:
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 7;
			}	
			case 1636:
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 7;
			}
			case 1637: 
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 3;
			}
			case 1639: 
			{
				FlxTween.tween(whitescreen, {alpha: 1}, 4 * Conductor.stepCrochet / 1000);			
			}
			case 1644: 
			{
				whitescreen.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 0;
			}
			case 1650: //alfie posin
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 2;				
			}
			case 1653: //miku posin
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 4;				
			}
			case 1655: //both posin
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 1;
				monitoringMikus.animation.curAnim.curFrame = 1;			
				monitoringAlfies.animation.curAnim.curFrame = 1;						
			}
			case 1661: 
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 2;							
			}
			case 1670: //alfie posin
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 4;				
			}		
			case 1673: //miku posin
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 5;				
			}	
			case 1676: //alfie posin
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 3;				
			}	
			case 1687 | 1733 | 1835: //miku posin //1
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 6;				
			}			
			case 1688 | 1735 | 1837: //alfie posin //1
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 5;				
			}
			case 1689 | 1736 | 1838: //miku posin //2
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 7;				
			}			
			case 1691 | 1738: //alfie posin //2
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 7;				
			}
			case 1693: //miku posin
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 5;				
			}	
			case 1697 | 1739 | 1841: //miku posin
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 3;				
			}		
			case 1704: //alfie posin
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 4;				
			}	
			case 1710: //alfie posin
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 6;				
			}	
			case 1717: // both gone
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 0;
			}	
			case 1741: //alfie posin
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 2;				
			}
			case 1746: //miku posin
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 0;				
			}	
			case 1753: //alfie posin
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 1;				
			}	
			case 1762: //miku posin
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 1;				
			}					
			case 1772: //alfie posin
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 0;					
			}
			case 1792: 
			{
				monitoringAlfies.alpha = 1;
				monitoringMikus.alpha = 1;
				monitoringMikus.animation.curAnim.curFrame = 1;			
				monitoringAlfies.animation.curAnim.curFrame = 1;	
			}
			case 1794: 
			{
				monitoringMikus.animation.curAnim.curFrame = 6;			
				monitoringAlfies.animation.curAnim.curFrame = 5;	
			}	
			case 1797: 
			{
				monitoringMikus.animation.curAnim.curFrame = 4;			
				monitoringAlfies.animation.curAnim.curFrame = 4;				
			}	
			case 1800: 
			{
				monitoringMikus.animation.curAnim.curFrame = 7;			
				monitoringAlfies.animation.curAnim.curFrame = 7;				
			}
			case 1804: //alfie posin
			{
				monitoringMikus.alpha = 0;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 6;					
			}	
			case 1810: //miku posin
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 0;
				monitoringMikus.animation.curAnim.curFrame = 0;				
			}
			case 1822: //miku posin
			{
				monitoringMikus.alpha = 1;
				monitoringAlfies.alpha = 1;
				monitoringAlfies.animation.curAnim.curFrame = 1;					
				monitoringMikus.animation.curAnim.curFrame = 1;				
			}			
			case 1843: 
			{
				FlxTween.tween(noises, {alpha: 1}, 4 * Conductor.stepCrochet / 1000);
			}
			//endregion

			case 1848:
			{
				noises.alpha = 0;
				boyfriend.alpha = 1;
				dad.alpha = 1;
				FlxG.camera.flash(FlxColor.WHITE,1,false);	
				monitoringAlfies.destroy();
				monitoringMikus.destroy();
				monitoringBG6.destroy();
				lens.destroy();
				mainBG.alpha = 1;
				polkadots.alpha = 1;
				polkadots2.alpha = 1;
				bumpMainBG.alpha = 1;				
					for (i in 0...4)
					{
					switch (i)
   					{
			        case 0:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 732}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut}); //RIGHT SIDE
        			case 1:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 844}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 956}, 14 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						FlxTween.tween(PlayState.playerStrums.members[i], {x: 1068}, 16 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}	
					for (i in 0...4)
					{
					switch (i)
   					{
			        case 0:
						PlayState.opponentStrums.members[i].x -= 3500;
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: 82}, 8 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut}); //LEFT SIDE
        			case 1:
						PlayState.opponentStrums.members[i].x -= 3500;
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: 194}, 10 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
        			case 2:
						PlayState.opponentStrums.members[i].x -= 3500;
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: 306}, 12 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
					case 3:
						PlayState.opponentStrums.members[i].x -= 3500;
						FlxTween.tween(PlayState.opponentStrums.members[i], {x: 418}, 14 * Conductor.stepCrochet / 1000, {ease: FlxEase.cubeOut});
    				}
					}

			}
		}
	}

	override function beatHit() {
		everyoneDance();

		switch (curBeat) {
			case 8: 
				{
					mikuTitle.alpha = 0;
					alfieTitle.alpha = 1;
					songTitle.alpha = 0;
					creds.alpha = 1;
					mikuS.alpha = 0;
					alfieS.alpha = 1;
				}
			case 198:
				{
					FlxTween.tween(noises, {alpha: 1}, 6 * Conductor.stepCrochet / 1000);

				}
			case 200:
				{
					noises.alpha = 0;
					FlxG.camera.flash(FlxColor.WHITE,1,false);
					wimbg1.alpha = 1;
					wimdance.alpha = 1;
					wimdance.animation.curAnim.curFrame = 0;
					wimdance.animation.resume();
					mainBG.alpha = 0;
					polkadots.alpha = 0;
					polkadots2.alpha = 0;
					bumpMainBG.alpha = 0;	
					boyfriend.alpha = 0;
					dad.alpha = 0;
				}

		}
	}

	function everyoneDance() {
		if (!ClientPrefs.data.lowQuality) {
		if (curBeat % 2 == 1) {bumpMainBG.animation.play('bump', true, false);}
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
