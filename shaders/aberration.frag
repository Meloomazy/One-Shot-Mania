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
    vec3 refractiveIndex = vec3(1.0, 1.015, 1.03);
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 normalizedTexCoord = vec2(2.0, 2.0) * uv - vec2(1.0, 1.0);    // [0, 1] -> [-1, 1]
    vec3 texVec = vec3(normalizedTexCoord, 1.0);
    vec3 normalVec = vec3(0.0, 0.0, -1.0);
    vec3 redRefractionVec = refract(texVec, normalVec, refractiveIndex.r);
    vec3 greenRefractionVec = refract(texVec, normalVec, refractiveIndex.g);
    vec3 blueRefractionVec = refract(texVec, normalVec, refractiveIndex.b);
    vec2 redTexCoord = ((redRefractionVec / redRefractionVec.z).xy + vec2(1.0, 1.0)) / vec2(2.0, 2.0);
    vec2 greenTexCoord = ((greenRefractionVec / greenRefractionVec.z).xy + vec2(1.0, 1.0)) / vec2(2.0, 2.0);
    vec2 blueTexCoord = ((blueRefractionVec / blueRefractionVec.z).xy + vec2(1.0, 1.0)) / vec2(2.0, 2.0);
    
    fragColor = vec4
    (
        texture(iChannel0, redTexCoord).r, 
        texture(iChannel0, greenTexCoord).g, 
        texture(iChannel0, blueTexCoord).b, 
        1.0
    );
}