#!/usr/bin/env bash
set -euo pipefail

# Capture the title slide (slide 1) as a 300dpi PNG social card.
#
# decktape exposes no DPI option and ignores Chrome's device scale factor
# (it forces deviceScaleFactor=1). To raise resolution the viewport itself
# is scaled: Reveal re-renders the slide to fill the larger viewport, so
# text and vectors stay crisp.
#
# The card baseline is 1280x640 (CSS 96dpi, 2:1). At 300dpi it scales by
# 300 / 96 = 3.125 -> 4000x2000 px. The DPI metadata is then written so the
# file reports 300dpi.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"

SLIDES_PATH="${SLIDES_PATH:-index}"
DPI="${DPI:-300}"
BASE_WIDTH=1280
BASE_HEIGHT=640

SCALE=$(echo "scale=6; ${DPI} / 96" | bc)
WIDTH=$(printf '%.0f' "$(echo "${BASE_WIDTH} * ${SCALE}" | bc)")
HEIGHT=$(printf '%.0f' "$(echo "${BASE_HEIGHT} * ${SCALE}" | bc)")

SOURCE="${ROOT_DIR}/${SLIDES_PATH}.decktape.html"
[ -f "${SOURCE}" ] || SOURCE="${ROOT_DIR}/${SLIDES_PATH}.html"
[ -f "${SOURCE}" ] || {
	echo "No rendered slides found; run 'quarto render' first." >&2
	exit 1
}

OUTPUT="2026-ggplot2-extenders-gribouille.png"
SHOT="index_1_${WIDTH}x${HEIGHT}.png"

# decktape derives the screenshot name from the PDF path and prepends the
# screenshots directory, so bare relative names (run from SCRIPT_DIR) keep the
# output next to this script instead of doubling the absolute path.
cd "${SCRIPT_DIR}"

npx -y decktape reveal \
	--load-pause 2000 \
	--chrome-arg="--no-sandbox" \
	--chrome-arg="--disable-setuid-sandbox" \
	--size "${WIDTH}x${HEIGHT}" \
	--no-fragments \
	--screenshots \
	--screenshots-format png \
	--screenshots-directory . \
	--slides 1 \
	"${SOURCE}" index.pdf

mv "${SHOT}" "${OUTPUT}"
sips -s dpiWidth "${DPI}" -s dpiHeight "${DPI}" "${OUTPUT}" >/dev/null
rm -f index.pdf
echo "Wrote ${SCRIPT_DIR}/${OUTPUT} (${WIDTH}x${HEIGHT}, ${DPI}dpi)"
