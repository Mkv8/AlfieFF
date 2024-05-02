package states;

import objects.AttachedSprite;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

class CreditsState extends MusicBeatState {
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:FlxColor;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	var shader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.PostProcessing()),
		new ShaderFilter(new shaders.ChromUwU())
	];

	override function create() {
		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Checking the credits!", null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('mainMenu'));
		bg.scale.set(0.67, 0.67);
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg);
		bg.screenCenter();

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		for (mod in Mods.parseList().enabled)
			pushModCreditsToList(mod);
		#end

		var defaultList:Array<Array<String>> = [
			// Name - Icon name - Description - Link - BG Color
			['Mod Creators!!'],
			[
				'Mk',
				'mk',
				'Programmer, artist and Alfies creator',
				'https://twitter.com/Mkv8Art',
				'F7AC41'
			],
			[
				'Gigab00ts',
				'giga',
				'Creator of Kisston (and made some concept art!!)',
				'https://twitter.com/GigaB00ts',
				'F74141'
			],
			[
				'Ne_Eo',
				'neo',
				'super programmer extraordinaire',
				'https://twitter.com/Ne_Eo_Twitch',
				'A66B89'
			],
			[
				'SplatterDash',
				'splatt',
				'Musician for Forest Fire (New Mix)',
				'https://twitter.com/splatterdash_ng',
				'72B2F2'
			],
			[
				'Tailer',
				'tailer',
				'Musician for Convicted Love',
				'https://twitter.com/tailer4440',
				'FFB14E'
			],
			[
				'ChubbyGamer',
				'chubby',
				'Charter for Forest Fire (New Mix)',
				'https://twitter.com/ChubbyAlt',
				'C78A58'
			],
			[
				'Pavlikos',
				'pav',
				'Charter for Convicted Love',
				'https://twitter.com/ppavlikoss',
				'BAE2FF'
			],
			[''],
			['Special Thanks'],
			['Tantalun', 'blank', 'Coding help/advice', null, '2C55C4'],
			['coquers_', 'blank', 'Helped compose Convicted Love', null, '2C55C4'],
			[
				'Past members of vs Alfie',
				'blank',
				'Thank you for all the help and support <3',
				null,
				'2C55C4'
			],
			[
				'Content creators',
				'blank',
				'For playing all the Vs Alfie mods!',
				null,
				'2C55C4'
			],
			['matthiasDoes', 'blank', 'great entertainer he is.', null, '2C55C4'],
			['Alfie', 'blank', 'for singing the song :)', null, '2C55C4'],
			['Kisston', 'blank', 'for singing the other song :3', null, '2C55C4'],
			['boyfriend', 'blank', 'bee bo o bab bbooo beee booop beeb', null, '2C55C4'],
			['girlfriend', 'blank', 'for gatekeeping girlbossing gaslighting', null, '2C55C4'],
			['Filip, Kai and Ace', 'blank', 'for standing in the background', null, '2C55C4'],
			['that one guy', 'blank', 'you know who you are, thanks bro', null, '2C55C4'],
			['You', 'blank', 'for playing the mod!', null, '2C55C4'],
			['your mom', 'blank', 'for last night ;)', null, '2C55C4'],
			['sailor moon', 'blank', 'anime', null, '2C55C4'],
			[
				'dad',
				'blank',
				'thanks dad when are you coming back from the store please i miss you a lot',
				null,
				'2C55C4'
			],
			['what would you do', 'blank', 'if you won half a car twice?', null, '2C55C4'],
			[
				'what about a penny',
				'blank',
				'that doubles in size once a day everyday??',
				null,
				'2C55C4'
			],
			['no one', 'blank', 'no thanks for you', null, '2C55C4'],
			['why', 'blank', 'why is this menu still going', null, '2C55C4'],
			['why are you still here', 'blank', 'is this entertaining you??', null, '2C55C4'],
			[''],

		];

		for (i in defaultList) {
			creditsStuff.push(i);
		}

		for (i in 0...creditsStuff.length) {
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(FlxG.width / 2, 300, creditsStuff[i][0], !isSelectable);
			optionText.isMenuItem = true;
			optionText.targetY = i;
			optionText.changeX = false;
			optionText.snapToPosition();
			grpOptions.add(optionText);

			if (isSelectable) {
				if (creditsStuff[i][5] != null) {
					Mods.currentModDirectory = creditsStuff[i][5];
				}

				var str:String = 'credits/missing_icon';
				if (creditsStuff[i][1] != null && creditsStuff[i][1].length > 0) {
					var fileName = 'credits/' + creditsStuff[i][1];
					if (Paths.fileExists('images/$fileName.png', IMAGE))
						str = fileName;
					else if (Paths.fileExists('images/$fileName-pixel.png', IMAGE))
						str = fileName + '-pixel';
				}

				var icon:AttachedSprite = new AttachedSprite(str);
				if (str.endsWith('-pixel'))
					icon.antialiasing = false;
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;

				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Mods.currentModDirectory = '';

				if (curSelected == -1)
					curSelected = i;
			} else
				optionText.alignment = CENTERED;
		}

		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER /*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		// descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		//bg.color = CoolUtil.colorFromString(creditsStuff[curSelected][4]);
		//intendedColor = bg.color;
		changeSelection();
		
		FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;

	override function update(elapsed:Float) {
		if (FlxG.sound.music.volume < 0.7) {
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!quitting) {
			if (creditsStuff.length > 1) {
				var shiftMult:Int = 1;
				if (FlxG.keys.pressed.SHIFT)
					shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP) {
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (downP) {
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if (controls.UI_DOWN || controls.UI_UP) {
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if (holdTime > 0.5 && checkNewHold - checkLastHold > 0) {
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			if (controls.ACCEPT && (creditsStuff[curSelected][3] == null || creditsStuff[curSelected][3].length > 4)) {
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			}
			if (controls.BACK) {
				if (colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}

		for (item in grpOptions.members) {
			if (!item.bold) {
				var lerpVal:Float = Math.exp(-elapsed * 12);
				if (item.targetY == 0) {
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(item.x - 70, lastX, lerpVal);
				} else {
					item.x = FlxMath.lerp(200 + -40 * Math.abs(item.targetY), item.x, lerpVal);
				}
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;

	function changeSelection(change:Int = 0) {
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while (unselectableCheck(curSelected));

		/*var newColor:FlxColor = CoolUtil.colorFromString(creditsStuff[curSelected][4]);
		// trace('The BG color is: $newColor');
		if (newColor != intendedColor) {
			if (colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}*/

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			if (!unselectableCheck(bullShit - 1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		descText.y = FlxG.height - descText.height + offsetThing - 60;

		if (moveTween != null)
			moveTween.cancel();
		moveTween = FlxTween.tween(descText, {
			y: descText.y + 75
		}, 0.25, {
			ease: FlxEase.sineOut
		});

		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	#if MODS_ALLOWED
	function pushModCreditsToList(folder:String) {
		var creditsFile:String = null;
		if (folder != null && folder.trim().length > 0)
			creditsFile = Paths.mods(folder + '/data/credits.txt');
		else
			creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile)) {
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for (i in firstarray) {
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if (arr.length >= 5)
					arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
	}
	#end

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
