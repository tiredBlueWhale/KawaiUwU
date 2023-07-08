shader_type canvas_item;

uniform vec4 color: source_color = vec4(1.0);
uniform float width = 5.0;

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * width;
	
	float outline_color = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
	outline_color += texture(TEXTURE, UV + vec2(0, size.y)).a;
	outline_color += texture(TEXTURE, UV + vec2(size.x, 0)).a;
	outline_color += texture(TEXTURE, UV + vec2(0, -size.y)).a;
	outline_color += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	outline_color += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	outline_color += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	outline_color += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	outline_color = min(outline_color, 1.0);
	
	vec4 texture_color = texture(TEXTURE, UV);
	COLOR = mix(texture_color, color, outline_color - texture_color.a);
}
