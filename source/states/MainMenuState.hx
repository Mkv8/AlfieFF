package states;

import openfl.display.Window;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.effects.particles.FlxEmitter;
import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import openfl.filters.BitmapFilter;
import openfl.display.BlendMode;
import openfl.filters.ShaderFilter;

typedef RenderData = {
	name: String,
	offset: {
		x: Float,
		y: Float,
	},
	scale: Float,
}

class MainMenuState extends MusicBeatState {
	// THE MENU HAS 4 OPTIONS: SONGS, EXTRAS, CREDITS, OPTIONS, YOU CAN USE THE FREEPLAY MENU AS THE SONGS MENU SINCE ITS LITERALLY THE SAME THING
	private static final menuOptions:Array<String> = ["songs", "extras", "credits", "options"];

	private static var selection:Int = 0;

	public static final renderDatas:Array<RenderData> = [
		{ name: "AlfieMSRender", offset: { x: 0.0, y: 0.0 }, scale: 0.45 },
		{ name: "AlfieMSRenderAlt", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "AiMSRender", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "AiMSRenderAlt", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "BFMSRender", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "BFMSRenderAlt", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "FilipMSRender", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "FilipMSRenderAlt", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "GFMSRender", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "GFMSRenderAlt", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "KaiMSRender", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "KaiMSRenderAlt", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "KisstonMSRender", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "KisstonMSRenderAlt", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "MikuMSRender", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "MikuMSRenderAlt", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "minusMSRender", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "NikkuMSRender", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
		{ name: "NikkuMSRenderAlt", offset: { x: 0.0, y: 0.0 }, scale: 1.0 },
	];

	public static var psychEngineVersion:String = "0.7.3"; // This is also used for Discord RPC

	var menuItems: FlxSpriteGroup = new FlxSpriteGroup();
	var magenta: FlxSprite;
	var camFollow: FlxObject;

	var multiplyBar:BGSprite; //im using bgsprite cuz i think its just like the same thing as flxsprite but easier to use right lmao
	var randomRender:BGSprite; //this is for the random renders

	//BASIC NOTES:
	//When you enter the menu, the multiplyBar and the randomRender slide in from the left and right respectedly (check the concept pics i sent, they're also in the files
	//Everytime you enter the menu it chooses a random render to display... HOWEVER
	//Would it be possible to make it so a character render would only show up if youve played the song that character is from? so that you don't get spoiled on Nikku
	//before actually playing her song.....

	//When highlighted, the button would use the songButton animation, while the non highlighted option uses the songButtonUnselected animation... It'd also be good if
	//the icon got a little bigger when you highlighted it (like a tween for the size..)

	//What I'm gonna do for this menu here is add in all the visuals...... I dunno how to mess with these buttons too much so I won't try it bc i might just break things
	//For hte random render i'm gonna just make it Alfie for now, but it should pick from any of the renders in the RENDERS folder

	//For the extras menu, you can copy and pastethis one and then just replace stuff as necessary!

	var shader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.PostProcessing()),
	];

	/*var curveShader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.CurveShader()),
	];*/

	var curveShader = new shaders.CurveShader();

	override function create() {
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

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

		this.multiplyBar = new BGSprite("menuassets/mainMenuMultiply", 0, 0, 0, 0);
		this.multiplyBar.scale.set(0.8, 0.8);
		this.multiplyBar.updateHitbox();
		this.multiplyBar.screenCenter(Y);
		this.multiplyBar.alpha = 1.0;
		this.multiplyBar.blend = BlendMode.MULTIPLY;
		this.multiplyBar.antialiasing = ClientPrefs.data.antialiasing;
		this.add(this.multiplyBar);

		if (MainMenuState.renderDatas.length > 0) {
			// var randomRenderData: RenderData = MainMenuState.renderDatas[FlxG.random.int(0, MainMenuState.renderDatas.length - 1)];
			var randomRenderData: RenderData = MainMenuState.renderDatas[0];

			this.randomRender = new BGSprite('RENDERS/${randomRenderData.name}');
			this.randomRender.scale.set(randomRenderData.scale, randomRenderData.scale);
			this.randomRender.updateHitbox();
			this.randomRender.x = 580.0 + randomRenderData.offset.x;
			this.randomRender.y = 0.0 + randomRenderData.offset.y;
			// this.randomRender.screenCenter(Y);
			this.randomRender.alpha = 1.0;
			this.randomRender.antialiasing = ClientPrefs.data.antialiasing;
			this.add(this.randomRender);
		}

		var menuItemAtlas: FlxAtlasFrames = Paths.getSparrowAtlas("menuassets/mainMenuButtons");

		final menuItemSpacing: Float = 10.0;

		var menuItemOffsetY: Float = 0.0;

		for (i in 0...menuOptions.length) {
			var menuItem: FlxSprite = new FlxSprite(i * 30.0, menuItemOffsetY);
			menuItem.frames = menuItemAtlas;
			menuItem.animation.addByPrefix("idle", '${menuOptions[i]}ButtonIdle', 24);
			menuItem.animation.addByPrefix("selected", '${menuOptions[i]}ButtonSelected', 24);
			menuItem.animation.play("idle");
			menuItem.scale.set(0.8, 0.8);
			menuItem.scrollFactor.set(0.0, 0.0);
			menuItem.updateHitbox();
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			this.menuItems.add(menuItem);

			menuItemOffsetY += menuItem.height + (i == menuOptions.length - 1 ? 0.0 : menuItemSpacing);
		}

		this.menuItems.x = 40.0;
		this.menuItems.screenCenter(Y);

		this.add(this.menuItems);

		// var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		// psychVer.scrollFactor.set();
		// psychVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		// this.add(psychVer);

		// var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		// fnfVer.scrollFactor.set();
		// fnfVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		// this.add(fnfVer);

		// FlxG.game.setFilters(shader);
		// FlxG.game.filtersEnabled = true;

		// FlxG.camera.setFilters([new ShaderFilter(curveShader)]);
		// FlxG.camera.filtersEnabled = true;

		// curveShader.chromOff = 4;
		// FlxG.camera.follow(camFollow, null, 9);

		this.changeSelection();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float) {
		if (FlxG.sound.music.volume < 0.8) {
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (!selectedSomethin) {
			if (controls.UI_UP_P)
				changeSelection(-1);

			if (controls.UI_DOWN_P)
				changeSelection(1);

			if (controls.BACK) {
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT) {
				FlxG.sound.play(Paths.sound('confirmMenu'));

				selectedSomethin = true;

				if (ClientPrefs.data.flashing)
					FlxFlicker.flicker(magenta, 1.1, 0.15, false);

				FlxFlicker.flicker(menuItems.members[selection], 1, 0.06, false, false, function(flick:FlxFlicker) {
					switch (menuOptions[selection]) {
						case "songs":
							MusicBeatState.switchState(new FreeplayState());

						case "extras":
							MusicBeatState.switchState(new ExtrasState());

						case "credits":
							MusicBeatState.switchState(new CreditsState());

						case "options":
							MusicBeatState.switchState(new OptionsState());
							OptionsState.onPlayState = false;

							if (PlayState.SONG != null) {
								PlayState.SONG.arrowSkin = null;
								PlayState.SONG.splashSkin = null;
								PlayState.stageUI = "normal";
							}
					}
				});

				for (i in 0...menuItems.members.length) {
					if (i == selection)
						continue;
					FlxTween.tween(menuItems.members[i], {
						alpha: 0
					}, 0.4, {
						ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween) {
							menuItems.members[i].kill();
						}
					});
				}
			}

			if (controls.justPressed('debug_1')) {
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
		}

		super.update(elapsed);
	}

	function changeSelection(direction:Int = 0) {
		FlxG.sound.play(Paths.sound("scrollMenu"));

		menuItems.members[selection].animation.play("idle");
		menuItems.members[selection].updateHitbox();

		selection += direction;

		if (selection < 0) {
			selection = menuItems.length - 1;
		} else if (selection >= menuItems.length) {
			selection = 0;
		}

		menuItems.members[selection].animation.play("selected");
		menuItems.members[selection].updateHitbox();
	}
}
