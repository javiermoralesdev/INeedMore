shader_type canvas_item;

uniform vec2 motion = vec2(100.0, 0.0);
uniform float scale = 1.0;
uniform vec2 offset = vec2(0.0);

void fragment() {
	vec2 uv = (UV / TEXTURE_PIXEL_SIZE + offset + TIME * motion) * TEXTURE_PIXEL_SIZE * (1.0 / scale);
    COLOR = texture(TEXTURE, uv);
}