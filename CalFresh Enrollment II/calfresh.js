function update_series(ev, flat_data, delaunay, scales) {
  let ix = delaunay.find(ev.pageX, ev.pageY);
  d3.select("#series")
    .selectAll("path")
    .attrs({
      stroke: e => e[0].Date_string == flat_data[ix].Date_string ? "red" : "#a8a8a8",
      "stroke-width": e => e[0].Date_string == flat_data[ix].Date_string ? "4px" : "1px"
    })

  d3.select(ev.target).raise()
  d3.select("#tooltip text")
    .attr("transform", `translate(${scales.x(flat_data[ix].time_of_day) + 5}, ${scales.y(data[ix].Demand) - 5})`)
    .text(data[ix].Date_string)
}
