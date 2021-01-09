#version 300 es

precision highp float;
precision highp int;

// uniform float time;

// While this uses the 'out' classifier it is not in fact a shared variable,
// what 'out' tells us is that the following variable will be output from the shader it is used in,
// for vertex shaders we may output shared variables,
// for fragment shaders we always output fragment colors
out vec4 out_FragColor; 

// HINT: YOU WILL NEED TO PASS IN THE CORRECT VARYING (SHARED) VARIABLE
in vec3 interpolatedNormal;

void main() {
  // float timeChange = sin(time)*sin(time);
  // vec3 colors = interpolatedNormal + sin(0.1*time)*sin(0.1*time);

  out_FragColor = vec4(normalize(interpolatedNormal), 1.0); // REPLACE ME

}