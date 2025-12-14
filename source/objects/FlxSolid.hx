package objects;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;


class FlxSolid extends FlxSprite
{
	override function makeGraphic(Width: Int, Height: Int, Color: FlxColor = FlxColor.WHITE, Unique: Bool = false, ?Key: String): FlxSolid
	{
		return cast super.makeGraphic(Width, Height, Color, Unique, Key);
	}

	public function makeSolid(Width: Int, Height: Int, Color: FlxColor = FlxColor.WHITE, Unique: Bool = false, ?Key: String): FlxSolid
	{
		var graph: FlxGraphic = FlxG.bitmap.create(1, 1, Color, Unique, Key);
		frames = graph.imageFrame;
		scale.set(Width, Height);
		updateHitbox();
		return this;
	}

	public inline function hide(): Void
	{
		alpha = 0.0001;
	}

	public inline function show(): Void
	{
		alpha = 1;
	}
}
