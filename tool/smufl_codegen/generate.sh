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

# Generate glyph files from OTF fonts
echo "=== Generating glyph files ==="

echo "Processing Bravura.otf..."
python3 "$SCRIPT_DIR/glyph_codegen.py" \
    "$SCRIPT_DIR/Bravura.otf" \
    "$SCRIPT_DIR/glyphs.json" \
    "$FONTS_OUTPUT_DIR/bravura_glyphs.dart"

echo "Processing Petaluma.otf..."
python3 "$SCRIPT_DIR/glyph_codegen.py" \
    "$SCRIPT_DIR/Petaluma.otf" \
    "$SCRIPT_DIR/glyphs.json" \
    "$FONTS_OUTPUT_DIR/petaluma_glyphs.dart"

# Generate metadata files
echo ""
echo "=== Generating metadata files ==="

echo "Processing bravura_metadata.json..."
python3 "$SCRIPT_DIR/metadata_codegen.py" \
    "$SCRIPT_DIR/bravura_metadata.json" \
    "$SCRIPT_DIR/glyphs.json" \
    "$FONTS_OUTPUT_DIR/bravura_metadata.dart"

echo "Processing petaluma_metadata.json..."
python3 "$SCRIPT_DIR/metadata_codegen.py" \
    "$SCRIPT_DIR/petaluma_metadata.json" \
    "$SCRIPT_DIR/glyphs.json" \
    "$FONTS_OUTPUT_DIR/petaluma_metadata.dart"

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
