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
      x: Math.random() * width,
      y: Math.random() * height,
      z: Math.random() * width,
      o: Math.random()
    });
  }
}

function drawStars() {
  ctx.fillStyle = "black";
  ctx.fillRect(0, 0, width, height);

  ctx.fillStyle = "white";
  for (let star of stars) {
    let k = 128.0 / star.z;
    let sx = (star.x - width / 2) * k + width / 2;
    let sy = (star.y - height / 2) * k + height / 2;
    if (sx < 0 || sx >= width || sy < 0 || sy >= height) continue;
    let size = (1 - star.z / width) * 2;
    ctx.beginPath();
    ctx.arc(sx, sy, size, 0, Math.PI * 2);
    ctx.fillStyle = `rgba(255, 255, 255, ${star.o})`;
    ctx.fill();
