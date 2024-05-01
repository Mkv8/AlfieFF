package shaders;

import haxe.Timer;
import flixel.system.FlxAssets.FlxShader;

class PostProcessing extends FlxShader {
	@:glFragmentSource('
#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

void mainImage()
{
	vec2 q = fragCoord.xy / iResolution.xy;

	vec3 col = texture( iChannel0, uv ).xyz;

	col = clamp(col*0.5+0.5*col*col*1.2,0.0,1.0);

	col *= clamp(0.7 + 0.85*16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y), 0.0, 1.0); // vignette

	//col *= vec3(0.95,1.05,0.95);

	col *= 0.9+0.1*sin(uv.y*1000.0); // scan lines

	//col *= 0.99+0.01*sin(110.0*iTime);

	//float comp = smoothstep( 0.2, 0.7, sin(iTime) );
	//col = mix( col, oricol, clamp(-2.0+2.0*uv.x+3.0*comp,0.0,1.0) );

	fragColor = vec4(col,1.0);
}')
	public function new() {
		super();

		this.bitmap.wrap = CLAMP;
	}

	override function __updateGL() {
		super.__updateGL();
	}
}
