package states;

import shaders.GameShaders;
import flixel.effects.particles.FlxEmitter;
import flixel.FlxObject;
import openfl.filters.BitmapFilter;
import openfl.display.BlendMode;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class BioSubstate extends MusicBeatSubstate {
	var characters:Map<String, Dynamic> = new Map<String, Dynamic>();
	var charList = ['Alfie', 'Boyfriend', 'Girlfriend', 'Kisston', 'Kai & Erhardt', 'Filip', 'Nikku', 'Ai', 'Hatsune Miku', '?????']; //Use this as the order to show them bc maps dont have an order to them

	var menuItems: FlxSpriteGroup = new FlxSpriteGroup();
	var camFollow: FlxObject;

	var multiplyBar:BGSprite; //im using bgsprite cuz i think its just like the same thing as flxsprite but easier to use right lmao
	var renders:FlxSprite; //this is for the renders
	var comment1:BGSprite;
	var comment2:BGSprite;
	var comment3:BGSprite;

	var leftSelect:BGSprite;
	var rightSelect:BGSprite;

	var texts:Array<FlxSprite> = [];
	var nameTexts:FlxText;
	var bioText:FlxText;
	private static var curSelected:Int = 0;

	var infoText:FlxText;
	var readingComments:Bool = false;

	//THANK YOU FERZY FOR THE JSON HELP !!!!!! EVERYONE SAY THANK YOU FERZY !!!!

	override function create() {
		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Reading bios!", null);
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

		renders = new FlxSprite(-80, -28);
		renders.updateHitbox();
		renders.alpha = 1;
		renders.antialiasing = ClientPrefs.data.antialiasing;
		add(renders);

		leftSelect = new BGSprite('menuassets/arrowButton', FlxG.width / 2 - 100, 80, 0, 0);
		leftSelect.updateHitbox();
		leftSelect.alpha = 0.6;
		//leftSelect.scale.set(0.8,0.8);
		leftSelect.antialiasing = ClientPrefs.data.antialiasing;
		add(leftSelect);

		rightSelect = new BGSprite('menuassets/arrowButton', FlxG.width / 2 + 430, 80, 0, 0);
		rightSelect.updateHitbox();
		rightSelect.alpha = 0.7;
		rightSelect.flipX = true;
		//rightSelect.scale.set(0.8,0.8);
		rightSelect.antialiasing = ClientPrefs.data.antialiasing;
		add(rightSelect);

		nameTexts = new FlxText(690, 93);
		nameTexts.setFormat(Paths.font("vcr.ttf"), 64, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		nameTexts.borderColor = 0xFF850303;
		nameTexts.borderSize = 3;
		add(nameTexts);

		bioText = new FlxText(540, 190, 600);
		bioText.setFormat(Paths.font("vcr.ttf"), 32, 0xFFffcf53, JUSTIFY, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		bioText.borderColor = 0xFF850303;
		bioText.borderSize = 2;
		add(bioText);

		comment1 = new BGSprite('menuassets/extras/comments', 540, 160, 0, 0, ['comments'], false);
		comment1.updateHitbox();
		comment1.alpha = 0;
		comment1.animation.play('comments', true, false);
		comment1.animation.pause();
		comment1.scale.set(0.9,0.9);
		comment1.antialiasing = ClientPrefs.data.antialiasing;
		add(comment1);

		comment2 = new BGSprite('menuassets/extras/comments', 540, 310, 0, 0, ['comments'], false);
		comment2.updateHitbox();
		comment2.alpha = 0;
		comment2.animation.play('comments', true, false);
		comment2.animation.pause();
		comment2.scale.set(0.9,0.9);
		comment2.antialiasing = ClientPrefs.data.antialiasing;
		add(comment2);

		comment3 = new BGSprite('menuassets/extras/comments', 540, 460, 0, 0, ['comments'], false);
		comment3.updateHitbox();
		comment3.alpha = 0;
		comment3.animation.play('comments', true, false);
		comment3.animation.pause();
		comment3.scale.set(0.9,0.9);
		comment3.antialiasing = ClientPrefs.data.antialiasing;
		add(comment3);

		infoText = new FlxText(FlxG.width * 0.51, FlxG.height * 0.94, 800, 'Press ENTER to change info!');
		infoText.setFormat(Paths.font("vcr.ttf"), 28, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoText.borderColor = 0xFF850303;
		infoText.borderSize = 2;
		infoText.alpha = 0.75;
		add(infoText);

		//json
		var file;
		if (FileSystem.exists("assets/shared/data/charBioData.json")) {
			file = File.getContent("assets/shared/data/charBioData.json");
		} else {
			trace('couldnt load characters');
			return;
		}
		var parsed = tjson.TJSON.parse(file);
		for (charName in Reflect.fields(parsed.Characters)) {
			var charData = Reflect.field(parsed.Characters, charName);
			characters.set(charName, charData);
		}

		changeSelection();
		switchBio();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		// <Tantalun>: in case you would like to give the substate a different amount of chromatic abberation
		// GameShaders.CHROMATIC_ABBERATION.chromOff = 2.0;

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

			if (controls.ACCEPT) {
				FlxG.sound.play(Paths.sound('scrollMenu'));
				switchBetween();
				selectedSomethin = true;
			}

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


	function changeSelection(change:Int = 0, playSound:Bool = true) {

		curSelected += change;

		if (curSelected < 0)
			curSelected = charList.length - 1;
		if (curSelected >= charList.length)
			curSelected = 0;

	}

	function switchBetween() {

		if (!readingComments)
		{
		readingComments = true;
		FlxTween.cancelTweensOf(bioText);
		FlxTween.tween(bioText, {alpha: 0}, 0.5, {ease: FlxEase.quartOut});

		comment1.x = 260;
		comment2.x = 260;
		comment3.x = 260;

		FlxTween.tween(comment1, {alpha: 1, x: 460}, 0.9, {ease: FlxEase.quartInOut});
		FlxTween.tween(comment2, {alpha: 1, x: 460}, 0.9, {ease: FlxEase.quartInOut, startDelay: 0.2});
		FlxTween.tween(comment3, {alpha: 1, x: 460}, 0.9, {ease: FlxEase.quartInOut, startDelay: 0.4, onComplete: function(twn:FlxTween) {selectedSomethin = false;}});
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

		FlxTween.cancelTweensOf(comment1);
		FlxTween.cancelTweensOf(comment2);
		FlxTween.cancelTweensOf(comment3);
		comment1.alpha = 0;
		comment2.alpha = 0;
		comment3.alpha = 0;
		bioText.alpha = 0;

		var cooldown:FlxTimer;
		cooldown = new FlxTimer().start(1, function(tmr:FlxTimer)
		{selectedSomethin = false;}, 0);

		FlxTween.tween(bioText, {alpha: 1}, 0.9, {ease: FlxEase.quartInOut});

		if (!readingComments)
		{
		FlxTween.cancelTweensOf(renders);
		renders.alpha = 0;
		renders.x = -280;
		FlxTween.tween(renders, {alpha: 1, x: -80}, 0.9, {ease: FlxEase.quartInOut});
		}
		readingComments = false;


		switch (curSelected)
		{
			case 0:
			{
				nameTexts.text = charList[0];
				nameTexts.x = 690 + 48;
				bioText.text = characters['Alfie'].bio;
				renders.loadGraphic(Paths.image(characters['Alfie'].imageFile));
				comment1.animation.curAnim.curFrame = 0;
				comment2.animation.curAnim.curFrame = 1;
				comment3.animation.curAnim.curFrame = 2;
			}
			case 1:
			{
				nameTexts.x = 690 - 22;
				nameTexts.text = charList[1];
				bioText.text = characters['Boyfriend'].bio;
				renders.loadGraphic(Paths.image(characters['Boyfriend'].imageFile));
				comment1.animation.curAnim.curFrame = 3;
				comment2.animation.curAnim.curFrame = 4;
				comment3.animation.curAnim.curFrame = 5;
				comment3.visible = true;
			}
			case 2:
			{
				nameTexts.x = 690 - 39;
				nameTexts.text = charList[2];
				bioText.text = characters['Girlfriend'].bio;
				renders.loadGraphic(Paths.image(characters['Girlfriend'].imageFile));
				comment1.animation.curAnim.curFrame = 6;
				comment2.animation.curAnim.curFrame = 7;
				comment3.visible = false;
				//comment3.animation.curAnim.curFrame = 8;
			}
			case 3:
			{
				nameTexts.x = 690 + 22;
				nameTexts.text = charList[3];
				bioText.text = characters['Kisston'].bio;
				bioText.size = 32;
				nameTexts.size = 64;
				renders.loadGraphic(Paths.image(characters['Kisston'].imageFile));
				comment3.visible = true;
				comment1.animation.curAnim.curFrame = 8;
				comment2.animation.curAnim.curFrame = 9;
				comment3.animation.curAnim.curFrame = 10;
			}
			case 4:
			{
				nameTexts.x = 690 - 58;
				nameTexts.text = charList[4];
				bioText.text = characters['Kai & Erhardt'].bio;
				bioText.size = 28;
				nameTexts.size = 56;
				renders.loadGraphic(Paths.image(characters['Kai & Erhardt'].imageFile));
				comment1.animation.curAnim.curFrame = 11;
				comment2.animation.curAnim.curFrame = 12;
				comment3.animation.curAnim.curFrame = 13;
			}
			case 5:
			{
				nameTexts.x = 690 + 48;
				nameTexts.text = charList[5];
				bioText.text = characters['Filip'].bio;
				bioText.size = 32;
				nameTexts.size = 64;
				renders.loadGraphic(Paths.image(characters['Filip'].imageFile));
				comment1.animation.curAnim.curFrame = 14;
				comment2.animation.curAnim.curFrame = 15;
				comment3.animation.curAnim.curFrame = 16;
			}
			case 6:
			{
				nameTexts.x = 690 + 48;
				nameTexts.text = charList[6];
				bioText.text = characters['Nikku'].bio;
				renders.loadGraphic(Paths.image(characters['Nikku'].imageFile));
				comment1.animation.curAnim.curFrame = 17;
				comment2.animation.curAnim.curFrame = 18;
				comment3.animation.curAnim.curFrame = 19;
			}
			case 7:
			{
				nameTexts.x = 690 + 100;
				nameTexts.text = charList[7];
				bioText.text = characters['Ai'].bio;
				renders.loadGraphic(Paths.image(characters['Ai'].imageFile));
				nameTexts.size = 64;
				comment1.animation.curAnim.curFrame = 20;
				comment2.animation.curAnim.curFrame = 21;
				comment3.animation.curAnim.curFrame = 22;
			}
			case 8:
			{
				nameTexts.x = 690 - 47;
				nameTexts.size = 56;
				nameTexts.text = charList[8];
				bioText.text = characters['Hatsune Miku'].bio;
				renders.loadGraphic(Paths.image(characters['Hatsune Miku'].imageFile));
				comment1.animation.curAnim.curFrame = 23;
				comment2.animation.curAnim.curFrame = 24;
				comment3.animation.curAnim.curFrame = 25;
			}
			case 9:
			{
				nameTexts.x = 690 + 48;
				nameTexts.size = 64;
				nameTexts.text = charList[9];
				bioText.text = characters['?????'].bio;
				renders.loadGraphic(Paths.image(characters['?????'].imageFile));
				comment1.animation.curAnim.curFrame = 26;
				comment2.animation.curAnim.curFrame = 27;
				comment3.animation.curAnim.curFrame = 28;
			}
		}


	}

}
