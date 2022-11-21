const body = document.querySelector('body')

const VELOCITY    = 0.015
const BENDING     = 0.0001
const INTENSITY   = 150
let last = performance.now()
let mX = window.innerWidth / 2
let snowflakes = []

function create(maxNegative){
    let snowflake = document.createElement('div')
    body.appendChild(snowflake)
    snowflake.innerHTML = '&bull;'
    snowflake.classList.add('snow')
    snowflake.style.fontSize = (10 + Math.floor(Math.random() * 20)) + 'px'
    snowflake.style.top = (-50 - Math.floor(Math.random() * maxNegative)) + 'px'
    snowflake.style.left = (-0.2 * window.innerWidth + Math.floor(Math.random() * 1.4 * window.innerWidth)) + 'px'
    snowflakes.push(snowflake)
}

function animate(){
    let now = performance.now()
    let dt = now - last
    update(dt)
    last = now
    requestAnimationFrame(animate)
}

function update(dt){
    let w = window.innerWidth
    while (snowflakes.length < INTENSITY) create(100);
    for (let snowflake of snowflakes){
        let x = parseFloat(snowflake.style.left.slice(0, -2))
        let y = parseInt(snowflake.style.top.slice(0, -2))
        let s = parseInt(snowflake.style.fontSize.slice(0, -2))
        x += BENDING * (mX - w/2) * dt
        y += Math.round(VELOCITY * (40 - s) * dt)
        snowflake.style.left = x + 'px'
        snowflake.style.top = y + 'px'
        if (y >= window.innerHeight) body.removeChild(snowflake)
    }
    snowflakes = snowflakes.filter((s) => s.style.top.slice(0, -2) < window.innerHeight)
}

document.addEventListener("DOMContentLoaded", function(){
    while (snowflakes.length < INTENSITY) create(window.innerHeight);
    requestAnimationFrame(animate)
    document.addEventListener('mousemove', (e) => mX = e.clientX)
});