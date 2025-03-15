shader_type canvas_item;

uniform vec4 original[4] : source_color;
uniform vec4 recolor[4] : source_color;

void fragment() {
	for(int i = 0; i < 4; i++){
		if (COLOR == original[i]){
			COLOR = recolor[i];
		}
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
