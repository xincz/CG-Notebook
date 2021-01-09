#version 300 es

precision highp float;
precision highp int;

out vec4 out_FragColor;

in vec3 color;

void main() {
  // Setting final pixel color
  out_FragColor = vec4(color, 1.0);
}