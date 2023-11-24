shader_type spatial;

global uniform sampler2D heightmap;
global uniform sampler2D normalmap;
global uniform float amplitude;

varying vec2 texture_position;

void vertex() {
	vec3 world_vertex = VERTEX + MODEL_MATRIX[3].xyz;
	texture_position = world_vertex.xz/float(textureSize(heightmap, 0).x);
	VERTEX.y = texture(heightmap, texture_position).r * amplitude;
	
}

void fragment() {
	// Place fragment code here.
	NORMAL_MAP = texture(normalmap, texture_position).rgb;
}
