#version 300 es

precision highp float;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;
uniform vec3 lightDirection;

varying vec3 pos;
varying vec3 eyeNormal;

out vec4 out_FragColor;

void main() {
	//TOTAL INTENSITY
	//TODO PART 1G: calculate light intensity
	// float lightIntensity = 0.0;

    vec4 resultingColor = vec4(0.0,0.0,0.0,0.0);

    //TODO PART 1G: Change resultingColor based on lightIntensity
    //              Use gl_FragCoord and mod() to find 
    //              which fragments should be shaded dark

   	//TODO PART 1G: change resultingColor to silhouette objects

	vec3 n = normalize(eyeNormal);
	vec3 l = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));
	vec3 v = normalize(- pos);
	vec3 h = normalize(v + l);

	float specular = pow(max(0.0, dot(h, n)), shininess);
	float diffuse = max(0.0, dot(n, l));

	vec3 TOTAL = vec3(1.0);
	vec3 pen = vec3(0.1, 0.0, 0.3);

	float lightIntensity = kAmbient + kDiffuse * diffuse + kSpecular * specular;
	vec2 coords =  gl_FragCoord.xy;
	float p = coords.x + coords.y;
	float m = coords.x - coords.y;
	if (lightIntensity > 1.25) {
		resultingColor = vec4(TOTAL, 1.0);
	} else if (lightIntensity > 0.8) {
		if (mod(p, 6.0) == 0.0) {
			resultingColor = vec4(pen, 1.0);
		}
	} else if (lightIntensity > 0.5) {
		if (mod(p, 6.0) == 0.0) {
			resultingColor = vec4(pen, 1.0);
		}
		if (mod(m, 6.0) == 0.0) {
			resultingColor = vec4(pen, 1.0);
		}
	} else {
		if (mod(p, 3.0) == 0.0) {
			resultingColor = vec4(pen, 1.0);
		}
		if (mod(m, 3.0) == 0.0) {
			resultingColor = vec4(pen, 1.0);
		}
	}

	if (dot(n, v) <= 0.4) {
		resultingColor = vec4(pen, 1.0);
	}

	out_FragColor = resultingColor;
}
