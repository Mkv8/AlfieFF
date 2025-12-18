package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;
import objects.HealthIcon;
import objects.MusicPlayer;
import substates.GameplayChangersSubstate;
import substates.ResetScoreSubState;
import flixel.math.FlxMath;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class FreeplayState extends MusicBeatState {
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;

	private static var curSelected:Int = 0;

	var lerpSelected:Float = 0;
	var curDifficulty:Int = -1;

	private static var lastDifficultyName:String = Difficulty.getDefault();

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	var album:FlxSprite;
	var shader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.PostProcessing()),
	];

	/*var curveShader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.CurveShader()),
	];*/

	var curveShader = new shaders.CurveShader();

	private var grpSongs:FlxTypedGroup<FlxText>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxSprite;
	var borders:BGSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;

	var missingTextBG:FlxSolid;
	var missingText:FlxText;

	var bottomString:String;
	var bottomText:FlxText;
	var bottomBG:FlxSprite;

	var texts:Array<FlxText> = [];
	var albums:Array<String> = ['freaky4eva', 'ffNewMix', 'convictedLove', 'jammedCartridge', 'anemoia', 'punchBuggy', 'rooftopTalkshop', 'dreamcatcher', 'channelSurfers', 'eyeOfTheBeholder'];
	var albumpics:Array<FlxSprite> = [];

	var player:MusicPlayer;

	var radian = Math.PI/180;
	var radius:Float = 1000.0;
	var circlecenter:FlxPoint = new FlxPoint(FlxG.width/2, 1320);
	static var progamt = 0.0;

	var selectedAlbum:Item;
	var albumTimer:FlxTimer;

	var songText:FlxText;

	//THERES A CONCEPT PICTURE IN THE FILES ON /MENUASSETS
	//ALSO yellow text: #FF ffcf53 and outline border: #FF 770f0f

	override function create() {
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();


		persistentUpdate = true;

		WeekData.reloadWeekFiles(false);

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Choosing a song!", null);
		#end

		for (i in 0...WeekData.weeksList.length) {
			if (weekIsLocked(WeekData.weeksList[i]))
				continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length) {
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			for (song in leWeek.songs) {
				var colors:Array<Int> = song[2];
				if (colors == null || colors.length < 3) {
					colors = [146, 113, 253];
				}
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
			}
		}

		bg = new FlxSprite().loadGraphic(Paths.image('menuassets/songBG'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scale.set(0.8, 0.8);
		add(bg);
		bg.screenCenter(XY);

		setupAlbums();

		borders = new BGSprite('menuassets/bars', 0, 0, 0, 0);
		borders.updateHitbox();
		borders.alpha = 1;
		borders.scale.set(0.82,0.82);
		borders.screenCenter(XY);
		borders.antialiasing = ClientPrefs.data.antialiasing;
		add(borders);

		selectedAlbum = new Item(1750, -200);
		selectedAlbum.loadGraphic(Paths.image('albums/freaky4eva'));
		selectedAlbum.scale.set(0.4, 0.4);
		//add(selectedAlbum);

		grpSongs = new FlxTypedGroup<FlxText>();
		add(grpSongs);

		for (i in 0...songs.length) {
			songText = new FlxText(500 + (i*420), 630, songs[i].songName, 50);
			songText.setFormat(Paths.font("vcr.ttf"), 36, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			songText.borderColor = 0xFF3F0000;
			songText.borderSize = 3;
			grpSongs.add(songText);
			texts.push(songText);

			switch (i)
			{
				case 0: //freaky
				{
					    songText.offset.set(-30,0);
				}
				case 1: //ff
				{
					    songText.offset.set(-40,0);
				}
				case 4: //anemoia
				{
					    songText.offset.set(-80,0);
				}
				case 5: //punch buggy
				{
					    songText.offset.set(-20,0);
				}
				case 7: //ai song may have to change later
				{
					    songText.offset.set(-40,0);
				}
			}

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			songText.visible = songText.active;
			icon.visible = icon.active = false;
			iconArray.push(icon);

		//trace(Highscore.getScore(songs[i].songName, 0));
		}

		scoreText = new FlxText(0, 20, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, 0xFFffcf53, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		//scoreText.screenCenter(X);
		scoreText.borderColor = 0xFF3F0000;
		scoreText.borderSize = 3;
		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);

		missingTextBG = new FlxSolid().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
		missingTextBG.alpha = 0.6;
		missingTextBG.visible = false;
		add(missingTextBG);

		missingText = new FlxText(50, 0, FlxG.width - 100, '', 24);
		missingText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missingText.scrollFactor.set();
		missingText.visible = false;
		add(missingText);

		if (curSelected >= songs.length)
			curSelected = 0;
		//bg.color = songs[curSelected].color;
		//intendedColor = bg.color;
		lerpSelected = curSelected;

		curDifficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(lastDifficultyName)));

		bottomBG = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		bottomBG.alpha = 0.6;
		add(bottomBG);

		var leText:String = "Press SPACE to listen to the Song / Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		bottomString = leText;
		var size:Int = 16;
		bottomText = new FlxText(bottomBG.x, bottomBG.y + 4, FlxG.width, leText, size);
		bottomText.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, CENTER);
		bottomText.scrollFactor.set();
		add(bottomText);

		player = new MusicPlayer(this);
		add(player);


		bottomBG.visible = false; //IDK WHY BUT WHEN I TRIED TO COMMENT IT OUT OR JUST REMOVE THEM THE GAME CRASHED SO IM JUST MAKING THEM INVISIBLE INSTEAD ITS NOT A BIG DEAL
		bottomText.visible = false;
		scoreBG.visible = false;
		diffText.visible = false;

		var pressEnterText:FlxText;
		pressEnterText = new FlxText (0, FlxG.height - 30, FlxG.width, "Press ENTER to play a song!", 20);
		pressEnterText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER);
		pressEnterText.screenCenter(X);
		add(pressEnterText);

		var timer:FlxTimer;
		timer = new FlxTimer().start(3, function(tmr:FlxTimer)
		{FlxTween.tween(pressEnterText, {alpha: 0}, 4, {ease: FlxEase.quartInOut});}, 0);

		changeSelection();
		updateTexts();

		lockShitUp();
		for (i in 0...songs.length) {
		}

		super.create();
		if (ClientPrefs.data.shaders == true)
		{
		FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

		FlxG.camera.setFilters([new ShaderFilter(curveShader)]);
		FlxG.camera.filtersEnabled = true;

		curveShader.chromOff = 2;
		} else {FlxG.game.filtersEnabled = false; FlxG.camera.filtersEnabled = false;}
		
	}

	override function closeSubState() {
		if(!(subState is CustomFadeTransition))
			changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int) {
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0);
	}

	var instPlaying:Int = -1;

	public static var vocals:FlxSound = null;

	var holdTime:Float = 0;

	override function update(elapsed:Float) {
		if (FlxG.sound.music.volume < 0.7) {
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		lerpScore = Math.floor(FlxMath.lerp(intendedScore, lerpScore, Math.exp(-elapsed * 24)));
		lerpRating = FlxMath.lerp(intendedRating, lerpRating, Math.exp(-elapsed * 12));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(CoolUtil.floorDecimal(lerpRating * 100, 2)).split('.');
		if (ratingSplit.length < 2) { // No decimals, add an empty space
			ratingSplit.push('');
		}

		while (ratingSplit[1].length < 2) { // Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		var shiftMult:Int = 1;
		if (FlxG.keys.pressed.SHIFT)
			shiftMult = 3;

		if (!player.playingMusic) {
			scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
			positionHighscore();

			if (songs.length > 1) {
				if (FlxG.keys.justPressed.HOME) {
					curSelected = 0;
					changeSelection();
					holdTime = 0;
				} else if (FlxG.keys.justPressed.END) {
					curSelected = songs.length - 1;
					changeSelection();
					holdTime = 0;
				}
				if (controls.UI_LEFT_P) {
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (controls.UI_RIGHT_P) {
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if (controls.UI_LEFT || controls.UI_RIGHT) {
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if (holdTime > 0.5 && checkNewHold - checkLastHold > 0)
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_LEFT ? -shiftMult : shiftMult));
				}

				if (FlxG.mouse.wheel != 0) {
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
					changeSelection(-shiftMult * FlxG.mouse.wheel, false);
				}
			}

			if (controls.UI_LEFT_P) {
				changeDiff(-1);
				_updateSongLastDifficulty();
			} else if (controls.UI_RIGHT_P) {
				changeDiff(1);
				_updateSongLastDifficulty();
			}
		}

		if (controls.BACK) {
			if (player.playingMusic) {
				FlxG.sound.music.stop();
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;
				instPlaying = -1;

				player.playingMusic = false;
				player.switchPlayMusic();

				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
				FlxTween.tween(FlxG.sound.music, {
					volume: 1
				}, 1);
			} else {
				persistentUpdate = false;
				if (colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
		}

		if (FlxG.keys.justPressed.CONTROL && !player.playingMusic) {
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		} else if (FlxG.keys.justPressed.SPACE) {
			if (instPlaying != curSelected && !player.playingMusic) {
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;

				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				if (PlayState.SONG.needsVoices) {
					vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
					FlxG.sound.list.add(vocals);
					vocals.persist = true;
					vocals.looped = true;
				} else if (vocals != null) {
					vocals.stop();
					vocals.destroy();
					vocals = null;
				}

				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.8);
				if (vocals != null) // Sync vocals to Inst
				{
					vocals.play();
					vocals.volume = 0.8;
				}
				instPlaying = curSelected;

				player.playingMusic = true;
				player.curTime = 0;
				player.switchPlayMusic();
			} else if (instPlaying == curSelected && player.playingMusic) {
				player.pauseOrResume(player.paused);
			}
		} else if (controls.ACCEPT && !player.playingMusic) {
			persistentUpdate = false;
			var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			var poop:String = Highscore.formatSong(songLowercase, curDifficulty);

			try {
				PlayState.SONG = Song.loadFromJson(poop, songLowercase);
				PlayState.storyDifficulty = curDifficulty;

				trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
				if (colorTween != null) {
					colorTween.cancel();
				}
			} catch (e:Dynamic) {
				trace('ERROR! $e');

				var errorStr:String = e.toString();
				if (errorStr.startsWith('[file_contents,assets/data/'))
					errorStr = 'Missing file: ' + errorStr.substring(34, errorStr.length - 1); // Missing chart
				missingText.text = 'ERROR WHILE LOADING CHART:\n$errorStr';
				missingText.screenCenter(Y);
				missingText.visible = true;
				missingTextBG.visible = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));

				updateTexts(elapsed);
				super.update(elapsed);
				return;
			}


			switch(curSelected)
			{
			case 7:
				{
				AiComic.itsgivingendcard = false;
				LoadingState.loadAndSwitchState(new AiComic());
				}

			default:
				{
				LoadingState.loadAndSwitchState(new PlayState());
				}
			}


			FlxG.sound.music.volume = 0;

			destroyFreeplayVocals();
		} else if (controls.RESET && !player.playingMusic) {
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		updateTexts(elapsed);
		super.update(elapsed);
	}

	public static function destroyFreeplayVocals() {
		if (vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0) {
		if (player.playingMusic)
			return;

		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = Difficulty.list.length - 1;
		if (curDifficulty >= Difficulty.list.length)
			curDifficulty = 0;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		lastDifficultyName = Difficulty.getString(curDifficulty);
		if (Difficulty.list.length > 1)
			diffText.text = '< ' + lastDifficultyName.toUpperCase() + ' >';
		else
			diffText.text = lastDifficultyName.toUpperCase();

		positionHighscore();
		missingText.visible = false;
		missingTextBG.visible = false;
	}

	function changeSelection(change:Int = 0, playSound:Bool = true) {
		if (player.playingMusic)
			return;

		_updateSongLastDifficulty();
		if (playSound)
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		var lastList:Array<String> = Difficulty.list;
		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		if (change == -1)
		{
			progamt += 360/albums.length;
		}
		if (change == 1)
		{
			progamt -= 360/albums.length;
		}

		var bullShit:Int = 0;

		for (i in 0...iconArray.length) {
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members) {
			bullShit++;
			item.alpha = 0.6;
			//if (item.targetY == curSelected)
				item.alpha = 1;
		}

		PlayState.storyWeek = songs[curSelected].week;
		Difficulty.loadFromWeek();

		var savedDiff:String = songs[curSelected].lastDifficulty;
		var lastDiff:Int = Difficulty.list.indexOf(lastDifficultyName);
		if (savedDiff != null && !lastList.contains(savedDiff) && Difficulty.list.contains(savedDiff))
			curDifficulty = Math.round(Math.max(0, Difficulty.list.indexOf(savedDiff)));
		else if (lastDiff > -1)
			curDifficulty = lastDiff;
		else if (Difficulty.list.contains(Difficulty.getDefault()))
			curDifficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(Difficulty.getDefault())));
		else
			curDifficulty = 0;

		changeDiff();
		_updateSongLastDifficulty();


	}

	inline private function _updateSongLastDifficulty() {
		songs[curSelected].lastDifficulty = Difficulty.getString(curDifficulty);
	}

	private function positionHighscore() {
		scoreText.x = 900 - scoreText.width - 6;
		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
		diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
		diffText.x -= diffText.width / 2;
	}

	var _drawDistance:Int = 4;
	var _lastVisibles:Array<Int> = [];

	public function updateTexts(elapsed:Float = 0.0) {
		lerpSelected = FlxMath.lerp(curSelected, lerpSelected, Math.exp(-elapsed * 9.6));
		for (i in _lastVisibles) {
			grpSongs.members[i].visible = grpSongs.members[i].active = false;
			iconArray[i].visible = iconArray[i].active = false;
		}
		_lastVisibles = [];

		var min:Int = Math.round(Math.max(0, Math.min(songs.length, lerpSelected - _drawDistance)));
		var max:Int = Math.round(Math.max(0, Math.min(songs.length, lerpSelected + _drawDistance)));
		var lerpVal:Float = Math.exp(-elapsed * 10);

		for (e in 0...texts.length) {
            var i = texts[e];
            //var item:FlxText = grpSongs.members[i];
            i.scale.set(
                FlxMath.lerp(i == texts[curSelected] ? 1.20:0.85, i.scale.x, lerpVal),
                FlxMath.lerp(i == texts[curSelected] ? 1.20:0.85, i.scale.y, lerpVal)
            );
            i.alpha = FlxMath.lerp(i == texts[curSelected] ? 1: 0.4, i.alpha, lerpVal);

            var xlerpto = 480 + ((e-curSelected)*420);
            i.x = FlxMath.lerp(xlerpto, i.x, lerpVal);


        }

		for (i in 0...albumpics.length)
		{
			var pic = albumpics[i];
			var degreeprog = ((360/albumpics.length) * i) + progamt;
			var picsin = Math.sin((degreeprog*radian) + Math.PI*3/2);
			var piccos = Math.cos((degreeprog*radian) + Math.PI*3/2);

			//pic.x = circlecenter.x + (radius*piccos) - (pic.width/2);
			//pic.y = circlecenter.y + (radius*picsin) - (pic.height/2);
			var picxlerpto = circlecenter.x + (radius*piccos) - (pic.width/2);
			pic.x = FlxMath.lerp(picxlerpto, pic.x, lerpVal);

			var picylerpto = circlecenter.y + (radius*picsin) - (pic.height/2);
			pic.y = FlxMath.lerp(picylerpto, pic.y, lerpVal);

			var dx = circlecenter.x - (pic.x + pic.width / 2);
			var dy = circlecenter.y - (pic.y + pic.height / 2);
			pic.angle = (Math.atan2(dy, dx) * 180/Math.PI + 90) + 180;


		}


	}

	function setupAlbums()
	{
		for (i in 0...albums.length) {
			album = new FlxSprite().loadGraphic('assets/shared/images/albums/' + albums[i] + '.png');
			add(album);

			album.scale.x *= 0.35;
			album.scale.y *= 0.35;

			album.updateHitbox();
			album.screenCenter();
			albumpics.push(album);

			album.alpha = 1;


		}


	}

	function lockShitUp()
	{
		for (i in 0...songs.length) {
			if (Highscore.getScore(songs[i].songName, 0) == 0)
			{
				texts[i].text = '???';
				texts[i].offset.set(-120,0);
			}
		}
		for (i in 0... albums.length) {
			if (Highscore.getScore(songs[i].songName, 0) == 0)
			{
				albumpics[i].color = FlxColor.BLACK;
			}
		}
	}


	override function destroy():Void {
		super.destroy();

		FlxG.autoPause = ClientPrefs.data.autoPause;
		if (!FlxG.sound.music.playing)
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
	}
}

class SongMetadata {
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";
	public var lastDifficulty:String = null;

	public function new(song:String, week:Int, songCharacter:String, color:Int) {
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		if (this.folder == null)
			this.folder = '';
	}
}

class Item extends FlxSprite {
    public var initialX:Float;
    public var initialY:Float;

    public function new(x:Float, y:Float) {
        initialY = y;
        initialX = x;
        super(x, y);

		antialiasing = true;
    }
}
