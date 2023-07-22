#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

#define PI 3.14159265359
#define SAMPLES 20
#define MAG 0.01

void mainImage( )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
    //Animate the cat
    //----------------
    
    vec3 targetCol = vec3(sin(iTime), cos(iTime), 1.0); //The color of the outline
    
    vec4 finalCol = vec4(0);
    
    float rads = ((360.0 / float(SAMPLES)) * PI) / 180.0;	//radians based on SAMPLES
    
    for(int i = 0; i < SAMPLES; i++)
    {
        if(finalCol.w < 0.1)
        {
        	float r = float(i + 1) * rads;
    		vec2 offset = vec2(cos(r) * 0.1, -sin(r)) * MAG; //calculate vector based on current radians and multiply by magnitude
    		finalCol = texture(iChannel0, uv + offset);	//render the texture to the pixel on an offset UV
            if(finalCol.w > 0.0)
            {
                finalCol.xyz = targetCol;
            }
        }
    }
    
    vec4 tex = texture(iChannel0, uv);
    if(tex.w > 0.0)
    {
     	finalCol = tex;   //if the centered texture's alpha is greater than 0, set finalcol to tex
    }
    
	fragColor = finalCol;
}