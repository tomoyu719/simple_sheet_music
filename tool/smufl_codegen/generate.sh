#!/bin/bash
# SMuFL Code Generator
# Generates Dart code from OTF fonts and SMuFL metadata JSON

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
FONTS_OUTPUT_DIR="$PROJECT_ROOT/lib/src/fonts"

echo "=== SMuFL Code Generator ==="
echo "Script directory: $SCRIPT_DIR"
echo "Output directory: $FONTS_OUTPUT_DIR"
echo ""

# Check Python dependencies
if ! python3 -c "import fontTools" 2>/dev/null; then
    echo "Error: fontTools not installed. Run: pip install fonttools"
    exit 1
fi

# Generate files for each font
for FONT_NAME in bravura petaluma; do
    FONT_DIR="$SCRIPT_DIR/$FONT_NAME"

    echo "=== Processing $FONT_NAME ==="

    echo "Generating glyphs..."
    python3 "$SCRIPT_DIR/glyph_codegen.py" \
        "$FONT_DIR/font.otf" \
        "$SCRIPT_DIR/glyphs.json" \
        "$FONTS_OUTPUT_DIR/${FONT_NAME}_glyphs.dart"

    echo "Generating metadata..."
    python3 "$SCRIPT_DIR/metadata_codegen.py" \
        "$FONT_DIR/metadata.json" \
        "$SCRIPT_DIR/glyphs.json" \
        "$FONTS_OUTPUT_DIR/${FONT_NAME}_metadata.dart"

    echo ""
done

# Apply Dart fixes and formatting
echo ""
echo "=== Applying Dart fixes ==="
cd "$PROJECT_ROOT"

GENERATED_FILES=(
    "lib/src/fonts/bravura_glyphs.dart"
    "lib/src/fonts/bravura_metadata.dart"
    "lib/src/fonts/petaluma_glyphs.dart"
    "lib/src/fonts/petaluma_metadata.dart"
)

for file in "${GENERATED_FILES[@]}"; do
    echo "Fixing: $file"
    dart fix --apply "$file" 2>/dev/null || true
done

echo ""
echo "=== Formatting Dart files ==="
for file in "${GENERATED_FILES[@]}"; do
    echo "Formatting: $file"
    dart format "$file"
done

echo ""
echo "=== Running Dart analyze ==="
dart analyze "${GENERATED_FILES[@]}"

echo ""
echo "=== Generation complete ==="
