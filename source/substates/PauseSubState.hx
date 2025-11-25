package substates;

import backend.WeekData;
import backend.Highscore;
import backend.Song;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxStringUtil;
import states.FreeplayState;
import options.OptionsState;

class PauseSubState extends MusicBeatSubstate {
	var menuItems:Array<String> = [];
	var menuItemsOG:Array<String> = ['Resume', 'Restart Song', 'Change Difficulty', 'Options', 'Exit to menu'];
	var difficultyChoices = [];
	var curSelected:Int = 0;

	var charRender:Item;
	var noise:BGSprite;
	var pausedButton:BGSprite;

	var texts:Array<FlxText> = [];

	var pauseSongs:String = 'pauseAlfie';
	var pauseMusic:FlxSound;
	var practiceText:FlxText;
	var skipTimeText:FlxText;
	var skipTimeTracker:Alphabet;
	var curTime:Float = Math.max(0, Conductor.songPosition);

	var missingTextBG:FlxSprite;
	var missingText:FlxText;

	public static var songName:String = null;

	override function create() {
		if (Difficulty.list.length < 2)
			menuItemsOG.remove('Change Difficulty'); // No need to change difficulty if there is only one!

		if (PlayState.chartingMode) {
			menuItemsOG.insert(2, 'Leave Charting Mode');

			var num:Int = 0;
			if (!PlayState.instance.startingSong) {
				num = 1;
				menuItemsOG.insert(3, 'Skip Time');
			}
			menuItemsOG.insert(3 + num, 'End Song');
			menuItemsOG.insert(4 + num, 'Toggle Practice Mode');
			menuItemsOG.insert(5 + num, 'Toggle Botplay');
		}
		menuItems = menuItemsOG;

		for (i in 0...Difficulty.list.length) {
			var diff:String = Difficulty.getString(i);
			difficultyChoices.push(diff);
		}
		difficultyChoices.push('BACK');

		var bg:FlxSprite = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		bg.scale.set(FlxG.width, FlxG.height);
		bg.updateHitbox();
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		noise = new BGSprite('miku/noises', 0, 0, 1, 1, ['noises'], true);
		noise.updateHitbox();
		noise.alpha = 0;
		noise.antialiasing = ClientPrefs.data.antialiasing;
		noise.animation.play('noises', true, false);
		noise.scale.set(1, 1);
		add(noise);

		charRender = new Item(320, -200);
		charRender.updateHitbox();
		charRender.alpha = 0;
		charRender.scale.set(0.5, 0.5);
		charRender.antialiasing = ClientPrefs.data.antialiasing;
		add(charRender);

		pausedButton = new BGSprite('pause', FlxG.width - 480, 0, 1, 1, ['pause'], true);
		pausedButton.updateHitbox();
		pausedButton.alpha = 0;
		pausedButton.antialiasing = ClientPrefs.data.antialiasing;
		pausedButton.animation.play('pause', true, false);
		pausedButton.scale.set(1, 1);
		add(pausedButton);

		var levelInfo:FlxText = new FlxText(20, 15, 0, PlayState.SONG.song, 32);
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		levelInfo.color = 0xFF40FF1A;
		add(levelInfo);

		var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, Difficulty.getString().toUpperCase(), 32);
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		levelDifficulty.color = 0xFF40FF1A;
		add(levelDifficulty);

		var blueballedTxt:FlxText = new FlxText(20, 15 + 64, 0, "Blueballed: " + PlayState.deathCounter, 32);
		blueballedTxt.scrollFactor.set();
		blueballedTxt.setFormat(Paths.font('vcr.ttf'), 32);
		blueballedTxt.updateHitbox();
		blueballedTxt.color = 0xFF40FF1A;
		add(blueballedTxt);

		practiceText = new FlxText(20, 15 + 101, 0, "PRACTICE MODE", 32);
		practiceText.scrollFactor.set();
		practiceText.setFormat(Paths.font('vcr.ttf'), 32);
		practiceText.x = FlxG.width - (practiceText.width + 20);
		practiceText.updateHitbox();
		practiceText.color = 0xFF40FF1A;
		practiceText.visible = PlayState.instance.practiceMode;
		add(practiceText);

		var chartingText:FlxText = new FlxText(20, 15 + 101, 0, "CHARTING MODE", 32);
		chartingText.scrollFactor.set();
		chartingText.setFormat(Paths.font('vcr.ttf'), 32);
		chartingText.x = FlxG.width - (chartingText.width + 20);
		chartingText.y = FlxG.height - (chartingText.height + 20);
		chartingText.updateHitbox();
		chartingText.visible = PlayState.chartingMode;
		chartingText.color = 0xFF40FF1A;
		add(chartingText);

		blueballedTxt.alpha = 0;
		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);
		blueballedTxt.x = FlxG.width - (blueballedTxt.width + 20);

		FlxTween.tween(bg, {
			alpha: 0.6
		}, 0.4, {
			ease: FlxEase.quartInOut
		});
		FlxTween.tween(noise, {
			alpha: 0.3
		}, 0.4, {
			ease: FlxEase.quartInOut
		});
		FlxTween.tween(pausedButton, {
			alpha: 1,
			y: 25
		}, 0.4, {
			ease: FlxEase.quartInOut,
			startDelay: 0.2
		});
		FlxTween.tween(levelInfo, {
			alpha: 1,
			y: 20
		}, 0.4, {
			ease: FlxEase.quartInOut,
			startDelay: 0.3
		});
		FlxTween.tween(levelDifficulty, {
			alpha: 1,
			y: levelDifficulty.y + 5
		}, 0.4, {
			ease: FlxEase.quartInOut,
			startDelay: 0.5
		});
		FlxTween.tween(blueballedTxt, {
			alpha: 1,
			y: blueballedTxt.y + 5
		}, 0.4, {
			ease: FlxEase.quartInOut,
			startDelay: 0.7
		});

		//region Render positions
		var songie = PlayState.SONG.song;
		var assets = getPauseAsset(songie);
		charRender.loadGraphic(Paths.image(assets[1]));
		pauseSongs = assets[0];
		switch(songie)
		{
			case 'Freaky 4eva': //done
				{
				charRender.scale.set(0.5, 0.5);
				charRender.x = 380;
				charRender.y = -460;
				FlxTween.tween(charRender, {
					alpha: 1,
					x: 260
				}, 0.8, {
					ease: FlxEase.quartInOut,
					startDelay: 1
				});
				}
			case 'Forest Fire': //done
				{
				charRender.scale.set(0.5, 0.5);
				charRender.x = 320;
				charRender.y = -280;
				FlxTween.tween(charRender, {
					alpha: 1,
					x: 200
				}, 0.8, {
					ease: FlxEase.quartInOut,
					startDelay: 1
				});
				}

			case 'Convicted Love': //done
				{
				charRender.x = 430;
				charRender.y = -240;
				charRender.scale.set(0.5, 0.5);
				FlxTween.tween(charRender, {
					alpha: 1,
					x: 310
				}, 0.8, {
					ease: FlxEase.quartInOut,
					startDelay: 1
				});
				}

			case 'Jammed Cartridge': //done
				{
				charRender.x = 700;
				charRender.y = -0;
				charRender.scale.set(0.7, 0.7);
				FlxTween.tween(charRender, {
					alpha: 1,
					x: 580
				}, 0.8, {
					ease: FlxEase.quartInOut,
					startDelay: 1
				});
				}
			case 'Anemoia':
				{
				charRender.x = 350;
				charRender.flipX = true;
				charRender.y = -430;
				charRender.scale.set(0.4, 0.4);
				FlxTween.tween(charRender, {
					alpha: 1,
					x: 230
				}, 0.8, {
					ease: FlxEase.quartInOut,
					startDelay: 1
				});
				}
			case 'PUNCH BUGGY!!!':
				{
				charRender.x = 250;
				charRender.y = -340;
				charRender.scale.set(0.48, 0.48);
				FlxTween.tween(charRender, {
					alpha: 1,
					x: 130
				}, 0.8, {
					ease: FlxEase.quartInOut,
					startDelay: 1
				});
				}
			case 'Rooftop Talkshop': //done
				{
				charRender.x = 720;
				charRender.y = -250;
				charRender.scale.set(0.6, 0.6);
				FlxTween.tween(charRender, {
					alpha: 1,
					x: 600
				}, 0.8, {
					ease: FlxEase.quartInOut,
					startDelay: 1
				});
				}
			case 'aiSong':
				{
				charRender.x = 630;
				charRender.y = -130;
				charRender.scale.set(0.55, 0.55);
				FlxTween.tween(charRender, {
					alpha: 1,
					x: 510
				}, 0.8, {
					ease: FlxEase.quartInOut,
					startDelay: 1
				});
				}
			case 'Channel Surfers': //done
				{
				charRender.x = 500;
				charRender.y = -280;
				charRender.scale.set(0.5, 0.5);
				FlxTween.tween(charRender, {
					alpha: 1,
					x: 380
				}, 0.8, {
					ease: FlxEase.quartInOut,
					startDelay: 1
				});
				}
			case 'Eye of the Beholder': //done
				{
				charRender.x = 600;
				charRender.y = -350;
				charRender.scale.set(0.5, 0.5);
				FlxTween.tween(charRender, {
					alpha: 1,
					x: 480
				}, 0.8, {
					ease: FlxEase.quartInOut,
					startDelay: 1
				});
				}
		}

		// endregion

		pauseMusic = new FlxSound();
		try {
			var pauseSong:String = getPauseSong();
			if (pauseSong != null)
				pauseMusic.loadEmbedded(Paths.music(pauseSongs), true, true);
		} catch (e:Dynamic) {
		}
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);


		for (i in 0...menuItems.length)
		{
			var txt:FlxText = new FlxText(40, 80 + (i*60), 0, menuItems[i] , 696969);
			txt.setFormat(Paths.font("vcr.ttf"), 56, 0xFF40FF1A, LEFT);
			txt.scrollFactor.set();
			//txt.screenCenter();
			//txt.y += (100 * (i - (menuItems.length / 2))) + 50;
			add(txt);
			texts.push(txt);
		}

		missingTextBG = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		missingTextBG.scale.set(FlxG.width, FlxG.height);
		missingTextBG.updateHitbox();
		missingTextBG.alpha = 0.6;
		missingTextBG.visible = false;
		add(missingTextBG);

		missingText = new FlxText(50, 0, FlxG.width - 100, '', 24);
		missingText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missingText.scrollFactor.set();
		missingText.visible = false;
		add(missingText);

		regenMenu();
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

		super.create();
	}

	function getPauseSong() {
		var formattedSongName:String = (songName != null ? Paths.formatToSongPath(songName) : '');
		var formattedPauseMusic:String = Paths.formatToSongPath(pauseSongs);
		if (formattedSongName == 'none' || (formattedSongName != 'none' && formattedPauseMusic == 'none'))
			return null;

		return (formattedSongName != '') ? formattedSongName : formattedPauseMusic;
	}

	var holdTime:Float = 0;
	var cantUnpause:Float = 0.1;

	override function update(elapsed:Float) {
		cantUnpause -= elapsed;
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		if (controls.BACK) {
			close();
			return;
		}

		updateSkipTextStuff();
		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
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

		var daSelected:String = menuItems[curSelected];
		switch (daSelected) {
			case 'Skip Time':
				if (controls.UI_LEFT_P) {
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					curTime -= 1000;
					holdTime = 0;
				}
				if (controls.UI_RIGHT_P) {
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					curTime += 1000;
					holdTime = 0;
				}

				if (controls.UI_LEFT || controls.UI_RIGHT) {
					holdTime += elapsed;
					if (holdTime > 0.5) {
						curTime += 45000 * elapsed * (controls.UI_LEFT ? -1 : 1);
					}

					if (curTime >= FlxG.sound.music.length)
						curTime -= FlxG.sound.music.length;
					else if (curTime < 0)
						curTime += FlxG.sound.music.length;
					updateSkipTimeText();
				}
		}

		if (controls.ACCEPT && (cantUnpause <= 0 || !controls.controllerMode)) {
			if (menuItems == difficultyChoices) {
				try {
					if (menuItems.length - 1 != curSelected && difficultyChoices.contains(daSelected)) {
						var name:String = PlayState.SONG.song;
						var poop = Highscore.formatSong(name, curSelected);
						PlayState.SONG = Song.loadFromJson(poop, name);
						PlayState.storyDifficulty = curSelected;
						MusicBeatState.resetState();
						FlxG.sound.music.volume = 0;
						PlayState.changedDifficulty = true;
						PlayState.chartingMode = false;
						return;
					}
				} catch (e:Dynamic) {
					trace('ERROR! $e');

					var errorStr:String = e.toString();
					if (errorStr.startsWith('[file_contents,assets/data/'))
						errorStr = 'Missing file: ' + errorStr.substring(27, errorStr.length - 1); // Missing chart
					missingText.text = 'ERROR WHILE LOADING CHART:\n$errorStr';
					missingText.screenCenter(Y);
					missingText.visible = true;
					missingTextBG.visible = true;
					FlxG.sound.play(Paths.sound('cancelMenu'));

					super.update(elapsed);
					return;
				}

				menuItems = menuItemsOG;
				regenMenu();
			}

			switch (daSelected) {
				case "Resume":
					close();
				case 'Change Difficulty':
					menuItems = difficultyChoices;
					deleteSkipTimeText();
					regenMenu();
				case 'Toggle Practice Mode':
					PlayState.instance.practiceMode = !PlayState.instance.practiceMode;
					PlayState.changedDifficulty = true;
					practiceText.visible = PlayState.instance.practiceMode;
				case "Restart Song":
					restartSong();
				case "Leave Charting Mode":
					restartSong();
					PlayState.chartingMode = false;
				case 'Skip Time':
					if (curTime < Conductor.songPosition) {
						PlayState.startOnTime = curTime;
						restartSong(true);
					} else {
						if (curTime != Conductor.songPosition) {
							PlayState.instance.clearNotesBefore(curTime);
							PlayState.instance.setSongTime(curTime);
						}
						close();
					}
				case 'End Song':
					close();
					//PlayState.instance.notes.clear();
					//PlayState.instance.unspawnNotes = [];
					PlayState.instance.KillNotes();
					PlayState.instance.finishSong(true);
				case 'Toggle Botplay':
					PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
					PlayState.changedDifficulty = true;
					PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
					PlayState.instance.botplayTxt.alpha = 1;
					PlayState.instance.botplaySine = 0;
				case 'Options':
					PlayState.instance.paused = true; // For lua
					PlayState.instance.vocals.volume = 0;
					MusicBeatState.switchState(new OptionsState());
					//if (ClientPrefs.data.pauseMusic != 'None') {
						//FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)), pauseMusic.volume);
						FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(pauseSongs)), pauseMusic.volume);
						FlxTween.tween(FlxG.sound.music, {
							volume: 1
						}, 0.8);
						FlxG.sound.music.time = pauseMusic.time;
					//}
					OptionsState.onPlayState = true;
				case "Exit to menu":
					#if DISCORD_ALLOWED DiscordClient.resetClientID(); #end
					PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;

					MusicBeatState.switchState(new FreeplayState());

					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					PlayState.changedDifficulty = false;
					PlayState.chartingMode = false;
					FlxG.camera.followLerp = 0;
			}
		}
	}

	function deleteSkipTimeText() {
		if (skipTimeText != null) {
			skipTimeText.kill();
			remove(skipTimeText);
			skipTimeText.destroy();
		}
		skipTimeText = null;
		skipTimeTracker = null;
	}

	public static function restartSong(noTrans:Bool = false) {
		PlayState.instance.paused = true; // For lua
		FlxG.sound.music.volume = 0;
		PlayState.instance.vocals.volume = 0;

		if (noTrans) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
		}
		MusicBeatState.resetState();
	}

	override function destroy() {
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void {
		curSelected += change;

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;
		missingText.visible = false;
		missingTextBG.visible = false;
	}

	function regenMenu():Void {
		for (i in 0...menuItems.length) {
            if (menuItems[i] == 'Skip Time') {
                var item = new Alphabet(90, 320, menuItems[i], true);
                item.isMenuItem = true;
                item.targetY = i;
                item.visible = false;

				skipTimeText = new FlxText(0, 0, 0, '', 64);
				skipTimeText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				skipTimeText.scrollFactor.set();
				skipTimeText.borderSize = 2;
				skipTimeTracker = item;
				add(skipTimeText);

				updateSkipTextStuff();
				updateSkipTimeText();
			}
		}
		curSelected = 0;
		changeSelection();
	}

	public static function getPauseAsset(songName:String):Array<String> {
	// basically first is pause name and other is imagfe

	switch(songName) {
		case 'Freaky 4eva':
			return ['pauseBF', 'RENDERS/BFMSRenderAlt'];

		case 'Forest Fire':
			return ['pauseAlfie', 'RENDERS/AlfieMSRender'];

		case 'Convicted Love':
			return ['pauseKisston', 'RENDERS/KisstonMSRender'];

		case 'Jammed Cartridge':
			return ['pauseKai', 'RENDERS/KaiMSRender'];

		case 'Anemoia':
			return ['pauseKai', 'RENDERS/KaiMSRenderAlt'];

		case 'PUNCH BUGGY!!!':
			return ['pauseFilip', 'RENDERS/FilipMSRender'];

		case 'Rooftop Talkshop':
			return ['pauseNikku', 'RENDERS/NikkuMSRender'];

		case 'aiSong':
			return ['pauseAi', 'RENDERS/AiMSRenderAlt'];

		case 'Channel Surfers':
			return ['pauseMiku', 'RENDERS/MikuMSRender'];

		case 'Eye of the Beholder':
			return ['pauseMinus', 'RENDERS/minusMSRender'];

		default:
			return ['pauseAlfie', 'RENDERS/AlfieMSRender'];
		}
	}

	function updateSkipTextStuff() {
		if (skipTimeText == null || skipTimeTracker == null)
			return;

		skipTimeText.x = skipTimeTracker.x + skipTimeTracker.width + 60;
		skipTimeText.y = skipTimeTracker.y;
		skipTimeText.visible = (skipTimeTracker.alpha >= 1);
	}

	function updateSkipTimeText() {
		skipTimeText.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false)
			+ ' / '
			+ FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
	}
}
