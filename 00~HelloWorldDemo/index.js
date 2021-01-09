// Check WebGL version
if (WEBGL.isWebGL2Available() === false) {
    document.body.appendChild(WEBGL.getWebGL2ErrorMessage());
}

// Setup renderer
let canvas = document.createElement("canvas");
let context = canvas.getContext("webgl2");
let renderer = new THREE.WebGLRenderer({ canvas: canvas, context: context });
renderer.setClearColor(0xffffff);  // white background color
document.body.appendChild(renderer.domElement);

// Scene
let scene = new THREE.Scene();

// World coordinate frame: other objects are defined with respect to it
let worldFrame = new THREE.AxesHelper(5);
scene.add(worldFrame);

// Floor
let floorTexture = new THREE.TextureLoader().load('images/checkerboard.jpg');
floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping;
floorTexture.repeat.set(2, 2);
// No shader material
// let floorMaterial = new THREE.ShaderMaterial({
//     map: floorTexture,
//     side: THREE.DoubleSide
// });
// Simple shader material
let floorMaterial = new THREE.ShaderMaterial({
    side: THREE.DoubleSide,
    vertexShader: document.getElementById('vertexShader').textContent,
    fragmentShader: document.getElementById('fragmentShader').textContent,
    uniforms: {
        colorMap: { type: "t", value: floorTexture }
    }
});

let floorGeometry = new THREE.PlaneBufferGeometry(30, 30);
let floor = new THREE.Mesh(floorGeometry, floorMaterial);
floor.position.y = -0.1;
floor.rotation.x = Math.PI / 2;
scene.add(floor);
floor.parent = worldFrame;

// Earth
let earthGeometry = new THREE.SphereGeometry(5, 32, 32);
// Basic material
// let earthMaterial = new THREE.MeshPhongMaterial({ color: 0xff0000, wireframe: false });
// Textured material
let earthColorTexture = new THREE.TextureLoader().load("images/earthmap1k.jpg");
let earthBumpTexture = new THREE.TextureLoader().load("images/earthbump1k.jpg");
let earthMaterial = new THREE.MeshPhongMaterial({
    map: earthColorTexture,
    bumpMap: earthBumpTexture
});
let earth = new THREE.Mesh(earthGeometry, earthMaterial);
earth.position.set(0, 5, 0);
scene.add(earth);

// Lights
let pointLight = new THREE.PointLight(0xffffff);
pointLight.position.set(-70, 100, -70);
scene.add(pointLight);

// Camera
let camera = new THREE.PerspectiveCamera(30, 1, 0.1, 1000);  // view angle, aspect ratio, near, far
// let camera = new THREE.OrthographicCamera(-10, 10, 10, -10, 1, 1000);  // l, r, t, b, n, f
// camera.position.set(10, 15, 40);
camera.position.set(-10, 15, -40);
camera.lookAt(scene.position);
scene.add(camera);

// Setup orbit control of the camera
let controls = new THREE.OrbitControls(camera, renderer.domElement);
controls.damping = 0.2;

// Adapt to window resize
function resize() {
    renderer.setSize(window.innerWidth, window.innerHeight);
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
}
window.addEventListener('resize', resize);
resize();

// Input
let keyboard = new THREEx.KeyboardState();
function checkKeyboard() {
    if (keyboard.pressed("A"))
        pointLight.position.x += 10.0;
    if (keyboard.pressed("D"))
        pointLight.position.x -= 10.0;
    if (keyboard.pressed("W"))
        pointLight.position.y += 10.0;
    if (keyboard.pressed("S"))
        pointLight.position.y -= 10.0;
}

// Setup update callback
function update() {
    checkKeyboard();
    requestAnimationFrame(update);
    renderer.render(scene, camera);
}
update();
