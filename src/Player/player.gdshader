shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform vec2 scroll = vec2(0.05, 0.05);

uniform vec4 albedoBG : source_color;
uniform float max_dist;
uniform vec2 player_pos;

//float random (vec2 uv) {
//    return fract(sin(dot(uv.xy,
//        vec2(12.9898,78.233))) * 43758.5453123);
//}

void fragment() {
//	float rand = random(UV);
	vec2 pos = vec2(0.5,0.5);
	if (distance(UV, pos) < max_dist) 
	{
		COLOR = vec4(0.0);
	}
	else 
	{
		vec4 noise_col = texture(noise, UV + scroll * TIME);
		COLOR = albedoBG + noise_col;
		COLOR.a = 0.5;
	}

//	vec4 noise_col = texture(noise, UV + scroll * TIME);

	
}