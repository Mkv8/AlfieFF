package states;

import flixel.effects.particles.FlxEmitter;
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

class MainMenuState extends MusicBeatState {
	public static var psychEngineVersion:String = '0.7.3'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	// THE MENU HAS 4 OPTIONS: SONGS, EXTRAS, CREDITS, OPTIONS, YOU CAN USE THE FREEPLAY MENU AS THE SONGS MENU SINCE ITS LITERALLY THE SAME THING
	var optionShit:Array<String> = ['freeplay', 'credits', 'options'];

	var magenta:FlxSprite;
	var camFollow:FlxObject;

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

		var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menuassets/mainExtraBg'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0, 0);
		//bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.scale.set(0.8, 0.8);
		add(bg);

		var emitter: FlxEmitter = new FlxEmitter(-700, -300);
		emitter.launchMode = FlxEmitterMode.SQUARE;
		emitter.velocity.set(50, 150, 100, 200);
		emitter.scale.set(0.5, 0.5, 1, 1, 0.5, 0.5, 0.75, 0.75);
		//emitter.drag.set(0, 0, 0, 0, 5, 5, 10, 10);
		emitter.width = 1280 + 300;
		emitter.x = -750;//(FlxG.width / 2) - (emitter.width / 2);
		emitter.alpha.set(1, 1, 1, 1);
		emitter.lifespan.set(5, 10);
		emitter.particleClass = StarParticle;
		//emitter.loadParticles(Paths.image('Particles/Particle' + i), 500, 16, true);
		for (j in 0...25) { // precache
			var star: StarParticle = new StarParticle();
			emitter.add(star);
		}
		emitter.y -= StarParticle.maxHeight;

		emitter.start(false, 1, 100000);
		add(emitter);

		multiplyBar = new BGSprite('menuassets/mainMenuMultiply', -80, 0, 0, 0); 
		multiplyBar.updateHitbox();
		multiplyBar.alpha = 1;
		multiplyBar.scale.set(0.8,0.8);
		multiplyBar.screenCenter(Y);
		multiplyBar.blend = BlendMode.MULTIPLY;
		multiplyBar.antialiasing = ClientPrefs.data.antialiasing;
		add(multiplyBar);

		randomRender = new BGSprite('RENDERS/AlfieMSRenderAlt', -600, 0, 0, 0); //I assume youll make an array of possible renders?
		randomRender.updateHitbox();
		randomRender.alpha = 1;
		randomRender.scale.set(0.28,0.28);
		randomRender.screenCenter(Y);
		randomRender.antialiasing = ClientPrefs.data.antialiasing;
		add(randomRender);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.antialiasing = ClientPrefs.data.antialiasing;
		magenta.scrollFactor.set(0, 0);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.color = 0xFFfd719b;
		//add(magenta);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length) {
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
			menuItem.screenCenter(X);
		}

		var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		psychVer.scrollFactor.set();
		psychVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(psychVer);
		var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		fnfVer.scrollFactor.set();
		fnfVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fnfVer);
		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		// Unlocks "Freaky on a Friday Night" achievement if it's a Friday and between 18:00 PM and 23:59 PM
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
			Achievements.unlock('friday_night_play');

		#if MODS_ALLOWED
		Achievements.reloadList();
		#end
		#end


		super.create();
		FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

		FlxG.camera.setFilters([new ShaderFilter(curveShader)]);
		FlxG.camera.filtersEnabled = true;

		curveShader.chromOff = 4;
		FlxG.camera.follow(camFollow, null, 9);
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
				changeItem(-1);

			if (controls.UI_DOWN_P)
				changeItem(1);

			if (controls.BACK) {
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT) {
				FlxG.sound.play(Paths.sound('confirmMenu'));
				if (optionShit[curSelected] == 'donate') {
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				} else {
					selectedSomethin = true;

					if (ClientPrefs.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					FlxFlicker.flicker(menuItems.members[curSelected], 1, 0.06, false, false, function(flick:FlxFlicker) {
						switch (optionShit[curSelected]) {
							case 'story_mode':
								MusicBeatState.switchState(new StoryMenuState());
							case 'freeplay':
								MusicBeatState.switchState(new FreeplayState());

							#if MODS_ALLOWED
							case 'mods':
								MusicBeatState.switchState(new ModsMenuState());
							#end

							#if ACHIEVEMENTS_ALLOWED
							case 'awards':
								MusicBeatState.switchState(new AchievementsMenuState());
							#end

							case 'credits':
								MusicBeatState.switchState(new CreditsState());
							case 'options':
								MusicBeatState.switchState(new OptionsState());
								OptionsState.onPlayState = false;
								if (PlayState.SONG != null) {
									PlayState.SONG.arrowSkin = null;
									PlayState.SONG.splashSkin = null;
									PlayState.stageUI = 'normal';
								}
						}
					});

					for (i in 0...menuItems.members.length) {
						if (i == curSelected)
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
			}
			#if desktop
			if (controls.justPressed('debug_1')) {
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0) {
		FlxG.sound.play(Paths.sound('scrollMenu'));
		menuItems.members[curSelected].animation.play('idle');
		menuItems.members[curSelected].updateHitbox();
		menuItems.members[curSelected].screenCenter(X);

		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.members[curSelected].animation.play('selected');
		menuItems.members[curSelected].centerOffsets();
		menuItems.members[curSelected].screenCenter(X);

		//camFollow.setPosition(menuItems.members[curSelected].getGraphicMidpoint().x, menuItems.members[curSelected].getGraphicMidpoint().y
			//- (menuItems.length > 4 ? menuItems.length * 8 : 0));
	}
}
