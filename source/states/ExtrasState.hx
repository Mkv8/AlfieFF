package states;

import flixel.effects.particles.FlxEmitter;
import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import openfl.filters.BitmapFilter;
import openfl.display.BlendMode;
import openfl.filters.ShaderFilter;

class ExtrasState extends MusicBeatState {
    private static final menuOptions:Array<String> = ["Character Bios", "Artwork"];

    var menuItems: FlxSpriteGroup = new FlxSpriteGroup();

    private var grpOptions:FlxTypedGroup<FlxText>;

    private static var curSelected:Int = 0;

    var texts:Array<FlxText> = [];

    var curveShader = new shaders.CurveShader();

    var camFollow: FlxObject;

    var multiplyBar:BGSprite; //im using bgsprite cuz i think its just like the same thing as flxsprite but easier to use right lmao

    var shader:Array<BitmapFilter> = [
        new ShaderFilter(new shaders.PostProcessing()),
    ];


    function openSelectedSubstate(label:String) {
        switch (label) {
            case 'Character Bios':
                this.openSubState(new BioSubstate());
            case 'Artwork':
                this.openSubState(new ArtworkSubstate());
        }
    }

    override function create() {
        #if MODS_ALLOWED
        Mods.pushGlobalMods();
        #end
        Mods.loadTopMod();

        #if DISCORD_ALLOWED
        // Updating Discord Rich Presence
        DiscordClient.changePresence("Checking out Extras!", null);
        #end

        transIn = FlxTransitionableState.defaultTransIn;
        transOut = FlxTransitionableState.defaultTransOut;

        super.create();

        var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image("menuassets/mainExtraBg"));
        bg.antialiasing = ClientPrefs.data.antialiasing;
        bg.scrollFactor.set(0, 0);
        bg.updateHitbox();
        bg.screenCenter();
        bg.scale.set(0.8, 0.8);
        add(bg);

        var emitter:FlxEmitter = new FlxEmitter(-700, -300);
        emitter.launchMode = FlxEmitterMode.SQUARE;
        emitter.velocity.set(50, 150, 100, 200);
        emitter.scale.set(0.5, 0.5, 1, 1, 0.5, 0.5, 0.75, 0.75);
        emitter.width = 1280 + 300;
        emitter.x = -750;//(FlxG.width / 2) - (emitter.width / 2);
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

        grpOptions = new FlxTypedGroup<FlxText>();
        add(grpOptions);

        for (i in 0...menuOptions.length) {
            var optionText:FlxText = new FlxText(0, 40, menuOptions[i], 88);
            optionText.setFormat(Paths.font("vcr.ttf"), 88, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            optionText.borderColor = 0xFF850303;
            optionText.borderSize = 8;
            optionText.screenCenter(X);
            optionText.y += (150 + (i*200)) + 10;
            grpOptions.add(optionText);
            texts.push(optionText);
        }

        this.menuItems.x = 40.0;
        this.menuItems.screenCenter(Y);

        this.add(this.menuItems);

        FlxG.game.setFilters(shader);
        FlxG.game.filtersEnabled = true;

        this.changeSelection();
    }

    var selectedSomethin:Bool = false;

    override function update(elapsed:Float) {
        super.update(elapsed);
        if (controls.UI_UP_P) {
            changeSelection(-1);
        }
        if (controls.UI_DOWN_P) {
            changeSelection(1);
        }

        if (controls.BACK) {
            selectedSomethin = true;
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new MainMenuState());
        } else if (controls.ACCEPT) {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            openSelectedSubstate(menuOptions[curSelected]);
        }

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
            curSelected = menuOptions.length - 1;
        if (curSelected >= menuOptions.length)
            curSelected = 0;

        var bullShit:Int = 0;

        FlxG.sound.play(Paths.sound('scrollMenu'));

    }
}
