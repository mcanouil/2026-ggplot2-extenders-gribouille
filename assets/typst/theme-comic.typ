#import "@preview/gribouille:0.2.1": (
  theme-minimal, element-text, element-line, element-rect, element-blank,
)

/// Comic palette — matches quarto-revealjs-comic comic.scss CSS variables.
#let comic-ink    = rgb("#0b0b0b")
#let comic-paper  = rgb("#fdf6e3")
#let comic-red    = rgb("#e63946")
#let comic-yellow = rgb("#ffd60a")
#let comic-blue   = rgb("#1d4ed8")

/// Ordered discrete palette for scale-colour-discrete() / scale-colour-manual().
/// Maps: Adelie → red, Chinstrap → blue, Gentoo → yellow.
#let comic-colours = (comic-red, comic-blue, comic-yellow)

/// Comic title chip — yellow fill + ink border in the Bangers display font,
/// matching the slide heading chips and facet strip headers.
///
/// Gribouille renders the plot title as plain text (there is no
/// `title-background` theme surface), so pass this as the title value to give
/// it a bordered chip look:
///   labs(title: comic-title("Palmer Penguins"))
///
/// Self-contained (carries its own fill, stroke, and font) so it renders the
/// same whether or not the surrounding plot / compose uses theme-comic.
///
/// @param body  Title text or content.
/// @param fill  Chip fill colour. Default: comic-yellow.
/// @param ink   Border and text colour. Default: comic-ink.
#let comic-title(body, fill: comic-yellow, ink: comic-ink) = box(
  fill: fill,
  stroke: 3pt + ink,
  inset: (x: 0.5em, y: 0.25em),
)[#text(font: "Bangers", fill: ink)[#body]]

/// Comic-book theme for Gribouille plots.
///
/// Bold 3 pt panel border, no gridlines, bold axes, comic fonts.
/// Palette and visual style match the quarto-revealjs-comic slide theme so
/// embedded figures look native to the deck rather than imported.
///
/// @param ink    Foreground colour. Default: comic-ink (#0b0b0b).
/// @param paper  Panel fill colour. Default: comic-paper (#fdf6e3).
/// @param accent Accent colour (geom-smooth, etc.). Default: comic-red (#e63946).
/// @param ..fields Spot-overrides forwarded verbatim to theme-minimal().
///
/// @note Fonts: "Comic Neue" and "Bangers" are declared but the Typst compiler
///   falls back silently to New Computer Modern when they are not installed
///   locally. To enable them: place the .ttf files in fonts/ at the project
///   root and add `font-path: fonts` under `extensions.typst-render:` YAML key.
#let theme-comic(
  ink: comic-ink,
  paper: comic-paper,
  accent: comic-red,
  ..fields,
) = theme-minimal(
  ink: ink,
  // paper: auto (default) — outer figure canvas stays transparent so the
  // slide background shows through; only the inner panel is painted.
  accent: accent,
  // Inner panel: warm cream fill + thick ink border (the "comic panel frame").
  panel-background: element-rect(fill: paper, colour: ink, stroke: 3pt),
  // Bold axis lines and tick marks.
  axis-line: element-line(colour: ink, stroke: 2pt),
  axis-ticks: element-line(colour: ink, stroke: 1.5pt),
  tick-length: 0.2cm,
  // No gridlines — halftone slide background provides visual texture instead.
  panel-grid: element-blank(),
  // Comic fonts (silent fallback to New Computer Modern if absent).
  text: element-text(font: "Comic Neue"),
  plot-title: element-text(size: 13pt, weight: "bold", font: "Bangers"),
  axis-text: element-text(size: 8pt, weight: "bold"),
  axis-title: element-text(size: 9pt, weight: "bold"),
  // Facet strip headers: yellow fill + ink border matching the slide chrome.
  strip-background: element-rect(fill: comic-yellow, colour: ink, stroke: 1.5pt),
  strip-text: element-text(weight: "bold"),
  ..fields.named(),
)
