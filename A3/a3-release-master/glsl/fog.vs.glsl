#version 300 es

varying vec3 pos;
varying vec3 eyeNormal;

void main() {
    // TODO: PART 1D
    vec4 pos4 = modelViewMatrix * vec4(position, 1.0);
    pos = vec3(pos4) / pos4.w;
    eyeNormal = normalMatrix * normal;
    gl_Position = projectionMatrix * pos4;
}
