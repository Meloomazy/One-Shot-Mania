#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
void mainImage(  )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
    
    float magnitude = 0.01;
    
    vec3 color = texture(iChannel0, uv).rgb;
    color += texture(iChannel0, uv+vec2(sin(iTime*2.0)*magnitude - cos(iTime)*magnitude, 0.)).rgb;
    
    
    color /= 2.0;
    fragColor = vec4(color, 1.0);
}