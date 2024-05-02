package shaders;

import flixel.graphics.tile.FlxGraphicsShader;
import openfl.display.GraphicsShader;

class FixedShader extends FlxGraphicsShader
{
	@:glVertexSource("
#pragma header

attribute float alpha;
attribute vec4 colorMultiplier;
attribute vec4 colorOffset;
uniform bool hasColorTransform;

void main(void)
{
	#pragma body

	openfl_Alphav = openfl_Alpha * alpha;

	if (hasColorTransform)
	{
		openfl_ColorOffsetv = colorOffset / 255.0;
		openfl_ColorMultiplierv = colorMultiplier;
	}
}")
	@:glFragmentHeader("
uniform vec4 _camSize;

float map(float value, float min1, float max1, float min2, float max2) {
	return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

vec2 getCamPos(vec2 pos) {
	vec4 size = _camSize / vec4(openfl_TextureSize, openfl_TextureSize);
	return vec2(map(pos.x, size.x, size.x + size.z, 0.0, 1.0), map(pos.y, size.y, size.y + size.w, 0.0, 1.0));
}
vec2 camToOg(vec2 pos) {
	vec4 size = _camSize / vec4(openfl_TextureSize, openfl_TextureSize);
	return vec2(map(pos.x, 0.0, 1.0, size.x, size.x + size.z), map(pos.y, 0.0, 1.0, size.y, size.y + size.w));
}
vec4 textureCam(sampler2D bitmap, vec2 pos) {
	return flixel_texture2D(bitmap, camToOg(pos));
}
vec4 textureCamNoFlx(sampler2D bitmap, vec2 pos) {
	return flixel_texture2D(bitmap, camToOg(pos));
}
")
	@:glFragmentSource("
#pragma header

void main(void)
{
	gl_FragColor = flixel_texture2D(bitmap, openfl_TextureCoordv);
}")
	public function new()
	{
		super();
	}

	public function setCamSize(x:Float, y:Float, width:Float, height:Float)
	{
		_camSize.value = [x, y, width, height];
	}

	/*override function __updateGL() {
		super.__updateGL();
		var w = FlxG.camera.width * FlxG.camera.initialZoom * FlxG.scaleMode.scale.x * FlxG.stage.window.scale;
		var h = FlxG.camera.height * FlxG.camera.initialZoom * FlxG.scaleMode.scale.y * FlxG.stage.window.scale;

		trace("Setting shader camera size to " + w + "x" + h);
		setCamSize(0, 0, w, h);
	}*/
}
