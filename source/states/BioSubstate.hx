package states;

import flixel.effects.particles.FlxEmitter;
import flixel.FlxObject;
import openfl.filters.BitmapFilter;
import openfl.display.BlendMode;
import openfl.filters.ShaderFilter;

class BioSubstate extends MusicBeatSubstate {
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

		this.multiplyBar = new BGSprite("menuassets/mainMenuMultiply", -500, 0, 0, 0);
		this.multiplyBar.scale.set(0.8, 0.8);
		this.multiplyBar.updateHitbox();
		this.multiplyBar.screenCenter(Y);
		this.multiplyBar.alpha = 0.0;
		this.multiplyBar.blend = BlendMode.MULTIPLY;
		this.multiplyBar.antialiasing = ClientPrefs.data.antialiasing;
		this.add(this.multiplyBar);

		FlxTween.tween(multiplyBar, {x: 0, alpha: 1.0}, 1.2, {ease: FlxEase.quartInOut, startDelay: 0.1});

		// var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		// psychVer.scrollFactor.set();
		// psychVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		// this.add(psychVer);

		// var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		// fnfVer.scrollFactor.set();
		// fnfVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		// this.add(fnfVer);

		FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

		//FlxG.camera.setFilters([new ShaderFilter(curveShader)]);
		//FlxG.camera.filtersEnabled = true;

		//curveShader.chromOff = 4;
		// FlxG.camera.follow(camFollow, null, 9);
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
				this.closeSubState();
			}

			if (controls.ACCEPT) {
				FlxG.sound.play(Paths.sound('confirmMenu'));

				selectedSomethin = true;
			}
		}

		super.update(elapsed);
	}
}
