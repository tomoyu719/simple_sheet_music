# SMuFL Code Generator

Tools for generating Dart code from OTF fonts and SMuFL metadata files.

## Quick Start

```bash
# Install dependencies
pip install -r requirements.txt

# Generate all font files
./generate.sh
```

## Tools

| Script | Input | Output | Description |
|--------|-------|--------|-------------|
| `generate.sh` | - | All Dart files | Main entry point |
| `glyph_codegen.py` | OTF + glyphs.json | `*_glyphs.dart` | SVG path data |
| `metadata_codegen.py` | metadata.json + glyphs.json | `*_metadata.dart` | BBox, anchors, widths |

## Manual Usage

### Generate Glyph Path Data

```bash
python3 glyph_codegen.py Bravura.otf glyphs.json
python3 glyph_codegen.py Petaluma.otf glyphs.json
```

### Generate Metadata

```bash
python3 metadata_codegen.py bravura_metadata.json glyphs.json
python3 metadata_codegen.py petaluma_metadata.json glyphs.json
```

### Custom Output Path

```bash
python3 glyph_codegen.py Bravura.otf glyphs.json custom_output.dart
python3 metadata_codegen.py metadata.json glyphs.json custom_output.dart
```

## Glyph Definition (glyphs.json)

```json
{
  "clefs": {
    "gClef": { "codepoint": "U+E050", "description": "G clef" },
    "fClef": { "codepoint": "U+E062", "description": "F clef" }
  },
  "noteheads": {
    "noteheadWhole": { "codepoint": "U+E0A2", "description": "Whole notehead" }
  }
}
```

## Output Format

### *_glyphs.dart

```dart
const Map<String, Object> bravuraGlyphs = {
  'glyphs': {
    'uniE050': {
      'name': 'gClef',
      'path': 'M 450,0 C 450,139...',
    },
  },
  'generatedOn': '2025-04-25 18:00:00',
};
```

### *_metadata.dart

```dart
const Map<String, Object> bravuraMetadata = {
  'fontName': 'Bravura',
  'fontVersion': 1.392,
  'engravingDefaults': {
    'staffLineThickness': 0.13,
    'stemThickness': 0.12,
  },
  'glyphAdvanceWidths': {
    'gClef': 2.684,
  },
  'glyphBBoxes': {
    'gClef': {
      'bBoxNE': [2.556, 4.392],
      'bBoxSW': [-0.18, -2.632],
    },
  },
  'glyphsWithAnchors': {
    'noteheadWhole': {
      'stemUpSE': [1.328, -0.5],
      'stemDownNW': [0.0, 0.5],
    },
  },
  'generatedOn': '2025-04-25 18:00:00',
};
```

## Directory Structure

```
simple_sheet_music/
├── lib/src/fonts/              # Generated output
│   ├── bravura_glyphs.dart
│   ├── bravura_metadata.dart
│   ├── petaluma_glyphs.dart
│   └── petaluma_metadata.dart
└── tool/smufl_codegen/
    ├── bravura/                # Bravura font data
    │   ├── font.otf
    │   └── metadata.json
    ├── petaluma/               # Petaluma font data
    │   ├── font.otf
    │   └── metadata.json
    ├── glyphs.json             # Shared glyph definitions
    ├── generate.sh             # Main script
    ├── glyph_codegen.py        # Glyph extractor
    ├── metadata_codegen.py     # Metadata extractor
    ├── README.md
    └── requirements.txt
```

## Dependencies

- Python 3.6+
- fonttools 4.38.0+
