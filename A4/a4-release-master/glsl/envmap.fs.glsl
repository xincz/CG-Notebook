#version 300 es

in vec3 vcsNormal;
in vec3 vcsPosition;

out vec4 out_FragColor;

uniform samplerCube skybox;
uniform vec3 lightDirection;
uniform mat4 matrixWorld;

void main( void ) {
  // Q4 : Calculate the vector that can be used to sample from the cubemap
  vec3 view = normalize(vcsPosition);
  vec3 reflection = reflect(view, normalize(vcsNormal));
  reflection = vec3(transpose(matrixWorld) * vec4(reflection, 1.0));
  
  out_FragColor = vec4(texture(skybox, reflection).rgb, 1.0);
}
