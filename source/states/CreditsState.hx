package states;

import flixel.input.gamepad.mappings.SwitchJoyconRightMapping;
import objects.AttachedSprite;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

class CreditsState extends MusicBeatState {
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var leftSparkles:BGSprite;
	var rightSparkles:BGSprite;
	var moon:BGSprite;
	var leftArrow:BGSprite;
	var rightArrow:BGSprite;
	var descText:FlxText;
	var intendedColor:FlxColor;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;


	var shader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.PostProcessing()),
	];

	/*var curveShader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.CurveShader()),
	];*/

	//REMINDER THAT THERES A CONCEPT PICTURE ON THE MENU ASSETS FOLDER
	//For this menu, people are displayed vertically and when you press up and down it swaps between them (just like the original menu!)
	//When someone is highlighted/selected, their icon and name tweens to the left and it displays a message
	//Pressing left and right changes categories... categories are: ARTISTS - CODERS - MUSICIANS - CHARTERS - EXTRA HELP & SPECIAL THANKS
	//I set all the icons as mk for now but i can change them later, theyre already in the tiles
	//IDK WHAT BUTTON TO MAKE THE CREDITS VIDEO PLAY, the credits video itself is done its "CreditsFilter" in the files

	var curveShader = new shaders.CurveShader();

	override function create() {
		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Checking the credits!", null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuassets/creditsbg'));
		bg.scale.set(0.8, 0.8);
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg);
		bg.screenCenter();

		leftSparkles = new BGSprite('menuassets/creditssparkles', 30, 30, 0, 0, ['sparkles'], true);
		leftSparkles.updateHitbox();
		leftSparkles.alpha = 1;
		leftSparkles.scale.set(0.8,0.8);
		leftSparkles.animation.play('sparkles', true, false);
		leftSparkles.flipX = true;
		leftSparkles.antialiasing = ClientPrefs.data.antialiasing;
		add(leftSparkles);	

		rightSparkles = new BGSprite('menuassets/creditssparkles', FlxG.width * 0.72, 30, 0, 0, ['sparkles'], true);
		rightSparkles.updateHitbox();
		rightSparkles.alpha = 1;
		rightSparkles.scale.set(0.8,0.8);
		rightSparkles.antialiasing = ClientPrefs.data.antialiasing;
		add(rightSparkles);	

		moon = new BGSprite('menuassets/creditsmoon', 35, 25, 0, 0);
		moon.updateHitbox();
		moon.alpha = 1;
		moon.scale.set(0.8,0.8);
		moon.antialiasing = ClientPrefs.data.antialiasing;
		add(moon);		

		leftArrow = new BGSprite('menuassets/creditsarrow', FlxG.width / 2 - 200, 50, 0, 0); //Reposition these arrows better later
		leftArrow.updateHitbox();
		leftArrow.alpha = 1;
		leftArrow.scale.set(0.8,0.8);
		leftArrow.antialiasing = ClientPrefs.data.antialiasing;
		add(leftArrow);		

		rightArrow = new BGSprite('menuassets/creditsarrow', FlxG.width / 2 + 200, 50, 0, 0);//Reposition these arrows better later
		rightArrow.updateHitbox();
		rightArrow.alpha = 1;
		rightArrow.scale.set(0.8,0.8);
		rightArrow.flipX = true;
		rightArrow.antialiasing = ClientPrefs.data.antialiasing;
		add(rightArrow);		


		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		for (mod in Mods.parseList().enabled)
			pushModCreditsToList(mod);
		#end
		//Can you remove the bg color part of this? it's not necessary as the whole menu is black and white, idk if removing it from the arrawy without doin other stuff would break

		var defaultList:Array<Array<String>> = [
			// Name - Icon name - Description - Link - BG Color
			['Artists'],
			[
				'Mkv8',
				'mkIcon',
				'This is my super cool template credits message!',
				'https://twitter.com/Mkv8Art',
				'F7AC41'
			],
			[
				'Gigab00ts',
				'gigaIcon',
				'This mod would be better if Johnny round was here',
				'https://bsky.app/profile/gigab00ts.bsky.social',
				'F74141'
			],
			[
				'Orio',
				'orioIcon',
				'Featuring Dante from the Devil May Cry series',
				'https://bsky.app/profile/thatorioguy.bsky.social',
				'F74141'
			],
			[''],
			['Coders'],
			[
				'Mkv8',
				'mkIcon',
				'This is my super cool template credits message!',
				'https://twitter.com/Mkv8Art',
				'A66B89'
			],
			[
				'Shadowfi',
				'shadowfiIcon',
				'See my pinky... See my thumb... See my fist you better run >:(',
				'https://x.com/Shadowfi1385',
				'A66B89'
			],
			[
				'Tantalun',
				'tantalunIcon',
				'omg hi tanta :333 explodes', //put your quote here tanta
				'https://twitter.com/Mkv8Art', //put your link here tanta
				'A66B89'
			],
			[''],			
			['Musicians'],	//this section is always huge lmao	
			[
				'Aidan.XD', //main theme
				'aidanIcon',
				'im covered in fiberglass',
				'https://twitter.com/DEADMAC1',
				'D65C58'
			],
			[
				'Splatterdash', //Forest Fire, pause/extras/gameover themes/eye of the beholder
				'splatterdashIcon',
				'I am back again because I love alfredo beta room',
				'https://twitter.com/DEADMAC1',
				'D65C58'
			],
			[
				'Tailer', //Convicted Love along with coquers
				'tailerIcon',
				'you may know me for B2 remixed, but now I am a fan of two icelandic Eurovision bros I love væb',
				'https://twitter.com/tailer4440',
				'D65C58'
			],
			[
				'Meroth', //Jammed Cartridge
				'merothIcon',
				'"uhm, add that" yes        literally that',
				'https://x.com/MerothIsHere',
				'D65C58'
			],									
			[
				'PixelatedEngie', //Jammed Cartridge
				'engieIcon',
				'mmm.. burger..',
				'https://x.com/PixelatedEngie',
				'D65C58'
			],	
			[
				'Stardust Tunes', //Anemoia
				'stardustTunesIcon',
				'Ad Astra',
				'https://x.com/StardustTunes',
				'D65C58'
			],	
			[
				'Kamex', //PUNCH BUGGY!!!
				'kamexIcon',
				'I will never beat the chill music allegations...',
				'https://x.com/KamexVGM',
				'D65C58'
			],	
			[
				'Gracio', //RooftopTalkshop
				'gracioIcon',
				'Bort Simpson is coming Bort Simpson is coming Bort Simpson is coming Bort Simpson is coming Bort Simpson is coming',
				'https://x.com/Gracio978',
				'D65C58'
			],	
			[
				'Zeroh', //Helped Eye of the Beholder, and (Troubleshootin song here)
				'zerohIcon',
				'has anyone seen my zeroh mulch? i still havent found it',
				'https://x.com/catsmirkk',
				'D65C58'
			],	
			[
				'Jospi', //as the clock strikes midnight (Credits theme)
				'jospiIcon',
				'sry   i ated all the music',
				'https://x.com/jospi_music',
				'D65C58'
			],			
			[
				'Haspecto', //Channel Surfers
				'haspectoIcon',
				'This is my super cool template credits message!',
				'https://x.com/SorrowGuy1',
				'D65C58'
			],
			[''],						
			['Charters'],						
			[
				'ChubbyGamer',
				'chubbyIcon',
				'That one charter dragon',
				'https://twitter.com/ChubbyAlt',
				'C78A58'
			],
			[
				'PavDrop',
				'pavIcon',
				'what the gup?? oh also hi mat doestopher underscore from fnf (fortnite festival)',
				'https://x.com/PavDrop',
				'BAE2FF'
			],
			[
				'sire_kirbz',
				'sireIcon',
				'This is my super cool template credits message!',
				'https://x.com/sirekirb',
				'BAE2FF'
			],			
			[''],
			['Extra Help'], //Misc dont get the same icons, theyll get simpler ones methinks, but it can work the same, Special thanks are just names
			[
				'coquers_',
				'coquersIcon',
				'Helped with Convicted Love!',
				'https://x.com/coquers_',
				'BAE2FF'
			],
			[
				'ciablue',
				'ciaIcon',
				'Helped designing Alfie for (ai song) and wrote the comments for Ai in the extras menu',
				'https://x.com/bluemeows_',
				'BAE2FF'
			],
			[
				'Jumbo',
				'jumboIcon',
				'Helped conceptualize/make a rough concept for one of the EOTB animations',
				'https://x.com/desikobutreal',
				'BAE2FF'
			],	
			[
				'Daybreak',
				'daybreakIcon',
				'Voiced Minus Alfie',
				'https://x.com/DaybreakBun',
				'BAE2FF'
			],					
			[
				'Ferzy',
				'ferzyIcon',
				'Made the combo/UI script, helped optimize assets and helped with coding the menus',
				'https://x.com/_Ferzy?s=09', //idk his link
				'BAE2FF'
			],		
			[''],
			['Special Thanks'],		 // ON THIS ONE THERES NO ICON
			[
				'You!',
				'blank',
				' ',
				'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
				'BAE2FF'
			],	
			[
				'GigaB00ts',
				'blank',
				'Creator of Kisston!',
				'https://bsky.app/profile/gigab00ts.bsky.social',
				'BAE2FF'
			],			
			[
				'Josszzol',
				'blank',
				'Creator of Filip!',
				'https://x.com/Abbledacker',
				'BAE2FF'
			],
			[
				'Hotline 024 Team',
				'blank',
				'Thank you to Saruky especially, who created Nikku!',
				'https://x.com/Saruky__',
				'BAE2FF'
			],
			[
				'Troubleshootin Team',
				'blank',
				'Thanks to Zeroh and the team who created Ai!',
				'https://x.com/FNFTroubleshoot',
				'BAE2FF'
			],
			[
				'SEGA',
				'blank',
				'Created Hatsune Miku!',
				'https://www.youtube.com/watch?v=Osuhh-TsM7c',
				'BAE2FF'
			],								
			[
				'Neomari',
				'blank',
				' ',
				'https://x.com/dilacer8/status/1983644788651126832',
				'BAE2FF'
			],		
			[
				'Pixelagoon',
				'blank',
				' ',
				'https://youtu.be/KVtLZ3HumkU?si=2y4DfWboKyrb16jW&t=14',
				'BAE2FF'
			],	
			[
				'MattDoes',
				'blank',
				' ',
				'null',
				'BAE2FF'
			],	
			[
				'SirSins',
				'blank',
				' ',
				'https://www.youtube.com/live/vw89eMOtRb8?si=jmGGfh8lL5em7FYZ&t=505',
				'BAE2FF'
			],	
			[
				'AurumArts',
				'blank',
				' ',
				'https://www.youtube.com/shorts/eS-Mt7XLYg4',
				'BAE2FF'
			],	
			[
				'Sayge',
				'blank',
				' ',
				'https://www.youtube.com/watch?v=JaVNBlMGY8s',
				'BAE2FF'
			],	
			[
				'Lankaden',
				'blank',
				' ',
				'https://x.com/GianMLG/status/1987654860943069195?s=20',
				'BAE2FF'
			],	
			[
				'FlarinthK_',
				'blank',
				' ',
				'https://x.com/PostsOfCats/status/1992229104712659226?s=20',
				'BAE2FF'
			],	
			[
				'Hazelite',
				'blank',
				' ',
				'https://www.youtube.com/watch?v=gucl6y4wli8',
				'BAE2FF'
			],				
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
		

		super.create();
		FlxG.game.setFilters(shader);
		FlxG.game.filtersEnabled = true;

		FlxG.camera.setFilters([new ShaderFilter(curveShader)]);
		FlxG.camera.filtersEnabled = true;

		curveShader.chromOff = 4;
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
