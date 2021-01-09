#version 300 es

// Shared variable passed to the fragment shader
out vec3 color;

// HINT: YOU WILL NEED TWO UNIFORMS
uniform vec3 offset;
uniform vec3 magicPosition;

#define MAX_EYE_DEPTH 0.05

void main() {
  // Simple way to color the pupil where there is a concavity in the sphere
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);

  mat4 S = mat4(0.5);
  S[3][3] = 1.0;

  // YOUR CODE STARTS HERE: translate and rotate eyes corresponding to the movement of magic circle 
  // HINT: ROTATE THE EYES FIRST TO FACE FORWARD
  // HINT: LOOKAT MATRIX WILL BE HELPFUL
  // HINT: ORDER OF MULTIPLICATION WILL BE IMPORTANT
  mat4 R = mat4(vec4(1.0,0,0,0),vec4(0.0,0.0,-1.0,0.0),vec4(0.0,1.0,0.0,0.0),vec4(0,0,0,1.0));
  
  vec3 up = vec3(0,1.0,0);
  vec3 ez = normalize(offset - magicPosition);
  vec3 ex = normalize(cross(up, ez));
  vec3 ey = normalize(cross(ez, ex)); // need to update the up vector
  mat4 LOOKAT = mat4(vec4(ex,0),vec4(ey,0),vec4(ez,0),vec4(0,0,0,1.0));

  mat4 T = mat4(vec4(1.0,0,0,0),vec4(0,1.0,0,0),vec4(0,0,1.0,0),vec4(offset,1.0));

  // rotate -> lookat -> translate
  mat4 modelMatrix = T * LOOKAT * R * S; // right first then left!!!

  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
  gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
