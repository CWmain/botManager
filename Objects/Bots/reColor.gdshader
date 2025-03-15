shader_type canvas_item;


const float EPSILON = 0.0001;
uniform vec4 original[4] : source_color;
uniform vec4 recolor[4] : source_color;

bool sameColor(vec4 a, vec4 b){
	for (int i = 0; i < 4; i++){
		if (!(a[i] >= b[i]-EPSILON && a[i] <= b[i]+EPSILON)){
			return false;
		}
	}
	return true;
}

void fragment() {
	
	for(int i = 0; i < original.length(); i++){
		if (sameColor(COLOR, original[i])){
			COLOR = recolor[i];
		}
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
