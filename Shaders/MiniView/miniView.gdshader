shader_type canvas_item;

uniform vec2 toTrack;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float zoom = 0.1;

void fragment() {
	vec2 resolution = 1.0/SCREEN_PIXEL_SIZE;
	vec2 zoom_uv = (UV * vec2(zoom)+(toTrack/resolution)-vec2(zoom/2.0));
	vec4 screenPixel = texture(screen_texture, zoom_uv);
	
	// If zoom takes you out of the texture display nothing
	if (zoom_uv.x <= 0.0 || zoom_uv.x >= 1.0 || zoom_uv.y <= 0.0 || zoom_uv.y >= 1.0){
		COLOR = vec4(0.0);	
	}
	else{
		COLOR = screenPixel;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
