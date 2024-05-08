package shaders;

import flixel.system.FlxAssets.FlxShader;

class CurveShader extends FlxShader
{
	@:glFragmentSource('
#pragma header

uniform float uEffect;
uniform float uOriginX;
uniform float uOriginY;
uniform float uChromOff;
uniform float uZoom;

vec2 getCurvedUV(vec2 uv) {
	// center
	uv.xy -= vec2(uOriginX, uOriginY);
	vec2 uv2 = uv;
	
	float dd2 = dot(uv2, uv2);

	uv2 = (uv2 * dd2) * (-uEffect) + uv2 * 1.0;

	uv2 *= uZoom;

	uv2 += vec2(uOriginX, uOriginY);

	return uv2;
}

vec4 offsetColor(float offset)
{
	return texture2D(bitmap, getCurvedUV(openfl_TextureCoordv.xy - vec2(offset, 0)/openfl_TextureSize.xy));
}

void main()
{
	vec4 base = offsetColor(0.0);
	base.r = offsetColor(-uChromOff).r;
	//base.g = offsetColor(0.0).g;
	base.b = offsetColor(uChromOff).b;

	gl_FragColor = base;
}')

	public function new()
	{
		super();

		this.uEffect.value = [0.0];
		this.uOriginX.value = [0.5];
		this.uOriginY.value = [0.5];
		this.uChromOff.value = [0.0];
		this.uZoom.value = [1.0];

		resetParams();
	}

	public function resetParams() {
		effect = 0;
		originX = 0.5;
		originY = 0.5;
		chromOff = 0;
		zoom = 1;
	}

	public var effect(get, set):Float;

	function get_effect() {
		return this.uEffect.value[0];
	}
	function set_effect(val:Float) {
		this.uEffect.value[0] = val;
		return val;
	}
	public var originX(get, set):Float;

	function get_originX() {
		return this.uOriginX.value[0];
	}
	function set_originX(val:Float) {
		this.uOriginX.value[0] = val;
		return val;
	}
	public var originY(get, set):Float;

	function get_originY() {
		return this.uOriginY.value[0];
	}
	function set_originY(val:Float) {
		this.uOriginY.value[0] = val;
		return val;
	}
	public var chromOff(get, set):Float;

	function get_chromOff() {
		return this.uChromOff.value[0];
	}
	function set_chromOff(val:Float) {
		this.uChromOff.value[0] = val;
		return val;
	}
	public var zoom(get, set):Float;

	function get_zoom() {
		return this.uZoom.value[0];
	}
	function set_zoom(val:Float) {
		this.uZoom.value[0] = val;
		return val;
	}
}