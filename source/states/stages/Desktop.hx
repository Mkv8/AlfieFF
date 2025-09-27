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

class Desktop extends BaseStage {

	var bg:BGSprite;
	var crack:BGSprite;
	var introtext:BGSprite;
	var lasteye:BGSprite;


	var blackscreen:BGSprite;

	public var introVideo:VideoSprite;
	public var midVideo:VideoSprite;
	//public var introVideo:VideoSprite;

	var animtimer:FlxTimer;

	/*var shader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.PostProcessing()),
	];*/

	/*var curveShader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.CurveShader()),
	];*/

	//Shader isnt on in this song i think it would mess stuff up?????? if you think it should stay on let me know
	//var curveShader = new shaders.CurveShader();

// note: FOR SOME REASON I DISABLED THE SHADER BUT ITS STILL HAPPENING???? THE SCANLINES WONT GO AWAY :COPE:
// NOTE 2: sorry if some positions arent perfect i tried my hardest,,, atm teh last eye and crack assets are not positioned cuz idk how ur stuff is gonna look when its done...
//Note 3: please read all the comments i made......... thank u again....

	override function create() {


		bg = new BGSprite(null, 0, 0, 1, 1); //idk if this is even needed but i made a black bg anyways
		bg.makeGraphic(Std.int(FlxG.width), Std.int(FlxG.height), FlxColor.BLACK); //this means its 720x1280 right?
		bg.screenCenter(XY);
		bg.updateHitbox();
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.alpha = 1;
		add(bg);

		introtext = new BGSprite('eotbAssets/introText', -310, -220, 1, 1, ['textExport']); //intro text
		introtext.updateHitbox();
		introtext.scale.set(1.35,1.35);
		//introtext.screenCenter(XY);
		introtext.antialiasing = ClientPrefs.data.antialiasing;
		add(introtext);
		introtext.animation.pause();

		lasteye = new BGSprite('eotbAssets/lastEye', 0, 0, 1, 1, ['eye']); //This is for outro, gonna let u position this one cuz idk how ur gonna do it
		lasteye.updateHitbox();
		lasteye.antialiasing = ClientPrefs.data.antialiasing;
		lasteye.alpha = 0;
		add(lasteye);

		crack = new BGSprite('eotbAssets/lastPhaseCrack', -640, -360, 1, 1, ['LAST SHARDS']); 
		crack.updateHitbox();
		//crack.screenCenter(XY);
		crack.alpha = 0;
		crack.antialiasing = ClientPrefs.data.antialiasing;
		//This is for when he breaks the screen near the end, im gonna ask you to position this better cuz im not entirely sure how its gonna look when its all done...
		add(crack);

	}

	override function createPost() {
		// Use this function to layer things above characters


		introVideo = new VideoSprite();
		introVideo.playVideo(Paths.video("EOTBintro"),false,false,true);//cached but not gonna start to play
		introVideo.cameras = [camOther];
		introVideo.scale.set(1,1);
		//introVideo.screenCenter();
		introVideo.x = 0;
		introVideo.y= 0;   
		
		introVideo.antialiasing = ClientPrefs.data.antialiasing;
		add(introVideo);

		midVideo = new VideoSprite();
		midVideo.playVideo(Paths.video("EOTBmidCutscene"),false,false,true);//cached but not gonna start to play
		midVideo.cameras = [camHUD];
		midVideo.scale.set(1,1);
		//introVideo.screenCenter();
		midVideo.x = 0;
		midVideo.y= 0;   
		
		midVideo.antialiasing = ClientPrefs.data.antialiasing;
		add(midVideo);


		blackscreen = new BGSprite(null, 0, 0, 1, 1);
		blackscreen.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.cameras = [camOther];
		blackscreen.alpha = 1;
		add(blackscreen);

		/*FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

		PlayState.instance.camHUD.setFilters([new ShaderFilter(curveShader)]);
		PlayState.instance.camHUD.filtersEnabled = true;

		PlayState.instance.camGame.setFilters([new ShaderFilter(curveShader)]);
		PlayState.instance.camGame.filtersEnabled = true;

		curveShader.chromOff = 3.5;*/

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
				camHUD.alpha = 0;
				introVideo.bitmap.startPos = Std.int(Conductor.songPosition);
				introVideo.bitmap.playCached();
				introVideo.alpha = 1;
				dad.alpha = 0;
					for (i in 0...4)
					{
    				switch (i)
   					{
			        case 0:
						PlayState.playerStrums.members[i].x = 250;
        			case 1:
						PlayState.playerStrums.members[i].x = 400;
        			case 2:
						PlayState.playerStrums.members[i].x = 750;
					case 3:
						PlayState.playerStrums.members[i].x = 900;
    				}
					}
				FlxTween.tween(blackscreen, {alpha: 0}, 0.5);
				animtimer = new FlxTimer().start(16, function(tmr:FlxTimer)
						{
							introVideo.alpha = 0;
						});
			}
			}
	}


	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit() {

		switch (curStep) {

			case 136:
				{
					FlxTween.tween(introtext, {alpha: 1}, 0.5);
					introtext.animation.play('textExport', true, false);
					FlxTween.tween(dad, {alpha: 1}, 0.5);
					dad.playAnim('open', true, false, 0);
					dad.animation.pause();

					//NOTE: he keeps resetting his animation and going back to idle before its time, can you please fix this? i remember i did this once but i dont remember how...
					//He's supposed to be stuck in frame 0 or a while before he resumes it in beat 42...
				}
			
			case 952:
				{
					//THIS IS WHERE THE EYE OPENS IN THE MIDSONG VIDEO
				}
			case 960:
				{
					dad.alpha = 1;
					//THIS IS WHERE THE SCREEN BREAKS IN THE MIDSONG VIDEO
				}
			case 2224:
				{
					//THIS IS WHERE HE PLAYS THE ANIMATION FOR BREAKIN THE SCREEN NEAR THE END (its in the chart)
				}									
			case 2240:
				{
					crack.alpha = 1;
					crack.animation.play('LAST SHARDS', true, false); //on complete -> destroy it
					//THIS IS WHERE HE HITS THE SCREEN
				}					
			case 2256:
				{
					dad.alpha = 0;
					dad.scale.set(0.8, 0.8);
					//THIS IS WHERE HES OFFSCREEN N STUFF
				}	
			case 2336:
				{
					FlxTween.tween(dad, {alpha: 1}, 1);
					//THIS IS WHERE HE LAUGHS (its just a right note ngl)
				}	
			case 3392:
				{
					//THIS IS WHERE HE BUGS OUT AND THE SONG ENDS... HE CAN JUST DISAPPEAR IN SOME WEIRD WAY	
				}		
			case 3470:
				{
					//ENDING OF THE SONG: This is the end of the song, what happens here is that a window shows up with the lasteye sprite, the window comes from
					//the bottom of the screen and tweens to the middle, where the eye is just looking at you for a while, at around Step 3600, the window starts getting smaller as he disappears
					//the song ends after that.
				}									
		}


	}

	override function beatHit() {
		everyoneDance();

		
		switch (curBeat) {

			case 42:
				{
					dad.animation.resume();
				}
			case 48:
				{
					FlxTween.tween(introtext, {alpha: 0}, 1.5);
					FlxTween.tween(camHUD, {alpha: 1}, 1.5);

				}
			case 224:
				{
					FlxTween.tween(midVideo, {alpha: 1}, 1);
					midVideo.bitmap.startPos = Std.int(Conductor.songPosition);
					midVideo.bitmap.playCached();
					FlxTween.tween(dad, {alpha: 0}, 1.5);

				}
			
			}
	}

	function everyoneDance() {

	}

	override function sectionHit() {
		// Code here
	}

	// Substates for pausing/resuming tweens and timers


	override function onFocusLost()
		{
			// Code here
			if (introVideo != null)
				introVideo.bitmap.pause();
			
			if (midVideo != null)
				midVideo.bitmap.pause();			
		}
	
		override function onFocus()
		{
			if (introVideo != null && !paused)
				introVideo.bitmap.resume();

			if (midVideo != null && !paused)
				midVideo.bitmap.resume();
		}
	

	override function closeSubState() {
		if(paused)
			{
				if (introVideo != null && introVideo.alpha == 1)
					introVideo.bitmap.resume();

				if (midVideo != null && midVideo.alpha == 1)
					midVideo.bitmap.resume();				
			}
	}

	override function openSubState(SubState:flixel.FlxSubState) {
		if(paused)
			{
				if (introVideo != null)
					introVideo.bitmap.pause();

				if (midVideo != null)
					midVideo.bitmap.pause();				
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
