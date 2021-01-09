#version 300 es

// Shared variable passed to the fragment shader
varying vec3 color;
out vec3 interpolatedNormal;

uniform float nodAngle;

void main() {

    vec3 wpos = position;
	vec3 rnormal = interpolatedNormal;
    interpolatedNormal = normal;

    // These condition already checks if the vertices are part of the armadillo's head
    // HINT : use the color variable in the fragment to verify the location of vertices
    
	// Find the armadillo's head axis-aligned box.
	float color1 = position.z > 1.53 ? 1.0 : 0.0 ; // 1.28
    float color2 = position.y > 5.0 ? 1.0 : 0.0 ; // 5.5
    float color3 = abs(position.x) < 2.46 ? 1.0 : 0.0;

    // HINT TO FIND A AXIS ALIGNED BOUNDING BOX
    
    if (color1 == 0.0 && color2 == 0.0 && color3 == 0.0) {
        color = vec3(0.0);
    }
    if (color1 == 1.0 && color2 == 1.0 && color3 == 1.0) {
        color = vec3(1.0);
    }

    // Origin of the armadillo's neck coordinate frame
	vec3 o_neck = vec3(0.0, 6.5, 1.28); // offset of neck

    mat4 R = mat4(vec4(1.0,0,0,0),vec4(0,cos(nodAngle),sin(nodAngle),0),vec4(0,-sin(nodAngle),cos(nodAngle),0),vec4(0,0,0,1.0));
       
    // WRITE CODE HERE FOR PART 2, Q1
    // HINT 1 : Find the vector from the current vertex to the origin of the neck and construct a rotation matrix for the vector
    // HINT 2 : Apply rotation only to the vertices of the head.

    vec4 fposition;
    if (color == vec3(1.0)) {
        fposition = R * vec4((position - o_neck), 1.0) + vec4(o_neck, 0);
    } else {
        fposition = vec4(position, 1.0);
    }

    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
    gl_Position = projectionMatrix * modelViewMatrix * fposition;
}
