#version 300 es

uniform float kAmbient;
uniform float kDiffuse;
uniform float fogDensity;
uniform vec3 ambientColor;
uniform vec3 lightColor;
uniform vec3 lightFogColor;
uniform vec3 lightDirection;

varying vec3 pos;
varying vec3 eyeNormal;

out vec4 out_FragColor;

void main() {
	// TODO: PART 1C
	vec3 n = normalize(eyeNormal);
	vec3 l = normalize(lightDirection);
	vec3 v = normalize(- pos);
	vec3 h = normalize(v + l);

	float dist = length(pos);
	float diffuse = max(0.0, dot(n, l));
	float fogLevel = 1.0 / exp(dist * fogDensity);
	vec3 light_AMB = kAmbient * ambientColor;
	vec3 light_DFF = kDiffuse * diffuse * lightColor;

	vec3 TOTAL = light_AMB + light_DFF;
	vec3 color = mix(lightFogColor, TOTAL, fogLevel); // linear blend
	
	out_FragColor = vec4(color, 1.0);
}
