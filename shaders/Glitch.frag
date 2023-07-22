#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
vec2 barrelDistortion( vec2 p, vec2 amt )
{
    p = 2.0 * p - 1.0;

    float maxBarrelPower = sqrt(5.0);
    float radius = dot(p,p);
    p *= pow(vec2(radius), maxBarrelPower * amt);
	/* */

    return p * 0.5 + 0.5;
}

vec2 brownConradyDistortion(vec2 uv, float scalar)
{
    uv = (uv - 0.5 ) * 2.0;
    
    if( true )
    {
        float barrelDistortion1 = -0.02 * scalar; 
        float barrelDistortion2 = 0.0 * scalar; 

        float r2 = dot(uv,uv);
        uv *= 1.0 + barrelDistortion1 * r2 + barrelDistortion2 * r2 * r2;
    }

   return (uv / 2.0) + 0.5;
}


void mainImage(  ) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    
  float maxDistort = 1.5 * (1.0-1.0/iResolution.x);

  float scalar = 1.0 * maxDistort;
  vec4 colourScalar = vec4(700.0, 560.0, 490.0, 1.0);
  colourScalar /= max(max(colourScalar.x, colourScalar.y), colourScalar.z);
  colourScalar *= 2.0;
  
  colourScalar *= scalar;
  
  vec4 sourceCol = texture(iChannel0, uv);

  const float numTaps = 8.0;
  
  
  fragColor = vec4( 0.0 );
  for( float tap = 0.0; tap < numTaps; tap += 1.0 )
  {
      fragColor.r += texture(iChannel0, brownConradyDistortion(uv, colourScalar.r)).r;
      fragColor.g += texture(iChannel0, brownConradyDistortion(uv, colourScalar.g)).g;
      fragColor.b += texture(iChannel0, brownConradyDistortion(uv, colourScalar.b)).b;
      
      colourScalar *= 0.99;
  }
  
  fragColor /= numTaps;

  fragColor.a = 1.0;
}