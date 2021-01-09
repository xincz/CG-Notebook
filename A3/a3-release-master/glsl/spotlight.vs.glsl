#version 300 es

varying vec3 worldPos;

void main() {
	// TODO: PART 1C
	vec4 worldPos4 = modelMatrix * vec4(position, 1.0);
	worldPos = vec3(worldPos4) / worldPos4.w;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}