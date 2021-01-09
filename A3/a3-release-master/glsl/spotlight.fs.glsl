#version 300 es

precision highp float;
precision highp int;

uniform vec3 spotlightPosition;
uniform vec3 spotDirectPosition;

varying vec3 worldPos;

out vec4 out_FragColor;

void main() {
	// TODO: PART 1D
	float spotExponent = 5.0;
	float cutoffAngle = 30.0;
	vec3 color = vec3(0.0);
	vec3 SpotColor = vec3(0.4, 0.15, 1.0);

	vec3 centerV = spotDirectPosition - spotlightPosition;
	vec3 posV = worldPos - spotlightPosition;
	float cosAngle = dot(normalize(posV), normalize(centerV));

  	if (cosAngle >= cos(cutoffAngle)) {
    	color = SpotColor * pow(cosAngle, spotExponent);
	}

	out_FragColor = vec4(color, 1.0);
}