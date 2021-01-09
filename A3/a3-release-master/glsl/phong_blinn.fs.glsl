#version 300 es

precision highp float;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;
uniform vec3 ambientColor;
uniform vec3 lightColor;
uniform vec3 lightDirection;

varying vec3 pos;
varying vec3 eyeNormal;

out vec4 out_FragColor;

void main() {
	// TODO: PART 1A
	vec3 n = normalize(eyeNormal);
	// Change the lightDirection from world frame to view frame
	vec3 l = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));
	vec3 v = normalize(- pos);
	vec3 h = normalize(v + l);

	float diffuse = max(0.0, dot(n, l)); // Lambertian
	float specular = pow(max(0.0, dot(h, n)), shininess);

	// AMBIENT, DIFFUSE, SPECULAR
	vec3 light_AMB = kAmbient * ambientColor;
	vec3 light_DFF = kDiffuse * diffuse * lightColor;
	vec3 light_SPC = kSpecular * specular * vec3(1.0);

	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	out_FragColor = vec4(TOTAL, 1.0);
}