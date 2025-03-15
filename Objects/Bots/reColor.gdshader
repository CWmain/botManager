shader_type canvas_item;


const float EPSILON = 0.0001;

uniform sampler2D original;
uniform sampler2D recolor;

bool sameColor(vec4 a, vec4 b){
	for (int i = 0; i < 4; i++){
		if (!(a[i] >= b[i]-EPSILON && a[i] <= b[i]+EPSILON)){
			return false;
		}
	}
	return true;
}

void fragment() {
	float start = 0.125; 
	for(int i = 0; i < 4; i++){
		vec4 baseC = texture(original, vec2(start + 0.25*float(i), 0.5));
		vec4 newC = texture(recolor, vec2(start + 0.25*float(i), 0.5));
		if (sameColor(COLOR, baseC)){
			COLOR = newC;
		}
	}
}
