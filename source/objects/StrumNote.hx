package objects;

import backend.animation.PsychAnimationController;

class StrumNote extends FlxSprite {
	public var resetAnim:Float = 0;

	private var noteData:Int = 0;

	public var direction:Float = 90; // plan on doing scroll directions soon -bb
	public var downScroll:Bool = false; // plan on doing scroll directions soon -bb
	public var sustainReduce:Bool = true;

	private var player:Int;

	public var texture(default, set):String = null;

	private function set_texture(value:String):String {
		if (texture != value) {
			texture = value;
			reloadNote();
		}
		return value;
	}

	public function new(x:Float, y:Float, leData:Int, player:Int, customSkin:String = null) {
		super(x, y);
		animation = new PsychAnimationController(this);
		this.player = player;
		this.noteData = leData;

		var skin:String = customSkin;
		if (skin == null) {
			if (PlayState.SONG != null && PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1)
				skin = PlayState.SONG.arrowSkin;
			else
				skin = Note.defaultNoteSkin;

			var customSkin:String = skin;
			if (Paths.fileExists('images/$customSkin.png', IMAGE))
				skin = customSkin;
		}

		//#if debug
		//trace('Note skin for player $player is $skin with id $noteData (forced was $customSkin)');
		//#end

		texture = skin; // Load texture and anims
		scrollFactor.set();
	}

	public function reloadNote() {
		var lastAnim:String = null;
		if (animation.curAnim != null)
			lastAnim = animation.curAnim.name;

		/*if (PlayState.isPixelStage) {
			loadGraphic(Paths.image('pixelUI/' + texture));
			width = width / 4;
			height = height / 5;
			loadGraphic(Paths.image('pixelUI/' + texture), true, Math.floor(width), Math.floor(height));

			antialiasing = false;
			setGraphicSize(Std.int(width * PlayState.daPixelZoom));

			switch (Math.abs(noteData) % 4) {
				case 0:
					animation.add('static', [0]);
					animation.add('pressed', [4, 8], 12, false);
					animation.add('confirm', [12, 16], 24, false);
				case 1:
					animation.add('static', [1]);
					animation.add('pressed', [5, 9], 12, false);
					animation.add('confirm', [13, 17], 24, false);
				case 2:
					animation.add('static', [2]);
					animation.add('pressed', [6, 10], 12, false);
					animation.add('confirm', [14, 18], 12, false);
				case 3:
					animation.add('static', [3]);
					animation.add('pressed', [7, 11], 12, false);
					animation.add('confirm', [15, 19], 24, false);
			}
		} else {*/
			frames = Paths.getSparrowAtlas(texture);

			antialiasing = ClientPrefs.data.antialiasing;
			setGraphicSize(Std.int(width * 0.7));

			var dirs = ['left', 'down', 'up', 'right'][noteData % 4];
			animation.addByPrefix('static', "arrow" + dirs.toUpperCase(), 24, false);
			animation.addByPrefix('pressed', dirs + ' press', 24, false);
			animation.addByPrefix('confirm', dirs + ' confirm', 24, false);
		//}
		updateHitbox();

		if (lastAnim != null) {
			playAnim(lastAnim, true);
		}
	}

	public function postAddedToGroup() {
		playAnim('static');
		x += Note.swagWidth * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player);
		ID = noteData;
	}

	override function update(elapsed:Float) {
		if (resetAnim > 0) {
			resetAnim -= elapsed;
			if (resetAnim <= 0) {
				playAnim('static');
				resetAnim = 0;
			}
		}
		super.update(elapsed);
	}

	public function playAnim(anim:String, ?force:Bool = false) {
		animation.play(anim, force);
		if (animation.curAnim != null) {
			centerOffsets();
			centerOrigin();
		}
	}
}
