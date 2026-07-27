shader_type canvas_item;

uniform sampler2D palette_source;
uniform sampler2D palette_target;
uniform int palette_size = 26;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 out_color = color;

	// Only try to swap if visible
	if (color.a >= 0.1) {
		for (int i = 0; i < palette_size; i++) {
			float x = (float(i) + 0.5) / float(palette_size);

			vec4 src = texture(palette_source, vec2(x, 0.5));
			vec4 dst = texture(palette_target, vec2(x, 0.5));

			if (distance(color.rgb, src.rgb) < 0.01) {
				out_color = vec4(dst.rgb, color.a);
				break;
			}
		}
	}

	COLOR = out_color;
}