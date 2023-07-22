#pragma header

float intensity = 1;
varying vec2 v_texCoord;
uniform sampler2D u_texture;

void main()
{
    vec2 uv = openfl_TextureCoordv.xy;
    vec4 texColor = texture2D(bitmap, uv);
    float grayscale = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));
    vec3 finalColor = vec3(1 - intensity * grayscale, 0.0, 0.0);
    gl_FragColor = vec4(finalColor, texColor.a);
}


