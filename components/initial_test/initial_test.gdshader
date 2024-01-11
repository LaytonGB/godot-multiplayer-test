shader_type canvas_item;

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV * 2.0);
    COLOR = vec4(0.1, 0.3, 1.0, 1.0);
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
