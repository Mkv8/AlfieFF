package substates;

import backend.WeekData;
import objects.Character;
import flixel.FlxObject;
import flixel.FlxSubState;
import states.StoryMenuState;
import states.FreeplayState;

class GameOverSubstate extends MusicBeatSubstate {
	var camFollow:FlxObject;
	var moveCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";

	public static var characterName:String = 'bf-dead';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';

	public static var instance:GameOverSubstate;

	public static function resetVariables() {
		characterName = 'bf-dead';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';

		var _song = PlayState.SONG;
		if (_song != null) {
			if (_song.gameOverChar != null && _song.gameOverChar.trim().length > 0)
				characterName = _song.gameOverChar;
			if (_song.gameOverSound != null && _song.gameOverSound.trim().length > 0)
				deathSoundName = _song.gameOverSound;
			if (_song.gameOverLoop != null && _song.gameOverLoop.trim().length > 0)
				loopSoundName = _song.gameOverLoop;
			if (_song.gameOverEnd != null && _song.gameOverEnd.trim().length > 0)
				endSoundName = _song.gameOverEnd;
		}
	}

	var charX:Float = 0;
	var charY:Float = 0;

	override function create() {
		instance = this;

		Conductor.songPosition = 0;

		FlxG.sound.play(Paths.sound(deathSoundName));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		PlayState.instance.setOnScripts('inGameOver', true);
		PlayState.instance.callOnScripts('onGameOverStart', []);

		super.create();
	}

	public var startedDeath:Bool = false;

	override function update(elapsed:Float) {
		super.update(elapsed);

		PlayState.instance.callOnScripts('onUpdate', [elapsed]);

		if (controls.ACCEPT) {
			endBullshit();
		}

		if (controls.BACK) {
			#if DISCORD_ALLOWED DiscordClient.resetClientID(); #end
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;

			Mods.loadTopMod();
			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new StoryMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			PlayState.instance.callOnScripts('onGameOverConfirm', [false]);
		}

		if (FlxG.sound.music.playing) {
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnScripts('onUpdatePost', [elapsed]);
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void {
		FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
	}

	function endBullshit():Void {
		if (isEnding) return;
		isEnding = true;
		FlxG.sound.music.stop();
		FlxG.sound.play(Paths.music(endSoundName));
		new FlxTimer().start(0.7, function(tmr:FlxTimer) {
			FlxG.camera.fade(FlxColor.BLACK, 2, false, function() {
				MusicBeatState.resetState();
			});
		});
		PlayState.instance.callOnScripts('onGameOverConfirm', [true]);
	}

	override function destroy() {
		instance = null;
		super.destroy();
	}
}
