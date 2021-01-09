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
	//TOTAL INTENSITY
	//TODO PART 1E: calculate light intensity (ambient+diffuse+speculars' intensity term)
	// float lightIntensity = 0.0;

   	vec4 resultingColor = vec4(0.0,0.0,0.0,0.0);
   	//TODO PART 1E: change resultingColor based on lightIntensity (toon shading)

   	//TODO PART 1E: change resultingColor to silhouette objects

	vec3 n = normalize(eyeNormal);
	vec3 l = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));
	vec3 v = normalize(- pos);
	vec3 h = normalize(v + l);

	float specular = pow(max(0.0, dot(h, n)), shininess);
	float diffuse = max(0.0, dot(n, l));

	vec3 light_AMB = kAmbient * ambientColor;
	vec3 light_DFF = kDiffuse * diffuse * lightColor;
	vec3 light_SPC = kSpecular * specular * vec3(1.0, 1.0, 1.0);

	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	float lightIntensity = kAmbient + kDiffuse * diffuse + kSpecular * specular;
	if (lightIntensity > 1.3) {
		resultingColor = vec4(TOTAL, 1.0);
	} else if (lightIntensity > 0.9) {
		resultingColor = vec4(TOTAL*0.8, 1.0);
	} else if (lightIntensity > 0.5) {
		resultingColor = vec4(TOTAL*0.5, 1.0);
	} else {
		resultingColor = vec4(TOTAL*0.3, 1.0);
	}

	if (dot(n, v) <= 0.4) {
		resultingColor = vec4(vec3(0.0), 1.0);
	}

	out_FragColor = resultingColor;
}
