float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;//Condensing this into one line
    vec4 texColor = texture(bitmap, uv);//Get the pixel at xy from bitmap
    
    float gt = 30.0;// + rand(vec2(iTime, iTime)) * 3.0;
    float m = mod(iTime, 1.0);
    bool glitch = m < 0.5;
    float t = floor(iTime * gt) / gt;
    float r = rand(vec2(t, t));
    
    if(glitch) {
		
        vec2 uvGlitch = uv;
        uvGlitch.x -= r / 5.0;
        if(uv.y > r && uv.y < r + 0.01) {
    		texColor = texture(bitmap, uvGlitch);
        }
    }
    
    fragColor = texColor;
	//fragColor = vec4(uv,0.5+0.5*sin(iTime),1.0);
}