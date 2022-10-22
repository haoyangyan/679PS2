
let ix = d3.range(10)
let generator = d3.randomUniform(100, 900)
let u = ix.map(_ =>{ return {x: generator()} })

d3.select("svg")
  .selectAll("circle")
  .data(u).enter()
  .append("circle")
  .attrs({
    r: 10,
    // radius
    cx: d => d.x,
    cy: 100,
    // locations
    fill: "black"
    // color
  })

let jx = d3.range(10)
let v = jx.map(_ =>{ return {x: generator()} })
u = u.concat(v)
d3.select("svg")
  .selectAll("circle")
  .data(u)
  .join(
    enter => enter.append("circle")
      .attrs({
        r: 0,
        cx: d => d.x,
        cy: 100
      })
      .call(e => e.transition().duration(2000).attr("r", 10)),
      // radius changed from 0 to 10 after 1000ms duration
    update => update.call(e => e.transition().duration(2000).attr("r", 0))
    // for the first 10 circles, change to blue after 1000ms duration
  )


// Plot 10 black circles of radius 10. Then, for 13 locations, circles grows from radius 0 to 10. The first 10 circles' color change to blue.