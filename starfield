<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Interactive Starfield</title>
<style>
  html, body {
    margin: 0;
    padding: 0;
    overflow: hidden;
    background: black;
    height: 100%;
  }
  canvas {
    display: block;
  }
</style>
</head>
<body>
<canvas id="starfield"></canvas>

<script>
const canvas = document.getElementById("starfield");
const ctx = canvas.getContext("2d");
let stars = [];
let mouse = { x: 0, y: 0 };
let width, height;

function resizeCanvas() {
  width = canvas.width = window.innerWidth;
  height = canvas.height = window.innerHeight;
}
window.addEventListener("resize", resizeCanvas);
resizeCanvas();

function createStars(count) {
  stars = [];
  for (let i = 0; i < count; i++) {
    stars.push({
      x: Math.random() * width - width / 2,
      y: Math.random() * height - height / 2,
      z: Math.random() * width,
      o: Math.random()
    });
  }
}

function drawStars() {
  ctx.fillStyle = "black";
  ctx.fillRect(0, 0, width, height);

  for (let star of stars) {
    let k = 128.0 / star.z;
    let sx = star.x * k + width / 2;
    let sy = star.y * k + height / 2;
    if (sx < 0 || sx >= width || sy < 0 || sy >= height) continue;
    let size = (1 - star.z / width) * 2;
    ctx.beginPath();
    ctx.arc(sx, sy, size, 0, Math.PI * 2);
    ctx.fillStyle = `rgba(255, 255, 255, ${star.o})`;
    ctx.fill();
  }
}

function updateStars() {
  // Calculate movement based on mouse position
  let dx = (mouse.x - width/2) / 100;
  let dy = (mouse.y - height/2) / 100;

  for (let star of stars) {
    star.x += dx;
    star.y += dy;
    star.z -= 2;
    if (star.z <= 0) {
      star.x = Math.random() * width - width / 2;
      star.y = Math.random() * height - height / 2;
      star.z = width;
    }
    // Wrap around if star goes out of bounds horizontally/vertically
    if (star.x > width/2) star.x = -width/2;
    if (star.x < -width/2) star.x = width/2;
    if (star.y > height/2) star.y = -height/2;
    if (star.y < -height/2) star.y = height/2;
  }
}

function animate() {
  updateStars();
  drawStars();
  requestAnimationFrame(animate);
}

canvas.addEventListener("mousemove", e => {
  mouse.x = e.clientX;
  mouse.y = e.clientY;
});

createStars(800);
animate();
</script>
</body>
</html>
