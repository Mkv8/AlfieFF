package states;

import shaders.GameShaders;
import flixel.effects.particles.FlxEmitter;
import flixel.FlxObject;
import openfl.display.BlendMode;


class ArtworkSubstate extends MusicBeatSubstate {

	var characters:Map<String, Dynamic> = new Map<String, Dynamic>();
	var charList = ['mikuStage', 'aiAlfieDesign', 'firstPromo', 'secondPromo', 'hooman', 'artificial', 'artificial2', 'oldAlbums', 'forestFire', 'deadbf', 'minusPoses', 'minusPoses2', 'fuckinArrested', 'wellthissucks', 'alfandquaver']; //Use this as the order to show them bc maps dont have an order to them

	var menuItems: FlxSpriteGroup = new FlxSpriteGroup();
	var camFollow: FlxObject;

	var multiplyBar:BGSprite; //im using bgsprite cuz i think its just like the same thing as flxsprite but easier to use right lmao
	var concepts:FlxSprite; //this is for the concepts


	var leftSelect:BGSprite;
	var rightSelect:BGSprite;

	var texts:Array<FlxSprite> = [];
	var nameTexts:FlxText;
	var bioText:FlxText;
	private static var curSelected2:Int = 0;

	var infoText:FlxText;
	var readingComments:Bool = false;

	//THANK YOU FERZY FOR THE JSON HELP !!!!!! EVERYONE SAY THANK YOU FERZY !!!!

	override function create()
	{
		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Lookin' at some art!", null);
		#end

		persistentUpdate = persistentDraw = true;

		super.create();

		var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image("menuassets/mainExtraBg"));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0, 0);
		//bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.scale.set(0.8, 0.8);
		add(bg);

		var emitter:FlxEmitter = new FlxEmitter(-700, -300);
		emitter.launchMode = FlxEmitterMode.SQUARE;
		emitter.velocity.set(50, 150, 100, 200);
		emitter.scale.set(0.5, 0.5, 1, 1, 0.5, 0.5, 0.75, 0.75);
		emitter.width = 1280 + 300;
		emitter.x = -750;
		emitter.y -= StarParticle.maxHeight;
		emitter.alpha.set(1, 1, 1, 1);
		emitter.lifespan.set(5, 10);
		emitter.particleClass = StarParticle;
		for (_ in 0...25) { // precache
			emitter.add(new StarParticle());
		}

		this.add(emitter);

		emitter.start(false, 1, 0);

        this.multiplyBar = new BGSprite("menuassets/extrasMultiply", 0, 0, 0, 0);
        this.multiplyBar.scale.set(0.8, 0.8);
        this.multiplyBar.updateHitbox();
        this.multiplyBar.screenCenter(XY);
        this.multiplyBar.alpha = 1.0;
        this.multiplyBar.blend = BlendMode.MULTIPLY;
        this.multiplyBar.antialiasing = ClientPrefs.data.antialiasing;
        this.add(this.multiplyBar);

		concepts = new FlxSprite(-80, -28);
		concepts.updateHitbox();
		concepts.alpha = 1;
		concepts.antialiasing = ClientPrefs.data.antialiasing;
		concepts.screenCenter(XY);
		concepts.scale.set(0.55, 0.55);
		add(concepts);

		leftSelect = new BGSprite('menuassets/arrowButton', 120, 300, 0, 0);
		leftSelect.updateHitbox();
		leftSelect.alpha = 0.6;
		//leftSelect.scale.set(0.8,0.8);
		leftSelect.antialiasing = ClientPrefs.data.antialiasing;
		add(leftSelect);

		rightSelect = new BGSprite('menuassets/arrowButton', FlxG.width / 2 + 450, 300, 0, 0);
		rightSelect.updateHitbox();
		rightSelect.alpha = 0.7;
		rightSelect.flipX = true;
		//rightSelect.scale.set(0.8,0.8);
		rightSelect.antialiasing = ClientPrefs.data.antialiasing;
		add(rightSelect);



		bioText = new FlxText(250, 550, 1000);
		bioText.setFormat(Paths.font("vcr.ttf"), 24, 0xFFffcf53, JUSTIFY, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		bioText.borderColor = 0xFF850303;
		bioText.borderSize = 2;
		add(bioText);

		//json
		var file;
		if (FileSystem.exists("assets/shared/data/artworkData.json")) {
			file = File.getContent("assets/shared/data/artworkData.json");
		} else {
			trace('couldnt load characters');
			return;
		}
		var parsed = tjson.TJSON.parse(file);
		for (charName in Reflect.fields(parsed.Characters)) {
			var charData = Reflect.field(parsed.Characters, charName);
			characters.set(charName, charData);
		}

		trace(characters['mikuStage'].bio); //Testie
		changeSelection();
		switchBio();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		// <Tantalun>: in case you would like to give the substate a different amount of chromatic abberation
		GameShaders.CHROMATIC_ABBERATION.chromOff = 0.5;

		var lerpVal:Float = Math.exp(-elapsed * 10);
		if (FlxG.sound.music.volume < 0.8) {
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (!selectedSomethin) {
			if (controls.BACK) {
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				this.close();
			}

			/*if (controls.ACCEPT) {
				FlxG.sound.play(Paths.sound('scrollMenu'));
				switchBetween();
				selectedSomethin = true;
			}*/

		}
			if (controls.UI_LEFT_P) {
			FlxTween.cancelTweensOf(leftSelect);
			leftSelect.alpha = 1;
			FlxTween.tween(leftSelect, {alpha: 0.6}, 0.6, {ease: FlxEase.quartInOut});
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeSelection(-1);
			readingComments = false;
			switchBio();
			}

			 if (controls.UI_RIGHT_P) {
			FlxTween.cancelTweensOf(rightSelect);
			rightSelect.alpha = 1;
			FlxTween.tween(rightSelect, {alpha: 0.6}, 0.6, {ease: FlxEase.quartInOut});
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeSelection(1);
			readingComments = false;
			switchBio();
			}

		super.update(elapsed);
	}


	function changeSelection(change2:Int = 0, playSound:Bool = true) {

		curSelected2 += change2;

		if (curSelected2 < 0)
			curSelected2 = charList.length - 1;
		if (curSelected2 >= charList.length)
			curSelected2 = 0;

	}

	function switchBetween() {

		if (!readingComments)
		{
		readingComments = true;
		FlxTween.cancelTweensOf(bioText);
		FlxTween.tween(bioText, {alpha: 0}, 0.5, {ease: FlxEase.quartOut});
		}
		else {
		switchBio();
		readingComments = false;
		var cooldown:FlxTimer;
		cooldown = new FlxTimer().start(1, function(tmr:FlxTimer)
			{selectedSomethin = false;}, 0);
		}



	}
	function switchBio() {
		FlxTween.cancelTweensOf(bioText);
		FlxTween.cancelTweensOf(concepts);



		switch (curSelected2)
		{
			case 0: //done--------------------
			{
				bioText.text = characters['mikuStage'].bio;
				concepts.loadGraphic(Paths.image(characters['mikuStage'].imageFile));
				bioText.x = 140; bioText.y = 570; concepts.x = -16; concepts.y = -20; concepts.scale.set(0.55, 0.55);
			}
			case 1: //done------------------
			{
				bioText.text = characters['aiAlfieDesign'].bio;
				concepts.loadGraphic(Paths.image(characters['aiAlfieDesign'].imageFile));
				bioText.x = 140; bioText.y = 550; concepts.x = 348; concepts.y = -55; concepts.scale.set(0.65, 0.65);
			}
			case 2: //done ----------------
			{
				bioText.text = characters['firstPromo'].bio;
				concepts.loadGraphic(Paths.image(characters['firstPromo'].imageFile));
				bioText.x = 140; bioText.y = 560; concepts.x = -320; concepts.y = -220; concepts.scale.set(0.37, 0.37);
			}
			case 3: //done-----------------
			{
				bioText.text = characters['secondPromo'].bio;
				concepts.loadGraphic(Paths.image(characters['secondPromo'].imageFile));
				bioText.x = 140; bioText.y = 550; concepts.x = -9; concepts.y = -70; concepts.scale.set(0.55, 0.55);
			}
			case 4: //done--------------
			{
				bioText.text = characters['hooman'].bio;
				concepts.loadGraphic(Paths.image(characters['hooman'].imageFile));
				bioText.x = 140; bioText.y = 570; concepts.x = 265; concepts.y = 100; concepts.scale.set(0.7, 0.7);
			}
			case 5:
			{
				bioText.text = characters['artificial'].bio;
				concepts.loadGraphic(Paths.image(characters['artificial'].imageFile));
				bioText.x = 140; bioText.y = 575; concepts.x = 40; concepts.y = -285; concepts.scale.set(0.4, 0.4);
			}
			case 6:
			{
				bioText.text = characters['artificial2'].bio;
				concepts.loadGraphic(Paths.image(characters['artificial2'].imageFile));
				bioText.x = 140; bioText.y = 575; concepts.x = 100; concepts.y = -215; concepts.scale.set(0.42, 0.42);
			}
			case 7:
			{
				bioText.text = characters['oldAlbums'].bio;
				concepts.loadGraphic(Paths.image(characters['oldAlbums'].imageFile));
				bioText.x = 140; bioText.y = 575; concepts.x = 100; concepts.y = -215; concepts.scale.set(0.42, 0.42);
			}
			case 8:
			{
				bioText.text = characters['forestFire'].bio;
				concepts.loadGraphic(Paths.image(characters['forestFire'].imageFile));
				bioText.x = 140; bioText.y = 575; concepts.x = 100; concepts.y = 10; concepts.scale.set(0.66, 0.66);
			}
			case 9:
			{
				bioText.text = characters['deadbf'].bio;
				concepts.loadGraphic(Paths.image(characters['deadbf'].imageFile));
				bioText.x = 140; bioText.y = 550; concepts.x = 521; concepts.y = 200; concepts.scale.set(1, 1);
			}
			case 10:
			{
				bioText.text = characters['minusPoses'].bio;
				concepts.loadGraphic(Paths.image(characters['minusPoses'].imageFile));
				bioText.x = 140; bioText.y = 560; concepts.x = 100; concepts.y = -10; concepts.scale.set(0.6, 0.6);
			}
			case 11:
			{
				bioText.text = characters['minusPoses2'].bio;
				concepts.loadGraphic(Paths.image(characters['minusPoses2'].imageFile));
				bioText.x = 140; bioText.y = 560; concepts.x = 360; concepts.y = -45; concepts.scale.set(0.63, 0.63);
			}
			case 12:
			{
				bioText.text = characters['fuckinArrested'].bio;
				concepts.loadGraphic(Paths.image(characters['fuckinArrested'].imageFile));
				bioText.x = 140; bioText.y = 560; concepts.x = 507; concepts.y = 240; concepts.scale.set(1.5, 1.5);
			}
			case 13:
			{
				bioText.text = characters['wellthissucks'].bio;
				concepts.loadGraphic(Paths.image(characters['wellthissucks'].imageFile));
				bioText.x = 140; bioText.y = 560; concepts.x = 140; concepts.y = -190; concepts.scale.set(0.44, 0.44);
			}
			case 14:
			{
				bioText.text = characters['alfandquaver'].bio;
				concepts.loadGraphic(Paths.image(characters['alfandquaver'].imageFile));
				bioText.x = 140; bioText.y = 550; concepts.x = -58; concepts.y = -340; concepts.scale.set(0.36, 0.36);
			}
		}
		bioText.alpha = 0;
		//bioText.screenCenter(X);
		FlxTween.tween(bioText, {alpha: 1}, 0.5, {ease: FlxEase.quartOut});

		concepts.alpha = 0;
		//concepts.screenCenter(XY);
		FlxTween.tween(concepts, {alpha: 1}, 0.5, {ease: FlxEase.quartOut});

		trace(bioText.x, bioText.y);
		trace(concepts.x, concepts.y);

	}
}
