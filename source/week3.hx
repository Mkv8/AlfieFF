var panelNum = 0;
var panels = [];
var grahs = [];
var object:FlxSprite = null;
var debugText:FlxText;
var pressEnterText:FlxText;
var canSpam = true;
var data:Array<Dynamic> = [];

var forceNumber = 0;

function onCreate() {
    FlxG.log.clear();
    log('Week 3 Hscript loaded ' + FlxG.random.int(1000, 9999));

    for (cam in FlxG.cameras.list)
        if (cam.id == 'transition')
            cam.visible = false;

    setupPanels();

    pressEnterText = new FlxText(390, 670, 0, "Press ENTER to advance", 36); //Press Enter to Advance
    pressEnterText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE);
    pressEnterText.alpha = 0.2;
    add(pressEnterText);

    debugText = new FlxText(10, 55, 0, "panel num: ", 16);
    debugText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE);
    // add(debugText);

    if (forceNumber != 0)
        for (i in 0...forceNumber) {
            doPanelEvent();
        }

    FlxG.sound.playMusic("assets/music/comic/mal1.ogg", 1);
}

var tweens:Array<FlxTween> = [];
var tweenNum:Array<Int> = [];
function makeTween(t:FlxTween):FlxTween {
    tweenNum.push(panelNum+1);
    tweens.push(t);
    return t;
}

function doPanelEvent(){

    var panel = panels[panelNum];
    var prevpanel = panels[panelNum-1];
    var preverpanel = panels[panelNum-2];
    var prevererpanel = panels[panelNum-3];

    var ignore = false;

    for (i in 0...tweens.length)
    {
        var t = tweens[i];
        var n = tweenNum[i];
        if (n == panelNum)
        {
            t.cancel();
            t.percent = 1;
            
        }
    }

    switch(panelNum) {
        case 0:
            makeTween(FlxTween.num(panel.y+50, panel.y, 1.5, {ease: FlxEase.quintOut}, function(v:Float) {
                panel.y = v;
            }));
            panel.customUpdate = function() {
                if (panel.alpha < 1) {
                    panel.alpha += 0.01;
                }
            };
            ignore = true;
        case 1:
            panels[0].visible = false;
            panel.alpha = 1;
            panel.shakeSprite(10, 10, 2);
            panel.updateDefaultpos();
            var timer = 0;
            panel.customUpdate = function() {
                timer+=FlxG.elapsed;

                if (timer >= 1){
                    panel.mode = "null";
                    panel.angle = 0;
                    panel.customUpdate = null;
                    panel.x = panel.defaultpos[0];
                    panel.y = panel.defaultpos[1];
                }
            };
            for (grah in grahs) {
                grah.alpha = 1;
            }

            FlxG.sound.playMusic("assets/music/comic/mal2.ogg", 1);
        case 2:
            // panel.alpha = 0;
            panel.setPosition(560,311);

            makeTween(FlxTween.num(panel.y+30, panel.y, 0.5, {ease: FlxEase.cubeOut}, function(v:Float) {
                panel.y = v;
            }));

            makeTween(FlxTween.num(0, 1, 0.5, {ease: FlxEase.cubeOut}, function(v:Float) {
                panel.alpha = v;
            }));

            // panel.alpha = 1;
        case 3:
            panels[1].visible = false;
            panels[2].visible = false;
            for (grah in grahs) {
                grah.alpha = 0;
            }
            panel.alpha = 1;
            panel.updateDefaultpos();
            object = panel;

            panel.shakeSprite(2, 2, 0);

            new FlxTimer().start(0.2, function(t:FlxTimer) {
                panel.mode = "null";
                panel.x = panel.defaultpos[0];
                panel.y = panel.defaultpos[1];
            });
        case 4,5,6:
            if (panelNum == 6){
                for (i in 3...6){
                    panels[i].alpha = 0;
                }

                var thingy = [
                    [panel.scale.x * 1.2, panel.scale.x * 0.8],
                    [25,0]
                ];

                data.push(makeTween(FlxTween.num(thingy[0][0], thingy[0][1], 2, {ease: FlxEase.cubeOut}, function(v:Float) {
                    panel.scale.x = v;
                    panel.scale.y = v;
                })));

                data.push(makeTween(FlxTween.num(thingy[1][0], thingy[1][1], 2, {ease: FlxEase.cubeOut}, function(v:Float) {
                    panel.angle = v;
                })));

                makeTween(FlxTween.num(0, 1, 0.5, {ease: FlxEase.cubeOut}, function(v:Float) {
                    panel.alpha = v;
                }));

                // panel.alpha = 1;
            }
            if (panelNum == 4){
                makeTween(FlxTween.num(0, 1, 0.5, {ease: FlxEase.cubeOut}, function(v:Float) {
                    panel.alpha = v;
                }));
            }
            if (panelNum == 5){
                panel.alpha = 1;
            }
        case 7:
            
            var neopanel = panels[panelNum-1];

            for (tween in data) {
                if (tween != null) {
                    tween.cancel();
                }
            }

            makeTween(FlxTween.num(1,0, 1, {ease: FlxEase.sineInOut}, function(v:Float) {
                neopanel.alpha = v;
            }));
            makeTween(FlxTween.num(neopanel.scale.x,neopanel.scale.x * 0.5, 3, {ease: FlxEase.sineInOut}, function(v:Float) {
                neopanel.scale.x = v;
                neopanel.scale.y = v;
            }));
            makeTween(FlxTween.num(neopanel.y,neopanel.y + 300, 2, {ease: FlxEase.sineInOut}, function(v:Float) {
                neopanel.y = v;
            }));

            neopanel.customUpdate = function() {
                neopanel.angle -= 0.08;
            };

            FlxG.sound.music.fadeOut(1);

            canSpam = false;

            new FlxTimer().start(1.5, function(t:FlxTimer) {
                // canSpam = true;
                data = [];
                
                for (i in 0...panelNum-1) {
                    panels[i].kill();
                }

                data.push(makeTween(FlxTween.num(0,1, 0.8, {ease: FlxEase.sineOut}, function(v:Float) {
                    panel.alpha = v;
                })));
                data.push(makeTween(FlxTween.num(panel.y + 50,panel.y, 1, {ease: FlxEase.sineOut}, function(v:Float) {
                    panel.y = v;
                })));

                var timesPressed = 0;
                var isShaking = false;
                ignore = true;

                panel.customUpdate = function() {
                    if (FlxG.keys.justPressed.ENTER) {
                        if (timesPressed >= 3) {
                            
                            doPanelEvent();
                            panel.customUpdate = null;
                            panel.alpha = 0;

                            new FlxTimer().start(0.1, function(t:FlxTimer) {
                                canSpam = true;
                                ignore = false;
                            });

                            FlxG.sound.play('assets/sounds/comic/dumpExit.ogg', 1);
                        }
                        else
                        {
                            if (isShaking) return;

                            new FlxTimer().start(0.1 + (0.07 * timesPressed), function(t:FlxTimer) {
                                panel.x = panel.defaultpos[0];
                                panel.y = panel.defaultpos[1];
                                panel.mode = "null";
                                isShaking = false;
                            });
                            
                            isShaking = true;
                            panel.shakeSprite(4 * timesPressed, 4 * timesPressed, 0.5);

                            FlxG.sound.play('assets/sounds/comic/rustle' + (timesPressed + 1) + ".ogg", 0.8);

                        }
                        timesPressed++;
                    }
                };
            });
        case 8:
            panel.alpha = 1;
            panel.updateDefaultpos();

            new FlxTimer().start(0.2, function(t:FlxTimer) {
                panel.x = panel.defaultpos[0];
                panel.y = panel.defaultpos[1];
                panel.mode = "null";
            });
            
            panel.shakeSprite(12,12, 0.5);

            ignore = true;
        case 9:
            panel.scale.x *= 1.35;
            panel.scale.y *= 1.35;

            var neopanel = panels[panelNum-1];

            makeTween(FlxTween.num(neopanel.y,neopanel.y + 100, 1.5, {ease: FlxEase.sineInOut}, function(v:Float) {
                neopanel.y = v;
            }));

            makeTween(FlxTween.num(1,0, 0.75, {ease: FlxEase.sineInOut}, function(v:Float) {
                neopanel.alpha = v;
            }));

            makeTween(FlxTween.num(0,1, 1, {ease: FlxEase.sineOut, startDelay: 0.25}, function(v:Float) {
                panel.alpha = v;
            }));

            makeTween(FlxTween.num(panel.y+45,panel.y, 2, {ease: FlxEase.sineOut, startDelay: 0.25}, function(v:Float) {
                panel.y = v;
            }));

            object = panel;

            canSpam = true;

            FlxG.sound.playMusic("assets/music/comic/mal3.ogg", 1);
        case 10:
            panel.scale.x = panels[panelNum-1].scale.x;
            panel.scale.y = panels[panelNum-1].scale.y;

            log(panels[panelNum-1].scale.x + " " + panels[panelNum-1].scale.y);

            panel.customUpdate = function() {
                if (panel.alpha < 1) {
                    panel.alpha += 0.01;
                }

                panel.x = object.x;
                panel.y = object.y;
            };

            var letter = new FlxSprite(602,-300).loadGraphic(Paths.image('comic/Ai/new/letter'));
            
            letter.scale.x *= 0.6;
            letter.scale.y *= 0.6;

            makeTween(FlxTween.num(-300, 108, 3, {ease: FlxEase.cubeOut}, function(v:Float) {
                letter.y = v;
            }));

            add(letter);

            var timer = 1;
            var amt = 55;
            letter.data = letter.x;

            makeTween(FlxTween.num(amt, 0, 3, {ease: FlxEase.cubeOut}, function(v:Float) {
                amt = v;
            }));

            letter.customUpdate = function() {
                if (FlxG.keys.justPressed.ENTER) {
                    // letter.customUpdate = null;
                    letter.kill();
                    // panel.kill();
                    for (i in 0...panelNum) {
                        panels[i].kill();
                    }
                }

                timer++;

                letter.x = letter.data + Math.sin(timer * 0.05) * amt;
            };

            // panel.color = FlxColor.RED;

        case 11:

            panel.scale.x = 0.6;
            panel.scale.y = 0.6;
            
            makeTween(FlxTween.num(0,1, 0.5, {ease: FlxEase.sineOut}, function(v:Float) {
                panel.alpha = v;
            }));

            makeTween(FlxTween.num(panel.y-50,panel.y, 0.6, {ease: FlxEase.sineOut}, function(v:Float) {
                panel.y = v;
            }));

            object = panel;

        case 12:
            object.kill();

            panel.scale.x = 0.6;
            panel.scale.y = 0.6;

            panel.alpha = 1;

            makeTween(FlxTween.num(0.6, 0.65, 1, {ease: FlxEase.cubeOut}, function(v:Float) {
                panel.scale.x = v;
                panel.scale.y = v;
            }));

        case 13:
            prevpanel.alpha = 0.0;

            makeTween(FlxTween.num(0.65, 0.6, 0.4, {ease: FlxEase.elasticOut}, function(v:Float) {
                panel.scale.x = v;
                panel.scale.y = v;
            }));

            panel.alpha = 1;
        case 14:
            makeTween(FlxTween.num(1,0.35, 0.75, {ease: FlxEase.cubeOut}, function(v:Float) {
                prevpanel.alpha = v;
            }));

            makeTween(FlxTween.num(0.6, 0.55, 1, {ease: FlxEase.cubeOut}, function(v:Float) {
                prevpanel.scale.x = v;
                prevpanel.scale.y = v;
            }));

            makeTween(FlxTween.num(0.65, 0.6, 0.35, {ease: FlxEase.elasticOut}, function(v:Float) {
               // panel.scale.x = v;
               // panel.scale.y = v;
            }));

            makeTween(FlxTween.num(0,1, 0.75, {ease: FlxEase.cubeOut}, function(v:Float) {
                panel.alpha = v;
            }));
        case 15:
            makeTween(FlxTween.num(0.35,0, 0.75, {ease: FlxEase.cubeOut}, function(v:Float) {
                preverpanel.alpha = v;
            }));

            makeTween(FlxTween.num(0.35, 0.3, 1, {ease: FlxEase.cubeOut}, function(v:Float) {
                preverpanel.scale.x = v;
                preverpanel.scale.y = v;
            }));

            makeTween(FlxTween.num(1,0.35, 0.75, {ease: FlxEase.cubeOut}, function(v:Float) {
                prevpanel.alpha = v;
            }));

            makeTween(FlxTween.num(0.4, 0.35, 1, {ease: FlxEase.cubeOut}, function(v:Float) {
                prevpanel.scale.x = v;
                prevpanel.scale.y = v;
            }));

            makeTween(FlxTween.num(0,1, 0.75, {ease: FlxEase.cubeOut}, function(v:Float) {
                panel.alpha = v;
            }));
        case 16:
            prevpanel.alpha = 0;
            panel.alpha = 1;
            panel.floatSprite([5,35,"c",0.0],[15,70,"s",0.0],[2,70,"s",45]);
    
            var theW = 0.4;
            var theH = 0.4;
            makeTween(FlxTween.num(0.3, 0.4, 0.285, {ease: FlxEase.elasticOut}, function (v) {
                theW = v;
            }));
    
            makeTween(FlxTween.num(0.5, 0.4, 0.285, {ease: FlxEase.elasticOut}, function (v) {
                theH = v;
                panel.scale.set(theW,theH);
            }));
        case 17:
            makeTween(FlxTween.num(0.35,0, 0.75, {ease: FlxEase.cubeOut}, function(v:Float) {
                prevererpanel.alpha = v;
            }));

            makeTween(FlxTween.num(0.35, 0.3, 1, {ease: FlxEase.cubeOut}, function(v:Float) {
                prevererpanel.scale.x = v;
                prevererpanel.scale.y = v;
            }));

            makeTween(FlxTween.num(1,0.35, 0.75, {ease: FlxEase.cubeOut}, function(v:Float) {
                prevpanel.alpha = v;
            }));

            makeTween(FlxTween.num(0.4, 0.35, 1, {ease: FlxEase.cubeOut}, function(v:Float) {
                prevpanel.scale.x = v;
                prevpanel.scale.y = v;
            }));

            panel.floatSprite([5,35,"c",0.0],[15,70,"s",0.0],[2,70,"s",45]);
    
            var theW = 0.4;
            var theH = 0.4;
            makeTween(FlxTween.num(0.3, 0.4, 0.285, {ease: FlxEase.elasticOut}, function (v) {
                theW = v;
            }));
    
            makeTween(FlxTween.num(0.5, 0.4, 0.285, {ease: FlxEase.elasticOut}, function (v) {
                theH = v;
                panel.scale.set(theW,theH);
            }));

            panel.alpha = 1;
        case 18:
 
            for (i in 0...panelNum) {
                panels[i].kill();
            }

            panel.scale.x *= 1.5;
            panel.scale.y *= 1.5;
            panel.setPosition(230, -258);
            panel.alpha = 1;

            makeTween(FlxTween.num(panel.y, 108, 3, {ease: FlxEase.cubeOut}, function(v:Float) {
                panel.y = v;
            }));
            makeTween(FlxTween.num(0, 1, 4, {ease: FlxEase.cubeOut}, function(v:Float) {
                panel.alpha = v;
            }));
            makeTween(FlxTween.num(panel.scale.x * 1.25, panel.scale.x*0.9, 3, {ease: FlxEase.cubeOut}, function(v:Float) {
                panel.scale.x = v;
                panel.scale.y = v;
            }));
        case 19:
            var transitionSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
            transitionSprite.alpha = 0;
            add(transitionSprite);

            makeTween(FlxTween.num(0, 1, 3, {ease: FlxEase.cubeOut}, function(v:Float) {
                transitionSprite.alpha = v;

                if (v == 1)
                    exit();
            }));

            canSpam = false;

            FlxG.sound.music.fadeOut(1);
        default:
            panel.alpha = 1;
    }

    panelNum++;

    if (!ignore)
        FlxG.sound.play('assets/sounds/pageFlip' + ".ogg", 1);
}

function onUpdate(elapsed:Float) {

    // if (FlxG.keys.justPressed.ONE)
    //     FlxG.resetState();

    debugText.text = "panel num: " + (panelNum-1);
    debugText.x = 0 - FlxG.camera.x;
    pressEnterText.x = 0 - FlxG.camera.x + 390;

    var back = FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.ESCAPE;

    if (!canSpam) return;

    if (FlxG.keys.justPressed.ENTER) {
        doPanelEvent();
    }

    if (back){
        FlxG.sound.play('assets/sounds/cancelMenu' + ".ogg");
        if (FlxG.sound.music != null)
            FlxG.sound.music.stop();

        var transitionSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        transitionSprite.alpha = 0;
        add(transitionSprite);

        FlxTween.num(0, 1, 3, {ease: FlxEase.cubeOut}, function(v:Float) {
            transitionSprite.alpha = v;

            if (v == 1)
                exit();
        });

        canSpam = false;
    }

    for (sprite in panels)
    {
        if (sprite.visible == false && sprite.customUpdate != null)
            sprite.customUpdate = null;
    }

    debugShit();
}

function maelShout() {

    var pos = [
        [706,80],
        [758,193],
        [766,304],
        [757,398],
        [751,484],
        [722,578],
    ];

    for (i in 1...7){
        var grah = new FlxSprite().loadGraphic(Paths.image('comic/Ai/new/r-' + i));
        add(grah);

        grah.alpha = 0;

        grah.scale.x = panels[1].scale.x;
        grah.scale.y = panels[1].scale.y;

        grah.updateHitbox();

        grahs.push(grah);

        grah.x = pos[i-1][0] -= 85;
        grah.y = pos[i-1][1];

        grah.shakeSprite(2, 2, 4);
    }
}

function setupPanels() {
    for (i in 0...19) {
        var panel = new FlxSprite().loadGraphic('assets/images/comic/Ai/new/' + i + '.png');
        add(panel);

        panel.scale.x *= 0.4;
        panel.scale.y *= 0.4;

        panel.updateHitbox();
        panel.screenCenter();
        panels.push(panel);

        panel.alpha = 0;

        if (i == 1)
        {
            maelShout();
            panel.x -= 85;
            panel.data = -85;
        }
    }

    object = panels[0];

    doPanelEvent();
}

var went = false;
function exit(){

    if (went)
        return;
    
    went=true;
    if (Objective.check('heartbreaker'))
    {
        var edialogueList:Array<String> = [
            ':dad:|aisurprised|Oh! Hey, BF! what are you doing here??',
            ':bf:|bf|beep (I want to play again.)',
            ':dad:|ailove|You came back for me? I\'m so glad to see you again!',
            ':dad:|aihehe|Uhhhh...hold on. let me restart the sim program!',
            ':dad:|blank|*RESTARTING LOVESTRUCK.EXE...*',
            ':dad:|ailove|Okay, here we go!',
        ];
    
        this.doof = new DialogueBox(false, edialogueList,false,true,'date/doof/replay/replay');
        this.doof.bgFade.visible = false;
        //this.doof.cameras = [camUI];
        this.doof.finishThing = function(){
            FlxG.switchState(new DateSimHscript(false,true));
        };
        add(this.doof);
    }
    else
    {
        FlxG.switchState(new DateSimHscript(false,false));
    }
    
}

function log(s:Dynamic) {
    FlxG.log.add(s);
    trace(s);
}

function debugShit(){
    if (object == null)
        return;

    var holdShift = FlxG.keys.pressed.SHIFT;
    var holdCtrl = FlxG.keys.pressed.CONTROL;
    var multiplier = 1;
    var valueset:Int = 1;
    var d = "";

    if (holdShift)
        multiplier = 10;
    if (holdCtrl)
        multiplier = 100;

    if (FlxG.keys.justPressed.J) {object.x -= (1 * multiplier);}
    if (FlxG.keys.justPressed.I){object.y -= (1 * multiplier);}
    if (FlxG.keys.justPressed.K){object.y += (1 * multiplier);}
    if (FlxG.keys.justPressed.L){object.x += (1 * multiplier);}
    if (FlxG.keys.justPressed.U){object.scale.x -= (0.1* multiplier);}
    if (FlxG.keys.justPressed.Y){object.scale.x += (0.1* multiplier);}
    if (FlxG.keys.justPressed.O){object.scale.y -= (0.1* multiplier);}
    if (FlxG.keys.justPressed.P){object.scale.y += (0.1* multiplier);}
    if (FlxG.keys.justPressed.SEMICOLON){
        log (object +" X: " + object.x);
        log (object +" Y: " + object.y);
        log (object +" SCALE X: " + object.scale.x);
        log (object +" SCALE Y: " + object.scale.y);
        //log ("defaultcamzoom: " + defaultCamZoom);
    }
}

function onUpdateEnd(elapsed:Float) {}
function onStepHit(step:Int) {}
function onStepHitEnd(step:Int) {}
function onBeatHit(beat:Int) {}
function onBeatHitEnd(beat:Int) {}