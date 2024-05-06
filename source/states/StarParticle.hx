package states;

import flixel.effects.particles.FlxParticle;

class StarParticle extends FlxParticle {
    public static var maxHeight:Float = -1;
    
    public function new() {
        super();

        frames = Paths.getSparrowAtlas('star');
        //angularVelocity = 45;

        if(maxHeight == -1) {
            for(frame in frames.frames) {
                if(frame.sourceSize.y > maxHeight)
                    maxHeight = frame.sourceSize.y;
            }
        }
    }

    public override function onEmit():Void {
        this.frame = this.frames.frames[FlxG.random.int(0, this.frames.frames.length - 1)];
        angularVelocity = FlxG.random.float(30, 80);
    }
}