#version 300 es

precision highp float;

uniform vec3 lightDirection;

uniform float gDiffuse;
uniform float gShininess;
uniform float blue;
uniform float yellow;
uniform float alpha;
uniform float beta;

varying vec3 pos;
varying vec3 eyeNormal;

out vec4 out_FragColor;

void main() {

	//TOTAL INTENSITY
	//TODO PART 1F: calculate light intensity
	// float lightIntensity = 0.0;

    vec4 resultingColor = vec4(0.0,0.0,0.0,0.0);

	//TODO PART 1F: compute cool and warm colors

   	//TODO PART 1F: change resultingColor based on lightIntensity 
	//              as an interpolation of cool and warm colors

   	//TODO PART 1F: change resultingColor to silhouette objects

	vec3 n = normalize(eyeNormal);
	vec3 l = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));
	vec3 v = normalize(- pos);
	vec3 h = normalize(v + l);

	vec3 kCool = vec3(0.0,0.0,blue) + alpha*gDiffuse;
	vec3 kWarm = vec3(yellow,yellow,0.0) + beta*gDiffuse;

	float coef = (1.0+dot(l,n))/2.0;
	vec3 colorIntensity = kCool*coef + kWarm*(1.0-coef);
	resultingColor = vec4(colorIntensity, 1.0);

	if (dot(n, v) <= 0.4) {
		resultingColor = vec4(vec3(0.0), 1.0);
	}

	out_FragColor = resultingColor;
}
