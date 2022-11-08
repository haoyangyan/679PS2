let bar_ages = [],
generator = d3.randomUniform(0, 500),
id = 0;

d3.select("body")
  .select("#my_button")
  .on("mousedown", update)

function update() {
bar_ages = bar_ages.map(d => { return {id: d.id, age: d.age + 1, height: d.height }})
bar_ages.push({age: 0, height: generator(), id: id});
bar_ages = bar_ages.filter(d => d.age < 5)
id += 1;

  let selection = d3.select("svg")
    .selectAll("rect")
    .data(bar_ages, d => d.id)

  selection.enter()
    .append("rect")
    .attrs({
      width: 100,
      height: d => d.height,
      x: 0,
      y: d => 500 - d.height
    })

  d3.select("svg")
    .selectAll("rect")
    .transition()
    .duration(1000)
    .attrs({
      width: 100,
      height: d => d.height,
      x: d => (900 / 5) * d.age,
      y: d => 500 - d.height
    })

  selection.exit()
    .transition()
    .duration(1000)
    .attr("cy", 1000)
    .remove()
}
