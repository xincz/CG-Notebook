#version 300 es

precision highp float;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;
uniform vec3 lightColor;
uniform vec3 lightDirection;
uniform vec3 tangentDirection;

varying vec3 pos;
varying vec3 eyeNormal;

out vec4 out_FragColor;

void main() {
	//TODO: PART 1B
	vec3 n = normalize(eyeNormal);
	vec3 l = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));
	vec3 v = normalize(- pos);
	vec3 h = normalize(v + l);
	vec3 t = normalize(cross(eyeNormal, tangentDirection));

	float nl = dot(n, l); // those are for diffuse
	float diffuse = max(0.0, kDiffuse*nl+1.0-kDiffuse);
	float vv = dot(t, h);
	float specular = pow(1.0 - vv*vv, shininess);

	// Where ADS?
	vec3 TOTAL = lightColor*diffuse + kSpecular*specular;

	out_FragColor = vec4(TOTAL, 1.0);
}
