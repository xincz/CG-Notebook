#version 300 es

// Shared variable passed to the fragment shader
out vec3 color;

// UNIFORMS
uniform vec3 offsetWand;
uniform vec3 magicPosition;

void main() {
  // color
  color = vec3(1.0,0,0);

  vec3 up = vec3(0,1.0,0);
  vec3 ez = normalize(offsetWand - magicPosition);
  vec3 ex = normalize(cross(up, ez));
  vec3 ey = normalize(cross(ez, ex));
  mat4 LOOKAT = mat4(vec4(ex,0),vec4(ey,0),vec4(ez,0),vec4(0,0,0,1.0));

  mat4 S = mat4(1.0);
  S[1][1] = length(magicPosition - offsetWand);
  mat4 R = mat4(vec4(1.0,0,0,0),vec4(0,0,-1.0,0),vec4(0,1.0,0,0),vec4(0,0,0,1.0));
  mat4 T = mat4(vec4(1.0,0,0,0),vec4(0,1.0,0,0),vec4(0,0,1.0,0),vec4(offsetWand,1.0));

  // rotate -> lookat -> translate
  mat4 modelMatrix = T * LOOKAT * R * S;

  gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}