#pragma header

uniform float FlashIntensity;
void main()
{
    vec2 iResolution = openfl_TextureSize;
    vec2 uv = openfl_TextureCoordv.xy;

    vec4 original = texture2D(bitmap,uv)*vec4(0.5,1.,1.,1.);
    vec4 colors = texture2D(bitmap,uv);
    float lll = length(original.rgb);
    vec3 custom;
    if (lll >= 0.55) {
        custom = vec3(colors.r*(5./(FlashIntensity*5.)),colors.g*FlashIntensity,colors.b*FlashIntensity);
    } else {
        custom = vec3(colors.rgb)*FlashIntensity;
    }
    vec4 color = vec4(custom,original.a);
    gl_FragColor = color;
}