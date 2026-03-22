shader_type canvas_item;

uniform vec2 center = vec2(0.5, 0.5);
uniform float radius : hint_range(0.0, 2.0) = 1.0;
uniform float smoothness : hint_range(0.0, 0.0) = 0.0;
uniform float pixel_size : hint_range(1.0, 32.0) = 8.0;

void fragment() {
	vec2 uv = floor(SCREEN_UV * (1.0 / SCREEN_PIXEL_SIZE) / pixel_size) * pixel_size * SCREEN_PIXEL_SIZE;

	uv.x *= SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 c = center;
	c.x *= SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;

	float dist = distance(uv, c);
	float alpha = step(radius, dist);
	COLOR = vec4(0.0, 0.0, 0.0, alpha);
}