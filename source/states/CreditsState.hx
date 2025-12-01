package states;


typedef CreditData = {
	name:String,
	iconName:Null<String>,
	quote:Null<String>,
	link:Null<String>,
}

typedef CreditsSectionData = {
	title:String,
	credits:Array<CreditData>,
}

typedef Credit = {
	name:FlxSprite,
	icon:Null<FlxSprite>,
	quote:Null<FlxSprite>,
}

typedef CreditsSection = {
	title:FlxSprite,
	credits:Array<Credit>,
}

enum SectionChangeDirection {
	Left;
	Right;
}

enum CreditChangeDirection {
	Up;
	Down;
}


class CreditsState extends MusicBeatState {
	private static final creditsData:Array<CreditsSectionData> = [
		{
			title: "Artists",
			credits: [
				{
					name: "Mkv8",
					iconName: "mkIcon",
					quote: "message",
					link: "https://twitter.com/Mkv8Art",
				},
				{
					name: "Gigab00ts",
					iconName: "gigaIcon",
					quote: "This mod would be better if Johnny round was here",
					link: "https://bsky.app/profile/gigab00ts.bsky.social",
				},
				{
					name: "Orio",
					iconName: "orioIcon",
					quote: "Featuring Dante from the Devil May Cry series",
					link: "https://bsky.app/profile/thatorioguy.bsky.social",
				},
			],
		},
		{
			title: "Coders",
			credits: [
				{
					name: "Mkv8",
					iconName: "mkIcon",
					quote: "This is my super cool template credits message!",
					link: "https://twitter.com/Mkv8Art",
				},
				{
					name: "Shadowfi",
					iconName: "shadowfiIcon",
					quote: "See my pinky... See my thumb... See my fist you better run >:(",
					link: "https://x.com/Shadowfi1385",
				},
				{
					name: "Tantalun",
					iconName: "tantalunIcon",
					quote: "belch", //put your quote here tanta
					link: null, //put your link here tanta
				},
			],
		},
		{
			title: "Musicians",
			credits: [
				{
					name: "Aidan.XD", //main theme
					iconName: "aidanIcon",
					quote: "im covered in fiberglass",
					link: "https://twitter.com/DEADMAC1",
				},
				{
					name: "Splatterdash", //Forest Fire, pause/extras/gameover themes/eye of the beholder
					iconName: "splatterdashIcon",
					quote: "I am back again because I love alfredo beta room",
					link: "https://twitter.com/DEADMAC1",
				},
				{
					name: "Tailer", //Convicted Love along with coquers
					iconName: "tailerIcon",
					quote: "you may know me for B2 remixed, but now I am a fan of two icelandic Eurovision bros I love væb",
					link: "https://twitter.com/tailer4440",
				},
				{
					name: "Meroth", //Jammed Cartridge
					iconName: "merothIcon",
					quote: "\"uhm, add that\"\nyes\nliterally that",
					link: "https://x.com/MerothIsHere",
				},
				{
					name: "PixelatedEngie", //Jammed Cartridge
					iconName: "engieIcon",
					quote: "mmm.. burger..",
					link: "https://x.com/PixelatedEngie",
				},
				{
					name: "Stardust Tunes", //Anemoia
					iconName: "stardustTunesIcon",
					quote: "Ad Astra",
					link: "https://x.com/StardustTunes",
				},
				{
					name: "Kamex", //PUNCH BUGGY!!!
					iconName: "kamexIcon",
					quote: "I will never beat the chill music allegations...",
					link: "https://x.com/KamexVGM",
				},
				{
					name: "Gracio", //RooftopTalkshop
					iconName: "gracioIcon",
					quote: "Bort Simpson is coming Bort Simpson is coming Bort Simpson is coming Bort Simpson is coming Bort Simpson is coming",
					link: "https://x.com/Gracio978",
				},
				{
					name: "Zeroh", //Helped Eye of the Beholder, and (Troubleshootin song here)
					iconName: "zerohIcon",
					quote: "has anyone seen my zeroh mulch? i still havent found it",
					link: "https://x.com/catsmirkk",
				},
				{
					name: "Jospi", //as the clock strikes midnight (Credits theme)
					iconName: "jospiIcon",
					quote: "sry\ni ated all the music",
					link: "https://x.com/jospi_music",
				},
				{
					name: "Haspecto", //Channel Surfers
					iconName: "haspectoIcon",
					quote: "This is my super cool template credits message!",
					link: "https://x.com/SorrowGuy1",
				},
			],
		},
		{
			title: "Charters",
			credits: [
				{
					name: "ChubbyGamer",
					iconName: "chubbyIcon",
					quote: "That one charter dragon",
					link: "https://twitter.com/ChubbyAlt",
				},
				{
					name: "PavDrop",
					iconName: "pavIcon",
					quote: "what the gup?? oh also hi mat doestopher underscore from fnf (fortnite festival)",
					link: "https://x.com/PavDrop",
				},
				{
					name: "sire_kirbz",
					iconName: "sireIcon",
					quote: "This is my super cool template credits message!",
					link: "https://x.com/sirekirb",
				},
			],
		},
		{
			title: "Extra Help", // Misc dont get the same icons, they'll get simpler ones methinks, but it can work the same, Special thanks are just names
			credits: [
				{
					name: "coquers_",
					iconName: "coquersIcon",
					quote: "Helped with Convicted Love!",
					link: "https://x.com/coquers_",
				},
				{
					name: "ciablue",
					iconName: "ciaIcon",
					quote: "Helped designing Alfie for (ai song) and wrote the comments for Ai in the extras menu",
					link: "https://x.com/bluemeows_",
				},
				{
					name: "Jumbo",
					iconName: "jumboIcon",
					quote: "Helped conceptualize/make a rough concept for one of the EOTB animations",
					link: "https://x.com/desikobutreal",
				},
				{
					name: "Daybreak",
					iconName: "daybreakIcon",
					quote: "Voiced Minus Alfie",
					link: "https://x.com/DaybreakBun",
				},
				{
					name: "Ferzy",
					iconName: "ferzyIcon",
					quote: "Made the combo/UI script, helped optimize assets and helped with coding the menus",
					link: "https://x.com/_Ferzy?s=09", //idk his link
				},
			],
		},
		{
			title: "Special Thanks", // ON THIS ONE THERES NO ICON
			credits: [
				{
					name: "You!",
					iconName: null,
					quote: null,
					link: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
				},
				{
					name: "GigaB00ts",
					iconName: null,
					quote: "Creator of Kisston!",
					link: "https://bsky.app/profile/gigab00ts.bsky.social",
				},
				{
					name: "Josszzol",
					iconName: null,
					quote: "Creator of Filip!",
					link: "https://x.com/Abbledacker",
				},
				{
					name: "Hotline 024 Team",
					iconName: null,
					quote: "Thank you to Saruky especially, who created Nikku!",
					link: "https://x.com/Saruky__",
				},
				{
					name: "Troubleshootin Team",
					iconName: null,
					quote: "Thanks to Zeroh and the team who created Ai!",
					link: "https://x.com/FNFTroubleshoot",
				},
				{
					name: "Crypton",
					iconName: null,
					quote: "Created Hatsune Miku!",
					link: "https://www.youtube.com/watch?v=Osuhh-TsM7c",
				},
				{
					name: "Neomari",
					iconName: null,
					quote: null,
					link: "https://x.com/dilacer8/status/1983644788651126832",
				},
				{
					name: "Pixelagoon",
					iconName: null,
					quote: null,
					link: "https://youtu.be/KVtLZ3HumkU?si=2y4DfWboKyrb16jW&t=14",
				},
				{
					name: "MattDoes",
					iconName: null,
					quote: null,
					link: null,
				},
				{
					name: "SirSins",
					iconName: null,
					quote: null,
					link: "https://www.youtube.com/live/vw89eMOtRb8?si=jmGGfh8lL5em7FYZ&t=505",
				},
				{
					name: "AurumArts",
					iconName: null,
					quote: null,
					link: "https://www.youtube.com/shorts/eS-Mt7XLYg4",
				},
				{
					name: "Sayge",
					iconName: null,
					quote: null,
					link: "https://www.youtube.com/watch?v=JaVNBlMGY8s",
				},
				{
					name: "Lankaden",
					iconName: null,
					quote: null,
					link: "https://x.com/GianMLG/status/1987654860943069195?s=20",
				},
				{
					name: "FlarinthK_",
					iconName: null,
					quote: null,
					link: "https://x.com/PostsOfCats/status/1992229104712659226?s=20",
				},
				{
					name: "Hazelite",
					iconName: null,
					quote: null,
					link: "https://www.youtube.com/watch?v=gucl6y4wli8",
				},
			],
		},
	];

	private var selectedSection:Int = 0;
	private var selectedCredit:Int = 0;

	private var bg:FlxSprite;

	private var leftSparkles:BGSprite;
	private var rightSparkles:BGSprite;
	private var moon:BGSprite;

	private final sections:Array<CreditsSection> = [];

	private final sectionGroups:Array<FlxSpriteGroup> = [];
	private final sectionCreditsGroups:Array<FlxSpriteGroup> = [];

	private var leftArrow:BGSprite;
	private var rightArrow:BGSprite;

	private var infoBox:FlxSprite;
	private var infoTextFirstLine:FlxText;
	private var infoTextSecondLine:FlxText;

	private var arrowTweens = {
		left: null,
		right: null,
	};

	private var sectionChangeTweens = {
		previous: {
			xTween: null,
		},
		next: {
			xTween: null,
		},
	};

	private var creditChangeTweens = {
		previous: {
			name: null,
			icon: {
				xTween: null,
				alphaTween: null,
			},
			quote: null,
		},
		next: {
			name: null,
			icon: {
				xTween: null,
				alphaTween: null,
			},
			quote: null,
		},
		list: null,
	}

	private final selectedCreditY:Float = 0.25 * FlxG.height;

	private var showInfoTextFirstLine:Bool = false;
	private var showInfoTextSecondLine:Bool = false;

	// var shader:Array<BitmapFilter> = [
	// 	new ShaderFilter(new shaders.PostProcessing()),
	// ];

	/*var curveShader:Array<BitmapFilter> = [
		new ShaderFilter(new shaders.CurveShader()),
	];*/

	//REMINDER THAT THERES A CONCEPT PICTURE ON THE MENU ASSETS FOLDER
	//For this menu, people are displayed vertically and when you press up and down it swaps between them (just like the original menu!)
	//When someone is highlighted/selected, their icon and name tweens to the left and it displays a message
	//Pressing left and right changes categories... categories are: ARTISTS - CODERS - MUSICIANS - CHARTERS - EXTRA HELP & SPECIAL THANKS
	//I set all the icons as mk for now but i can change them later, theyre already in the tiles
	//IDK WHAT BUTTON TO MAKE THE CREDITS VIDEO PLAY, the credits video itself is done its "CreditsFilter" in the files

	// var curveShader = new shaders.CurveShader();

	override function create() {
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Checking the credits!", null);
		#end

		super.create();

		this.persistentUpdate = true;

		this.bg = new FlxSprite();
		this.bg.loadGraphic("assets/shared/images/menuassets/creditsbg.png");
		this.bg.scale.set(0.8, 0.8);
		this.bg.updateHitbox();
		this.bg.antialiasing = ClientPrefs.data.antialiasing;
		this.bg.screenCenter(XY);

		this.leftSparkles = new BGSprite("menuassets/creditssparkles", 0.0, 0.0, 0, 0, ["sparkles"], true);
		this.leftSparkles.x = 0.30 * FlxG.width - this.leftSparkles.width;
		this.leftSparkles.scale.set(0.8, 0.8);
		this.leftSparkles.updateHitbox();
		this.leftSparkles.flipX = true;
		this.leftSparkles.antialiasing = ClientPrefs.data.antialiasing;

		this.rightSparkles = new BGSprite("menuassets/creditssparkles", 0.0, 0.0, 0, 0, ["sparkles"], true);
		this.rightSparkles.x = 0.70 * FlxG.width;
		this.rightSparkles.scale.set(0.8, 0.8);
		this.rightSparkles.updateHitbox();
		this.rightSparkles.antialiasing = ClientPrefs.data.antialiasing;

		this.moon = new BGSprite("menuassets/creditsmoon", 35, 25, 0, 0);
		this.moon.scale.set(0.8, 0.8);
		this.moon.updateHitbox();
		this.moon.antialiasing = ClientPrefs.data.antialiasing;

		this.leftArrow = new BGSprite("menuassets/creditsarrow", 0.0, 0.0, 0, 0);
		this.leftArrow.scale.set(0.8, 0.8);
		this.leftArrow.updateHitbox();
		this.leftArrow.x = 0.025 * FlxG.width;
		this.leftArrow.screenCenter(Y);
		this.leftArrow.antialiasing = ClientPrefs.data.antialiasing;

		if (this.selectedSection == 0) {
			this.leftArrow.visible = false;
		}

		this.rightArrow = new BGSprite("menuassets/creditsarrow", 0.0, 0.0, 0, 0);
		this.rightArrow.scale.set(0.8, 0.8);
		this.rightArrow.updateHitbox();
		this.rightArrow.x = 0.975 * FlxG.width - this.rightArrow.width;
		this.rightArrow.screenCenter(Y);
		this.rightArrow.flipX = true;
		this.rightArrow.antialiasing = ClientPrefs.data.antialiasing;

		if (this.selectedSection == CreditsState.creditsData.length - 1) {
			this.rightArrow.visible = false;
		}

		this.infoTextFirstLine = new FlxText(0.0, 0.0, 0.0, "Press ENTER to open selected link!", 20);
		this.infoTextFirstLine.font = Paths.font("vcr.ttf");
		this.infoTextFirstLine.screenCenter(X);

		this.infoTextSecondLine = new FlxText(0.0, 0.0, 0.0, "Press P to watch the credits cutscene again!", 20);
		this.infoTextSecondLine.font = Paths.font("vcr.ttf");
		this.infoTextSecondLine.screenCenter(X);

		this.infoTextSecondLine.y = FlxG.height - 32.0 - this.infoTextSecondLine.height;
		this.infoTextFirstLine.y = this.infoTextSecondLine.y - 20.0 - this.infoTextFirstLine.height;

		this.infoBox = new FlxSprite();
		this.infoBox.makeGraphic(1, 1, FlxColor.BLACK);
		this.infoBox.x = -10.0;
		this.infoBox.alpha = 0.6;

		this.showInfoTextFirstLine = CreditsState.creditsData[this.selectedSection].credits[this.selectedCredit].link != null;
		this.showInfoTextSecondLine = FlxG.save.data.playedCreditsCutscene ?? false;

		if (this.showInfoTextFirstLine && this.showInfoTextSecondLine) {
			this.infoTextFirstLine.visible = true;
			this.infoTextSecondLine.visible = true;

			this.infoBox.setGraphicSize(10.0 + FlxG.width + 10.0, 16.0 + this.infoTextFirstLine.height + 20.0 + this.infoTextSecondLine.height + 16.0);
			this.infoBox.updateHitbox();
			this.infoBox.y = this.infoTextFirstLine.y - 16.0;
			this.infoBox.visible = true;
		} else if (this.showInfoTextFirstLine) {
			this.infoTextFirstLine.visible = true;
			this.infoTextSecondLine.visible = false;

			this.infoBox.setGraphicSize(10.0 + FlxG.width + 10.0, 16.0 + this.infoTextFirstLine.height + 16.0);
			this.infoBox.updateHitbox();
			this.infoBox.y = this.infoTextFirstLine.y - 16.0;
			this.infoBox.visible = true;
		} else if (this.showInfoTextSecondLine) {
			this.infoTextFirstLine.visible = false;
			this.infoTextSecondLine.visible = true;

			this.infoBox.setGraphicSize(10.0 + FlxG.width + 10.0, 16.0 + this.infoTextSecondLine.height + 16.0);
			this.infoBox.updateHitbox();
			this.infoBox.y = this.infoTextSecondLine.y - 16.0;
			this.infoBox.visible = true;
		} else {
			this.infoTextFirstLine.visible = false;
			this.infoTextSecondLine.visible = false;

			this.infoBox.visible = false;
		}

		for (i in 0...CreditsState.creditsData.length) {
			var sectionData:CreditsSectionData = CreditsState.creditsData[i];

			var sectionGroup:FlxSpriteGroup = new FlxSpriteGroup(0.0, 0.0);
			var sectionCreditsGroup:FlxSpriteGroup = new FlxSpriteGroup(0.0, 0.0);

			var title:FlxText = new FlxText(0.0, 0.0, 0.0, sectionData.title.toUpperCase(), 72);
			title.font = Paths.font("vcr.ttf");
			title.screenCenter(X);
			title.y = 60.0 - (title.height / 2.0);

			var section:CreditsSection = {
				title: title,
				credits: [],
			}

			for (j in 0...sectionData.credits.length) {
				var creditData:CreditData = sectionData.credits[j];

				var name:FlxText = new FlxText(0.0, 0.0, 0.0, creditData.name, 40);
				name.font = Paths.font("vcr.ttf");
				name.screenCenter(X);

				var icon:Null<FlxSprite> = null;

				if (creditData.iconName != null) {
					var iconName:String = creditData.iconName;

					if (!FileSystem.exists('assets/shared/images/credits/${iconName}.png')) {
						if (FileSystem.exists('assets/shared/images/credits/${iconName}-pixel.png')) {
							iconName = '${iconName}-pixel';
						} else {
							iconName = "missing_icon";
						}
					}

					icon = new FlxSprite();
					icon.loadGraphic('assets/shared/images/credits/${iconName}.png');
					icon.scale.set(0.75, 0.75);
					icon.updateHitbox();
					icon.screenCenter(X);

					if (iconName.endsWith("-pixel")) {
						icon.antialiasing = false;
					}
				}

				var quote:Null<FlxText> = null;

				if (creditData.quote != null) {
					quote = new FlxText(0.0, 0.0, 360.0, creditData.quote, 24);
					quote.font = Paths.font("vcr.ttf");
					quote.alignment = FlxTextAlign.CENTER;
					quote.screenCenter(X);
				}

				if (icon != null && quote != null) {
					quote.x += 60.0;
				}

				if (i == this.selectedSection && j == this.selectedCredit) {
					if (icon != null && quote != null) {
						icon.x -= 240.0;
					}
				} else {
					name.alpha = 0.5;

					if (icon != null) {
						icon.alpha = 0.5;
					}

					if (quote != null) {
						if (icon != null) {
							quote.alpha = 0.0;
						} else {
							quote.alpha = 0.5;
						}
					}
				}

				section.credits.push(
					{
						name: name,
						icon: icon,
						quote: quote,
					}
				);

				if (quote != null) {
					sectionCreditsGroup.add(quote);
				}

				if (icon != null) {
					sectionCreditsGroup.add(icon);
				}

				sectionCreditsGroup.add(name);
			}

			for (i in 0...(section.credits.length)) {
				var credit:Credit = section.credits[i];
				var previousCredit:Credit = section.credits[i - 1];

				credit.name.y = (previousCredit?.name.y ?? 0.0) + (previousCredit?.name.height ?? 0.0) + (previousCredit?.icon != null || previousCredit?.quote != null ? 16.0 : 0.0) + Math.max((previousCredit?.icon?.height ?? 0.0), (previousCredit?.quote?.height ?? 0.0)) + 32.0;

				if (credit.icon != null) {
					credit.icon.y = credit.name.y + credit.name.height + 16.0;
				}

				if (credit.quote != null) {
					credit.quote.y = Math.max(credit.name.y + credit.name.height + 16.0, (credit.icon?.y ?? 0.0) + ((credit.icon?.height ?? 0.0) / 2.0) - (credit.quote.height / 2.0));
				}
			}

			sectionCreditsGroup.y -= (section.credits[this.selectedCredit].name.y - this.selectedCreditY);

			this.sectionCreditsGroups.push(sectionCreditsGroup);

			this.sections.push(section);

			sectionGroup.add(sectionCreditsGroup);
			sectionGroup.add(title);

			if (i < this.selectedSection) {
				sectionGroup.x = -FlxG.width;
			} else if (i > this.selectedSection) {
				sectionGroup.x = FlxG.width;
			}

			this.sectionGroups.push(sectionGroup);
		}

		this.add(this.bg);

		this.add(this.leftSparkles);
		this.add(this.rightSparkles);
		this.add(this.moon);

		for (sectionGroup in this.sectionGroups) {
			this.add(sectionGroup);
		}

		this.add(this.leftArrow);
		this.add(this.rightArrow);

		this.add(this.infoBox);
		this.add(this.infoTextFirstLine);
		this.add(this.infoTextSecondLine);

		// FlxG.game.setFilters(shader);
		// FlxG.game.filtersEnabled = true;

		// FlxG.camera.setFilters([new ShaderFilter(curveShader)]);
		// FlxG.camera.filtersEnabled = true;

		// curveShader.chromOff = 4;
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;

	override function update(elapsed:Float) {
		if (!quitting) {
			if (controls.UI_UP_P) {
				this.changeCredit(CreditChangeDirection.Up);
			} else if (controls.UI_DOWN_P) {
				this.changeCredit(CreditChangeDirection.Down);
			}

			if (controls.UI_LEFT_P) {
				this.changeSection(SectionChangeDirection.Left);
			} else if (controls.UI_RIGHT_P) {
				this.changeSection(SectionChangeDirection.Right);
			}

			if (controls.ACCEPT) {
				if (CreditsState.creditsData[this.selectedSection].credits[this.selectedCredit].link != null) {
					FlxG.sound.play(Paths.sound("confirmMenu"));
					CoolUtil.browserLoad(CreditsState.creditsData[this.selectedSection].credits[this.selectedCredit].link);
				}
			}

			if (controls.BACK) {
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}

		super.update(elapsed);
	}

	function changeSection(direction:SectionChangeDirection) {
		if (this.sectionChangeTweens.previous.xTween != null || this.sectionChangeTweens.next.xTween != null) {
			return;
		}

		if (this.creditChangeTweens.previous.name != null || this.creditChangeTweens.previous.icon.xTween != null || this.creditChangeTweens.previous.icon.alphaTween != null || this.creditChangeTweens.previous.quote != null
			|| this.creditChangeTweens.next.name != null || this.creditChangeTweens.next.icon.xTween != null || this.creditChangeTweens.next.icon.alphaTween != null || this.creditChangeTweens.next.quote != null
			|| this.creditChangeTweens.list != null) {
			return;
		}

		var nextSelectedSection:Int = this.selectedSection;

		switch (direction) {
			case SectionChangeDirection.Left:
				nextSelectedSection -= 1;

			case SectionChangeDirection.Right:
				nextSelectedSection += 1;
		}

		if (nextSelectedSection < 0 || nextSelectedSection > CreditsState.creditsData.length - 1) {
			return;
		}

		var selectedSectionGroupX:Float = this.sectionGroups[this.selectedSection].x;
		var nextSelectedSectionGroupX:Float = this.sectionGroups[nextSelectedSection].x;

		switch (direction) {
			case SectionChangeDirection.Left:
				selectedSectionGroupX = FlxG.width;
				nextSelectedSectionGroupX = 0.0;

				if (this.arrowTweens.left == null) {
					this.arrowTweens.left = FlxTween.tween(
						this.leftArrow,
						{
							x: this.leftArrow.x - 25.0,
						},
						0.15,
						{
							ease: FlxEase.cubeIn,
						},
					).then(
						FlxTween.tween(
							this.leftArrow,
							{
								x: this.leftArrow.x,
							},
							0.15,
							{
								ease: FlxEase.cubeOut,
								onComplete: function (tween) {
									this.arrowTweens.left = null;
								}
							},
						)
					);
				}

			case SectionChangeDirection.Right:
				selectedSectionGroupX = -FlxG.width;
				nextSelectedSectionGroupX = 0.0;

				if (this.arrowTweens.right == null) {
					this.arrowTweens.right = FlxTween.tween(
						this.rightArrow,
						{
							x: this.rightArrow.x + 25.0,
						},
						0.1,
						{
							ease: FlxEase.cubeIn,
						},
					).then(
						FlxTween.tween(
							this.rightArrow,
							{
								x: this.rightArrow.x,
							},
							0.1,
							{
								ease: FlxEase.cubeOut,
								onComplete: function (tween) {
									this.arrowTweens.right = null;
								}
							},
						)
					);
				}
		}

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.5);

		this.sectionChangeTweens.previous.xTween = FlxTween.tween(
			this.sectionGroups[this.selectedSection],
			{
				x: selectedSectionGroupX,
			},
			0.4,
			{
				ease: FlxEase.cubeInOut,
				onComplete: function (tween) {
					this.sectionChangeTweens.previous.xTween = null;
				}
			}
		);

		this.sectionChangeTweens.next.xTween = FlxTween.tween(
			this.sectionGroups[nextSelectedSection],
			{
				x: nextSelectedSectionGroupX,
			},
			0.4,
			{
				ease: FlxEase.cubeInOut,
				onComplete: function (tween) {
					this.sectionChangeTweens.next.xTween = null;
				}
			}
		);

		var deselectedSection:CreditsSection = this.sections[this.selectedSection];

		var deselectedCreditSprites:Credit = deselectedSection.credits[this.selectedCredit];

		deselectedCreditSprites.name.alpha = 0.5;

		if (deselectedCreditSprites.icon != null) {
			deselectedCreditSprites.icon.alpha = 0.5;

			if (deselectedCreditSprites.quote != null) {
				deselectedCreditSprites.icon.x += 240.0;
			}
		}

		if (deselectedCreditSprites.quote != null) {
			if (deselectedCreditSprites.icon != null) {
				deselectedCreditSprites.quote.alpha = 0.0;
			} else {
				deselectedCreditSprites.quote.alpha = 0.5;
			}
		}

		var deselectedSectionCreditsGroup:FlxSpriteGroup = this.sectionCreditsGroups[this.selectedSection];

		deselectedSectionCreditsGroup.y -= (deselectedSection.credits[this.selectedCredit].name.y - this.selectedCreditY);

		var nextSelectedCredit = 0;

		var selectedSection:CreditsSection = this.sections[nextSelectedSection];

		var selectedCreditSprites:Credit = selectedSection.credits[nextSelectedCredit];

		selectedCreditSprites.name.alpha = 1.0;

		if (selectedCreditSprites.icon != null) {
			selectedCreditSprites.icon.alpha = 1.0;

			if (selectedCreditSprites.quote != null) {
				selectedCreditSprites.icon.x -= 240.0;
			}
		}

		if (selectedCreditSprites.quote != null) {
			selectedCreditSprites.quote.alpha = 1.0;
		}

		var selectedSectionCreditsGroup:FlxSpriteGroup = this.sectionCreditsGroups[nextSelectedSection];

		selectedSectionCreditsGroup.y -= (selectedSection.credits[nextSelectedCredit].name.y - this.selectedCreditY);

		this.selectedCredit = nextSelectedCredit;

		this.selectedSection = nextSelectedSection;

		if (this.selectedSection == 0) {
			this.leftArrow.visible = false;
		} else {
			this.leftArrow.visible = true;
		}

		if (this.selectedSection == CreditsState.creditsData.length - 1) {
			this.rightArrow.visible = false;
		} else {
			this.rightArrow.visible = true;
		}
	}

	function selectCredit(index:Int) {
		if (this.creditChangeTweens.previous.name != null || this.creditChangeTweens.previous.icon.xTween != null || this.creditChangeTweens.previous.icon.alphaTween != null || this.creditChangeTweens.previous.quote != null
			|| this.creditChangeTweens.next.name != null || this.creditChangeTweens.next.icon.xTween != null || this.creditChangeTweens.next.icon.alphaTween != null || this.creditChangeTweens.next.quote != null
			|| this.creditChangeTweens.list != null) {
			return;
		}

		if (this.sectionChangeTweens.previous.xTween != null || this.sectionChangeTweens.next.xTween != null) {
			return;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.5);

		var deselectedCredit:Credit = this.sections[this.selectedSection].credits[this.selectedCredit];

		this.creditChangeTweens.previous.name = FlxTween.tween(
			deselectedCredit.name,
			{
				alpha: 0.5,
			},
			0.2,
			{
				onComplete: function (tween) {
					this.creditChangeTweens.previous.name = null;
				}
			},
		);

		if (deselectedCredit.icon != null) {
			this.creditChangeTweens.previous.icon.alphaTween = FlxTween.tween(
				deselectedCredit.icon,
				{
					alpha: 0.5,
				},
				0.2,
				{
					onComplete: function (tween) {
						this.creditChangeTweens.previous.icon.alphaTween = null;
					}
				},
			);

			if (deselectedCredit.quote != null) {
				this.creditChangeTweens.previous.icon.xTween = FlxTween.tween(
					deselectedCredit.icon,
					{
						x: deselectedCredit.icon.x + 240.0,
					},
					0.16,
					{
						ease: FlxEase.cubeOut,
						onComplete: function (tween) {
							this.creditChangeTweens.previous.icon.xTween = null;
						}
					},
				);
			}
		}

		if (deselectedCredit.quote != null) {
			if (deselectedCredit.icon != null) {
				this.creditChangeTweens.previous.quote = FlxTween.tween(
					deselectedCredit.quote,
					{
						alpha: 0.0,
					},
					0.2,
					{
						onComplete: function (tween) {
							this.creditChangeTweens.previous.quote = null;
						}
					},
				);
			} else {
				this.creditChangeTweens.previous.quote = FlxTween.tween(
					deselectedCredit.quote,
					{
						alpha: 0.5,
					},
					0.2,
					{
						onComplete: function (tween) {
							this.creditChangeTweens.previous.quote = null;
						}
					},
				);
			}

		}

		this.selectedCredit = index;

		var selectedCredit:Credit = this.sections[this.selectedSection].credits[this.selectedCredit];

		this.creditChangeTweens.next.name = FlxTween.tween(
			selectedCredit.name,
			{
				alpha: 1.0,
			},
			0.2,
			{
				onComplete: function (tween) {
					this.creditChangeTweens.next.name = null;
				}
			},
		);

		if (selectedCredit.icon != null) {
			this.creditChangeTweens.next.icon.alphaTween = FlxTween.tween(
				selectedCredit.icon,
				{
					alpha: 1.0,
				},
				0.2,
				{
					onComplete: function (tween) {
						this.creditChangeTweens.next.icon.alphaTween = null;
					}
				},
			);

			if (selectedCredit.quote != null) {
				this.creditChangeTweens.next.icon.xTween = FlxTween.tween(
					selectedCredit.icon,
					{
						x: selectedCredit.icon.x - 240.0,
					},
					0.16,
					{
						ease: FlxEase.cubeOut,
						onComplete: function (tween) {
							this.creditChangeTweens.next.icon.xTween = null;
						}
					},
				);
			}
		}

		if (selectedCredit.quote != null) {
			this.creditChangeTweens.next.quote = FlxTween.tween(
				selectedCredit.quote,
				{
					alpha: 1.0,
				},
				0.2,
				{
					onComplete: function (tween) {
						this.creditChangeTweens.next.quote = null;
					}
				},
			);
		}

		var sectionCreditsGroup:FlxSpriteGroup = this.sectionCreditsGroups[this.selectedSection];
		var section:CreditsSection = this.sections[this.selectedSection];

		this.creditChangeTweens.list = FlxTween.tween(
			sectionCreditsGroup,
			{
				y: sectionCreditsGroup.y - (section.credits[this.selectedCredit].name.y - this.selectedCreditY),
			},
			0.25,
			{
				ease: FlxEase.cubeInOut,
				onComplete: function (tween) {
					this.creditChangeTweens.list = null;
				}
			},
		);

		this.showInfoTextFirstLine = CreditsState.creditsData[this.selectedSection].credits[this.selectedCredit].link != null;

		if (this.showInfoTextFirstLine && this.showInfoTextSecondLine) {
			this.infoTextFirstLine.visible = true;
			this.infoTextSecondLine.visible = true;

			this.infoBox.setGraphicSize(10.0 + FlxG.width + 10.0, 16.0 + this.infoTextFirstLine.height + 20.0 + this.infoTextSecondLine.height + 16.0);
			this.infoBox.updateHitbox();
			this.infoBox.y = this.infoTextFirstLine.y - 16.0;
			this.infoBox.visible = true;
		} else if (this.showInfoTextFirstLine) {
			this.infoTextFirstLine.visible = true;
			this.infoTextSecondLine.visible = false;

			this.infoBox.setGraphicSize(10.0 + FlxG.width + 10.0, 16.0 + this.infoTextFirstLine.height + 16.0);
			this.infoBox.updateHitbox();
			this.infoBox.y = this.infoTextFirstLine.y - 16.0;
			this.infoBox.visible = true;
		} else if (this.showInfoTextSecondLine) {
			this.infoTextFirstLine.visible = false;
			this.infoTextSecondLine.visible = true;

			this.infoBox.setGraphicSize(10.0 + FlxG.width + 10.0, 16.0 + this.infoTextSecondLine.height + 16.0);
			this.infoBox.updateHitbox();
			this.infoBox.y = this.infoTextSecondLine.y - 16.0;
			this.infoBox.visible = true;
		} else {
			this.infoTextFirstLine.visible = false;
			this.infoTextSecondLine.visible = false;

			this.infoBox.visible = false;
		}
	}

	function changeCredit(direction:CreditChangeDirection) {
		var nextSelectedCredit:Int = this.selectedCredit;

		switch (direction) {
			case CreditChangeDirection.Up:
				nextSelectedCredit -= 1;

			case CreditChangeDirection.Down:
				nextSelectedCredit += 1;
		}

		if (nextSelectedCredit < 0 || nextSelectedCredit > CreditsState.creditsData[this.selectedSection].credits.length - 1) {
			return;
		}

		this.selectCredit(nextSelectedCredit);
	}
}
