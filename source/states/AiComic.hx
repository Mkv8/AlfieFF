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

class AiComic extends MusicBeatState {


	var panelNum:Int = 0;
	var panels:Array<FlxSprite> = [];

	var object:FlxSprite = null;

	var debugText:FlxText;
	var pressEnterText:FlxText;

	var canSpam:Bool = true;

	var data:Array<Dynamic> = [];

	var forceNumber = 0;

	var shader:Array<BitmapFilter> = [new ShaderFilter(new shaders.PostProcessing()),];
	var curveShader = new shaders.CurveShader();

	var player:MusicPlayer;

	public static var itsgivingendcard:Bool;


	override function create() {

		setupPanels();

		pressEnterText = new FlxText(40, FlxG.height * 0.9, 0, "Press ENTER to advance | ESC to skip", 36); //Press Enter to Advance
		pressEnterText.setFormat("VCR OSD Mono", 32, 0xFFffcf53, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    	pressEnterText.alpha = 0.5;
		pressEnterText.borderColor = 0xFF3F0000;
		pressEnterText.borderSize = 3;
    	add(pressEnterText);

		if (forceNumber != 0)
        for (i in 0...forceNumber) {
            doPanelEvent();
        }

        FlxG.sound.playMusic("assets/shared/music/pauseAi.ogg", 0.1);

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

	function doPanelEvent()
	{
		var panel = panels[panelNum];
		var lastpanel = panels[panelNum-1];
		var lastlastpanel = panels[panelNum-2];
		var lastlastlastpanel = panels[panelNum-3];

		var ignore:Bool = false;

		if (itsgivingendcard == false)
		{
		switch(panelNum)
		{
			case 0:
			{
					FlxTween.cancelTweensOf(panel);
					FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100
					}, 1, {
						ease: FlxEase.quartInOut,
					});
			}
			ignore = false;
			case 1:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);

				lastpanel.alpha = 0.4;
					panel.y += 100;
					FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100
					}, 1, {
						ease: FlxEase.quartInOut,
					});

			}
			case 2:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
			
				lastpanel.alpha = 0;
				//panel.y += 100;
				panel.alpha = 1;
			}
			case 3:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
				FlxTween.cancelTweensOf(lastlastlastpanel);
				lastpanel.alpha = 0;
				lastlastlastpanel.alpha = 0;
				panel.y += 100;
					FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100
					}, 1, {
						ease: FlxEase.quartInOut,
					});
			}
			case 4:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);

				lastpanel.alpha = 0;
				panel.alpha = 1;
				FlxG.camera.shake(0.005, 0.4);
				ignore = true;
			 	FlxG.sound.play('assets/shared/sounds/click' + ".ogg", 1);

			}
			case 5:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
				FlxTween.tween(lastpanel, {
						alpha: 0,
						y: panel.y + 250,
						angle: 15
					}, 2, {
						ease: FlxEase.quartInOut,
					});

					panel.alpha = 1;
				FlxG.camera.shake(0.005, 0.4);
				ignore = true;
			 	FlxG.sound.play('assets/shared/sounds/menacing' + ".ogg", 1);
			}
			case 6:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);

				ignore = false;

				FlxTween.tween(lastpanel, {
						alpha: 0.5,
						x: panel.x - 200
					}, 2, {
						ease: FlxEase.quartInOut,
					});

				panel.y += 100;
					FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100,
						x: panel.x +200
					}, 2, {
						ease: FlxEase.quartInOut,
					});
			}
			case 7:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);

					FlxTween.tween(lastpanel, {
						alpha: 0.5,
					}, 1, {
						ease: FlxEase.quartInOut,
					});

					panel.y += 100;
					panel.angle = -15;
					FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100,
						angle: 0
					}, 1, {
						ease: FlxEase.quartInOut,
					});
			}
			case 8:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
				FlxTween.cancelTweensOf(lastlastpanel);
				FlxTween.cancelTweensOf(lastlastlastpanel);

				lastlastlastpanel.alpha = 0;
				lastlastpanel.alpha = 0;
				lastpanel.alpha = 0;
				panel.y += 100;
					FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100,
						angle: 0
					}, 1.5, {
						ease: FlxEase.quartInOut,
					});
			}
			case 9:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);

				lastpanel.alpha = 0;
				panel.y += 300;
				FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -300
					}, 3, {
						ease: FlxEase.quartInOut,
					});

			}
			case 10: //reminder this is com11.png
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);

				lastpanel.alpha = 0;
				panel.y +=100;
				FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100
					}, 1, {
						ease: FlxEase.quartInOut,
					});
			}
			case 11:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
				
				FlxTween.tween(lastpanel, {
						alpha: 0.5,
						x: panel.x -300
					}, 1.5, {
						ease: FlxEase.quartInOut,
					});
				FlxTween.tween(panel, {
						alpha: 1,
						x: panel.x +300
					}, 1.5, {
						ease: FlxEase.quartInOut,
					});
			}
			case 12:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
				FlxTween.cancelTweensOf(lastlastpanel);

				lastlastpanel.alpha = 0;
				lastpanel.alpha =0;
				panel.y += 100;
				FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100
					}, 1, {
						ease: FlxEase.quartInOut,
					});
			}
			case 13:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
								
				lastpanel.alpha = 0;
				panel.alpha =1;
				ignore = true;
				FlxG.camera.shake(0.005, 0.4);
			 	FlxG.sound.play('assets/shared/sounds/crash' + ".ogg", 1);
			}
			case 14:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);

				FlxTween.tween(lastpanel, {
						alpha: 0.5
					}, 1, {
						ease: FlxEase.quartInOut,
					});
				panel.y +=100;
				FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100
					}, 1, {
						ease: FlxEase.quartInOut,
					});
			}
			case 15:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
				FlxTween.cancelTweensOf(lastlastpanel);

				FlxTween.tween(lastlastpanel, {
						alpha: 0
					}, 1, {
						ease: FlxEase.quartInOut,
					});
				FlxTween.tween(lastpanel, {
						x: panel.x -300
					}, 1.5, {
						ease: FlxEase.quartInOut,
					});
				panel.y +=100;
				FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100,
						x: panel.x +300
					}, 1.5, {
						ease: FlxEase.quartInOut,
					});
			}
			case 16:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
				FlxTween.cancelTweensOf(lastlastpanel);

				FlxTween.tween(lastlastpanel, {
						alpha: 0.4
					}, 1, {
						ease: FlxEase.quartInOut,
					});
				FlxTween.tween(lastpanel, {
						alpha: 0.4
					}, 1, {
						ease: FlxEase.quartInOut,
					});
				panel.y +=100;
				FlxTween.tween(panel, {
						alpha: 1,
						y: panel.y -100,
					}, 1.2, {
						ease: FlxEase.quartInOut,
					});
			}
			case 17:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
				FlxTween.cancelTweensOf(lastlastpanel);
				FlxTween.cancelTweensOf(lastlastlastpanel);

				lastlastlastpanel.alpha = 0;
				lastlastpanel.alpha = 0;
				FlxTween.tween(lastpanel, {
						alpha: 0.7,
						x: panel.x +=300
					}, 1.5, {
						ease: FlxEase.quartInOut,
					});
				panel.y += 100;
				FlxTween.tween(panel, {
						alpha: 1,
						x: panel.x -600,
						y: panel.y -100
					}, 1.5, {
						ease: FlxEase.quartInOut,
					});
			}
			case 18:
			{
				FlxTween.cancelTweensOf(panel);
				FlxTween.cancelTweensOf(lastpanel);
				FlxTween.cancelTweensOf(lastlastpanel);
								
				FlxTween.tween(lastlastpanel, {
						alpha: 0
					}, 1.5, {
						ease: FlxEase.quartInOut,
					});
				lastpanel.alpha = 0;
				panel.x -= 300;
				panel.alpha = 1;
				ignore = true;
			 	FlxG.sound.play('assets/shared/sounds/snap' + ".ogg", 1);
			}
			case 19:
			{
				exit();
				ignore = true;

			}
			default:
				{
					panel.alpha = 1;
				}

		}
		}

		else {
			switch(panelNum)
			{
				case 0:
				{
						panel.y += 900;
						panel.angle = 20;
						FlxTween.tween(panel, {
							alpha: 1,
							y: panel.y -900,
							angle: 0
						}, 4, {
							ease: FlxEase.quartOut,
							startDelay: 0.3
						});
				}
				default:
				{
					exit();
					ignore = true;
				}
			}

		}
   		panelNum++;

    	if (!ignore)
        	FlxG.sound.play('assets/shared/sounds/pageFlip' + ".ogg", 1);

	}


	override function update(elapsed:Float) {


    	if (FlxG.keys.justPressed.ENTER) {
    		doPanelEvent();
		  }

		var back = FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.ESCAPE;

		if (back) {
			FlxG.sound.play(Paths.sound('cancelMenu'));

			var transitionSprite = new FlxSolid().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
        	transitionSprite.alpha = 0;
        	add(transitionSprite);

			FlxTween.tween(transitionSprite, {alpha: 1}, 1, {ease: FlxEase.quartOut, onComplete:function(twn:FlxTween) {exit();}});



			canSpam = false;

			/*for (sprite in panels)
				{
					if (sprite.visible == false && sprite.customUpdate != null)
						sprite.customUpdate = null;
				}*/


		}

		super.update(elapsed);
	}

	function setupPanels() {
	if (!itsgivingendcard)
	{
    for (i in 0...19) {
        //var panel = new FlxSprite().loadGraphic('assets/shared/images/aiComic/com' + i + '.png');
		var panel = new FlxSprite().loadGraphic('assets/shared/images/aiComic/comic' + Std.string(i+1) + '.png');
        add(panel);

        panel.scale.x *= 0.7;
        panel.scale.y *= 0.7;

        panel.updateHitbox();
        panel.screenCenter();
        panels.push(panel);

        panel.alpha = 0;
    }
	}
	else {
		var panel = new FlxSprite().loadGraphic('assets/shared/images/aiComic/aiEnding.png');
        add(panel);

        panel.scale.x *= 1;
        panel.scale.y *= 1;

        panel.updateHitbox();
        panel.screenCenter();
        panels.push(panel);
	}
    object = panels[0];

    doPanelEvent();
}

var went:Bool = false;
function exit(){

    if (went)
        return;

    went=true;
		if (!itsgivingendcard) {LoadingState.loadAndSwitchState(new PlayState());}
		else { 	MusicBeatState.switchState(new FreeplayState());
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
				PlayState.changedDifficulty = false;	}

}

}
