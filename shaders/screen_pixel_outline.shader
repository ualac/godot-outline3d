shader_type spatial;
render_mode unshaded;

uniform sampler2D ScreenTexture;
uniform vec4 OutlineColor : hint_color = vec4(1);

// turn the 2x2 quad vertex locations into screen positions
void vertex() 
{
	POSITION = vec4(VERTEX, 1.0);
}

void fragment()
{
	ALBEDO = OutlineColor.rgb;
	
	// read screen texture produced by the outline viewport
	vec4 screen_tex = texture( ScreenTexture, SCREEN_UV );
	
	// compute pixel size 
	float p_w = 1.0/ float(VIEWPORT_SIZE.x);
	float p_h = 1.0/ float(VIEWPORT_SIZE.y);
	
	// sample neighborhood around this fragment
	float neighbourhood = 0.0;
	neighbourhood += texture( ScreenTexture, SCREEN_UV+vec2( -p_w, 0.0 ) ).a;
	neighbourhood += texture( ScreenTexture, SCREEN_UV+vec2( +p_w, 0.0 ) ).a;
	neighbourhood += texture( ScreenTexture, SCREEN_UV+vec2( 0.0, -p_h ) ).a;
	neighbourhood += texture( ScreenTexture, SCREEN_UV+vec2( 0.0, +p_h ) ).a;
	
	// if our original fragment was transparent _but_ something was
	// in the immediate neighbourhood around that fragment we will
	// want to render as a solid pixel. this creates the outline.
	if ( screen_tex.a < 0.05 && neighbourhood > 0.0 )
	{
		ALPHA = 1.0;
	}
	else
	{
		ALPHA = 0.0;
	}
}
