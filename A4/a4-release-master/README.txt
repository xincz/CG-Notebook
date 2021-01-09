Xinpei Li
89922496
c2e2b
xinpeili

Hi! These are some additional explanations regarding how I achieved the required features in this assignment.
However, as I'm currently in transition back to my home in China, I might not have enough time to explain what 
I have done with sufficient detail. I completed the code quite a while ago and now I'm writing the descriptions
based on my memory. If there's any thing lacking please contact me! Thanks!

Achieved features:
1. Floor texture mapping
Instead writing the shaders oneselves, we use the built-in THREE.js function MeshPhongMaterial to complete the
Bling-phong model in a convenient way, by just passing the uniform variables map (as color map), normalMap, and 
aoMap (ambient-occlusion). We use color map for the diffuse refluctance, normal map for simulating the bumps along
the surface, and aoMap for the ambient light.

2. Texture mapping using shaders
Shaders implemented for the wizard. We use the same Ambient + Diffuse + Specular as we have done in A3. We obtained
the corrected texture coordinates by using the UV with its vertical axis fliped, and then we use the right coordinates
to sample from the texture, and multiplied it with the diffuse.

3. Skybox
We loaded the images for the sides of the sky box in this order: "negx.png", "posx.png", "posy.png", "negy.png", 
"posz.png", "negz.png". We pass the skybox as a uniform of type samplerCube in the shaders. Then we sample it using
correct position calculated in the vertex shader.

4. Shiny objects
We pass in the same skybox uniform, then in the shader, we calculate the correct vec3 called reflection, and transform
it into world coordinates, and then use it to retrieve texture colors.

5. Shadow mapping
We only use the THREE.js to implement the shadow mapping. In A4.js, we set an appropriate zoom for the camera (0.5),
set the light to cast shadows, and set the sphere, the wizard, and the terrain to cast and receive shadows.