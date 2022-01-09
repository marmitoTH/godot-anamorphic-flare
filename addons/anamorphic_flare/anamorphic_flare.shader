shader_type spatial;

uniform float THRESHOLD : hint_range(0.0, 1.0) = 0.8;
uniform float INTENSITY : hint_range(0.0, 1.0) = 0.5;
uniform vec4 TINT : hint_color = vec4(0.5, 0.5, 0.5, 1.0);

const int iterations = 64;
const float lod = 2.0;

void vertex() {
	POSITION = vec4(VERTEX, 1.0);
}

vec4 read_texture(sampler2D tex, vec2 uv) {
	vec4 c = textureLod(tex, uv, lod);
	float br = max(c.r, max(c.g, c.b));
	return c * max(0, br - THRESHOLD) / max(br, 1e-5);
}

vec4 stretch(sampler2D tex, vec2 uv) {
	vec4 c = vec4(0.0);
	float dx = 1.0 / float(textureSize(tex, 0).x) * 10.0;
	
	for (int i = 0; i < iterations; i++) {
		float intensity = float(iterations - i) / float(iterations) * INTENSITY;
		c += read_texture(tex, vec2(uv.x + dx * float(i), uv.y)) * intensity;
		c += read_texture(tex, vec2(uv.x - dx * float(i), uv.y)) * intensity;
	}
	
	return c / float(iterations);
}

void fragment() {
	vec4 c = stretch(SCREEN_TEXTURE, SCREEN_UV) * TINT;
	vec4 result = texture(SCREEN_TEXTURE, SCREEN_UV) + c;
	ALBEDO = result.rgb;
}
