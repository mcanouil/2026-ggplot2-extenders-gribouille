# The Grammar of Graphics Assembles

A talk for the ggplot2 extenders club on **Gribouille**, a native Typst grammar-of-graphics package.

View the slides: <https://m.canouil.dev/2026-ggplot2-extenders-gribouille/>.

## Abstract

The grammar of graphics is a stable vocabulary that keeps travelling across runtimes.
It started in R with ggplot2, was ported to Python as plotnine, and reaches databases through ggsql.
The question is never what the API should look like, only how to wire it to a new backend.

Gribouille brings that grammar natively to Typst.
A plot is built from `data`, `aes()`, layers, scales, facets, and themes, then compiled inside the Typst engine itself.
No R session, no Python environment, no SVG import.
Because the figure and the surrounding prose are compiled in the same pass, they share one font system, one colour palette, and one layout.

The figures in this talk are produced with [`quarto-typst-render`](https://github.com/mcanouil/quarto-typst-render), which compiles `{typst}` code blocks to images in any Quarto output format.

## Links

- Slides: <https://m.canouil.dev/2026-ggplot2-extenders-gribouille/>.
- Gribouille on Typst Universe: `@preview/gribouille` (<https://typst.app/universe/package/gribouille>).
- Gribouille documentation: <https://m.canouil.dev/gribouille>.
- Gribouille source: <https://github.com/mcanouil/gribouille>.
- Quarto Typst Render source: <https://github.com/mcanouil/quarto-typst-render>.

## Licence

This work is licensed under [CC BY-NC-SA 4.0](LICENSE).
