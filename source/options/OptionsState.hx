package options;

import states.MainMenuState;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import backend.StageData;

class OptionsState extends MusicBeatState {
	var options:Array<String> = [
		'Controls',
		'Adjust Delay',
		'Graphics',
		'Visuals and UI',
		'Gameplay'
	];
	private var grpOptions:FlxTypedGroup<FlxText>;

	private static var curSelected:Int = 0;

	public static var onPlayState:Bool = false;
	public static var menuBG:FlxSprite;
	public var gear1:BGSprite;
	public var gear2:BGSprite;
	public var alfie:BGSprite;
	var texts:Array<FlxText> = [];

	//on this menu all you have to do is change the all the letters into the right font, and then reposition the options so that theyre on the left...
	//idk how the submenus work here? I dont think it will be much of a problem but honestly who knows with fnf......
	//reminder that theres concept pics of how they should look like in the menu assets folder!
	// use this one and not BaseOptionsMenu

	var shader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.PostProcessing()),
	];

	var curveShader = new shaders.CurveShader();

	function openSelectedSubstate(label:String) {
		switch (label) {
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Visuals and UI':
				openSubState(new options.VisualsUISubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Adjust Delay':
				MusicBeatState.switchState(new options.NoteOffsetState());
		}
	}

	var selectorLeft:FlxText;
	var selectorRight:FlxText;

	override function create() {
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Options Menu", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuassets/optionsMenu'));
		bg.scale.set(0.8, 0.8);
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg);

		gear1 = new BGSprite('menuassets/gear', FlxG.width * 0.75 + 25, -200, 0, 0); //spins counter clock wise
		gear1.updateHitbox();
		gear1.alpha = 1;
		gear1.scale.set(0.8,0.8);
		gear1.antialiasing = ClientPrefs.data.antialiasing;
		add(gear1);	


		gear2 = new BGSprite('menuassets/gear', -180, FlxG.height * 0.71, 0, 0); //spins counter clock wise
		gear2.updateHitbox();
		gear2.alpha = 1;
		gear2.scale.set(0.8,0.8);
		gear2.antialiasing = ClientPrefs.data.antialiasing;
		add(gear2);	

		alfie = new BGSprite('menuassets/alfieOptions', FlxG.width * 0.5 - 75, 90, 0, 0, ['thonk'], true);
		alfie.updateHitbox();
		alfie.alpha = 1;
		alfie.scale.set(0.8,0.8);
		alfie.animation.play('thonk', true, false);
		alfie.antialiasing = ClientPrefs.data.antialiasing;
		add(alfie);	

		var bigassoptionstextohemgee:FlxText = new FlxText(100, 50, 'OPTIONS', 64);
			bigassoptionstextohemgee.setFormat(Paths.font("vcr.ttf"), 72, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			bigassoptionstextohemgee.borderColor = 0xFF000000;
			bigassoptionstextohemgee.borderSize = 3;
			add(bigassoptionstextohemgee);

		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);

		for (i in 0...options.length) {
			var optionText:FlxText = new FlxText(100, 0, options[i], 36);
			optionText.setFormat(Paths.font("vcr.ttf"), 56, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			optionText.borderColor = 0xFF000000;
			optionText.borderSize = 3;
			//optionText.screenCenter();
			optionText.y += (150 + (i*80)) + 10;
			grpOptions.add(optionText);
			texts.push(optionText);
		}

		selectorLeft = new FlxText(0, 0, '>', true);
		add(selectorLeft);
		selectorRight = new FlxText(0, 0, '<', true);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
		FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

		FlxG.camera.setFilters([new ShaderFilter(curveShader)]);
		FlxG.camera.filtersEnabled = true;

		curveShader.chromOff = 4;
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Options Menu", null);
		#end
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		gear1.angle -= 5 * elapsed;
		gear2.angle += 5 * elapsed;

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if (onPlayState) {
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
			} else
				MusicBeatState.switchState(new MainMenuState());
		} else if (controls.ACCEPT)
			openSelectedSubstate(options[curSelected]);

		var lerpVal:Float = Math.exp(-elapsed * 10);

		for (i in texts)
		{
			i.scale.set(
				FlxMath.lerp(i == texts[curSelected] ? 1.05:1, i.scale.x, lerpVal),
				FlxMath.lerp(i == texts[curSelected] ? 1.05:1, i.scale.y, lerpVal)
			);
			i.alpha = FlxMath.lerp(i == texts[curSelected] ? 1: 0.4, i.alpha, lerpVal);
		}
	}

	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		FlxG.sound.play(Paths.sound('scrollMenu'));

	}

	override function destroy() {
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}
