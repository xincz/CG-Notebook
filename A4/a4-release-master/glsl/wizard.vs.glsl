#version 300 es

out vec3 vcsPosition;
out vec3 vcsNormal;
out vec2 vcsTexcoord;

void main() {
	// write here the required lighting calculations for blinn phong 
    vcsNormal = normalMatrix * normal;
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));

    // Q2 : Assign texture coordinates to the texCoord variable. Remember the texture for Shay D Pixel(our wizard)
    // is flipped along the vertical axis. 
    // WRITE YOUR CODE HERE
    vcsTexcoord = vec2(uv.s, 1.0-uv.t); // flip the vertical axis

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
 }