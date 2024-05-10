// To the extent possible under law,
// the author has waived all copyright and related or neighboring rights to this work.

float remap01( float t, float a, float b ) {
	return clamp( (t - a) / (b - a), 0.0, 1.0 );
}
vec2 remap01( vec2 t, vec2 a, vec2 b ) {
	return clamp( (t - a) / (b - a), 0.0, 1.0 );
}


const float gamma = 2.2;
vec3 lin2srgb( vec3 c )
{
	return pow( c, vec3(gamma) );
}
vec3 srgb2lin( vec3 c )
{
	return pow( c, vec3(1.0/gamma));
}


vec3 yCgCo2rgb(vec3 ycc)
{
	float R = ycc.x - ycc.y + ycc.z;
	float G = ycc.x + ycc.y;
	float B = ycc.x - ycc.y - ycc.z;
	return vec3(R,G,B);
}

vec3 spectrum_offset_ycgco( float t )
{
	//vec3 ygo = vec3( 1.0, 1.5*t, 0.0 ); //green-pink
	//vec3 ygo = vec3( 1.0, -1.5*t, 0.0 ); //green-purple
	vec3 ygo = vec3( 1.0, 0.0, -1.25*t ); //cyan-orange
	//vec3 ygo = vec3( 1.0, 0.0, 1.5*t ); //brownyello-blue
	return yCgCo2rgb( ygo );
}

vec2 brownConradyDistortion(vec2 uv, float dist)
{
	uv = uv * 2.0 - 1.0;
	float barrelDistortion1 = 0.1 * dist / 2.0;
	float barrelDistortion2 = -0.025 * dist / 2.0;

	float r2 = dot(uv,uv);
	uv *= 1.0 + barrelDistortion1 * r2 + barrelDistortion2 * r2 * r2;
	return uv * 0.5 + 0.5;
}

vec2 distort( vec2 uv, float t, vec2 min_distort, vec2 max_distort )
{
	vec2 dist = mix( min_distort, max_distort, t );
	return brownConradyDistortion( uv, 75.0 * dist.x );
}

vec3 spectrum_offset( float t )
{
  	return spectrum_offset_ycgco( t );
}


vec3 render( vec2 uv )
{
	return srgb2lin(texture( iChannel0, uv ).rgb );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy/iResolution.xy;

	const float MAX_DIST_PX = 50.0;
	float max_distort_px = MAX_DIST_PX * (1.0-0.6);//iMouse.x/iResolution.x);
	vec2 max_distort = vec2(max_distort_px) / iResolution.xy;
	vec2 min_distort = 0.5 * max_distort;

	vec2 oversiz = distort( vec2(1.0), 1.0, min_distort, max_distort );
	uv = remap01( uv, 1.0-oversiz, oversiz );

	const int num_iter = 7;
	const float stepsiz = 1.0 / (float(num_iter)-1.0);
	float t = 0.0;
	vec3 sumcol = vec3(0.0);
	vec3 sumw = vec3(0.0);
	for ( int i=0; i<num_iter; ++i )
	{
		vec3 w = spectrum_offset( t );
		sumw += w;
		vec2 uvd = distort(uv, t, min_distort, max_distort ); //TODO: move out of loop
		sumcol += w * render( uvd );
		t += stepsiz;
	}
	sumcol.rgb /= sumw;

	vec3 outcol = sumcol.rgb;
	outcol = lin2srgb( outcol );

	fragColor = vec4( outcol, 1.0);
}
