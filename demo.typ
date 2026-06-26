#import "@preview/gribouille:0.4.1": *

#plot(
  data: penguins,
  mapping: aes(x: "bill-len", y: "bill-dep", fill: "species"),
  layers: (
    geom-point(size: 2pt, colour: black, stroke: 0.5pt),
    annotate(
      "typst",
      x: 48.0,
      y: 13.0,
      label: [#box(inset: 8pt, fill: rgb("#ffd60a"), stroke: 2pt + rgb("#0b0b0b"))[_Typical_ Chinstrap]],
      anchor: "west",
      size: 24pt,
      clip: false
    ),
  ),
  // scales: (
  //   scale-colour-discrete(
  //     limits: ("Adelie", "Chinstrap", "Gentoo"),
  //     palette: comic-colours,
  //   ),
  // ),
  labels: labels(x: "Bill Length (mm)", y: "Bill Depth (mm)", colour: "Species"),
  // theme: theme-comic(),
  width: auto,
  height: auto,
)
