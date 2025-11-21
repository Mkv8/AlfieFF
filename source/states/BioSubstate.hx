package states;

import flixel.effects.particles.FlxEmitter;
import flixel.FlxObject;
import openfl.filters.BitmapFilter;
import openfl.display.BlendMode;
import openfl.filters.ShaderFilter;

class BioSubstate extends MusicBeatSubstate {
	var characters:Map<String, Dynamic> = new Map<String, Dynamic>();
	var charList = ['Alfie', 'Bella']; //Use this as the order to show them bc maps dont have an order to them

	var menuItems: FlxSpriteGroup = new FlxSpriteGroup();
	var camFollow: FlxObject;

	var multiplyBar:BGSprite; //im using bgsprite cuz i think its just like the same thing as flxsprite but easier to use right lmao
	var randomRender:BGSprite; //this is for the random renders
	var texts:Array<FlxSprite> = [];

	var shader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.PostProcessing()),
	];

	/*var curveShader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.CurveShader()),
	];*/

	var curveShader = new shaders.CurveShader();

	override function create() {
		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
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
		//emitter.drag.set(0, 0, 0, 0, 5, 5, 10, 10);
		emitter.width = 1280 + 300;
		emitter.x = -750;//(FlxG.width / 2) - (emitter.width / 2);
		emitter.y -= StarParticle.maxHeight;
		emitter.alpha.set(1, 1, 1, 1);
		emitter.lifespan.set(5, 10);
		emitter.particleClass = StarParticle;
		//emitter.loadParticles(Paths.image('Particles/Particle' + i), 500, 16, true);

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

		FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

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

		trace(characters['Alfie'].bio); //Testie
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float) {
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
				FlxG.sound.play(Paths.sound('confirmMenu'));

				selectedSomethin = true;
			}
		}

		super.update(elapsed);
	}
}
