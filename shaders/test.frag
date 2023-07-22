

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 resolution = iResolution.xy;
    vec2 uv = fragCoord / resolution;

    vec4 texColor = texture(iChannel0, uv);

    float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));

    vec3 black = vec3(0.0, 0.0, 0.0);
    vec3 red = vec3(1.0, 0.0, 0.0);

    vec3 finalColor = mix(black, red, step(1.5, gray));
    fragColor = vec4(finalColor, 1.0);
}