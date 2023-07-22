#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

void mainImage( )
{
    // Convert gametime to a rotating value between 0 and 1
    float time = mod(iTime * 2.0, 5.0) / 5.0;
    // Calculate the UV coordinates
	vec2 uv = fragCoord.xy / iResolution.xy;
    
    // Get the rgba value at the current UV coordinate
    // of the transition texture
    vec4 transit = texture( iChannel0, uv );
    
    // If the b value of the transition texture at the
    // current UV coordinate is less than the current
    // 0-1 time value display the pixel as the transition color
    if (transit.b < 0.4) {
        // Set the current pixel to the transition color
        // In this case black
        fragColor = vec4(0, 0, 0, 1);
    } else {
        // Otherwise show the base pixel color
        fragColor = vec4(1, 0, 0, 1);

        //fragColor = texture( iChannel0, uv ); // <- Use the transition texture if it's a color image for an interesting transition effect.
    }
            
}