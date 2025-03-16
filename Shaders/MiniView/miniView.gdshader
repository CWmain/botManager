shader_type canvas_item;

uniform vec2 toTrack;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec2 resolution = 1.0/SCREEN_PIXEL_SIZE;
	vec4 screenPixel = texture(screen_texture, (UV * vec2(0.1,0.1)+(toTrack/resolution)-vec2(0.05,0.05)));
	COLOR = screenPixel;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
