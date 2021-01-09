#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;
in vec2 vcsTexcoord;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform sampler2D colorMap;
uniform sampler2D normalMap;

// List textures are passed in as uniforms

void main() {
	vec3 N = normalize(vcsNormal);
	vec3 L = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));
	vec3 V = normalize(- vcsPosition);
	vec3 H = normalize(V + L);

	vec3 light_AMB = kAmbient * ambientColor;
	vec3 light_DFF = kDiffuse * max(0.0, dot(N, L)) * lightColor * texture(colorMap, vcsTexcoord).rgb;
	vec3 light_SPC = kSpecular * lightColor * pow(max(0.0, dot(H, N)), shininess);

	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	out_FragColor = vec4(TOTAL, 1.0);
}
