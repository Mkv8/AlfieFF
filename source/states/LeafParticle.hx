package states;

import flixel.effects.particles.FlxParticle;

class LeafParticle extends FlxParticle {
    public static var maxHeight:Float = -1;
    
    public function new() {
        super();

        frames = Paths.getSparrowAtlas('leafParticles');
        angularVelocity = 5;

        if(maxHeight == -1) {
            for(frame in frames.frames) {
                if(frame.sourceSize.y > maxHeight)
                    maxHeight = frame.sourceSize.y;
            }
        }
    }

    public override function onEmit():Void {
        this.frame = this.frames.frames[FlxG.random.int(0, this.frames.frames.length - 1)];
    }
}