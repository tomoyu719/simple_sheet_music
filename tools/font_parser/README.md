# Font Parser Tools

Tools for extracting glyph data from OTF fonts and SMuFL metadata files, generating Dart code.

## Tools

| Script | Input | Output | Description |
|--------|-------|--------|-------------|
| `font_parser.py` | OTF + glyphs.json | `*_font.dart` | SVG path data |
| `metadata_parser.py` | metadata.json + glyphs.json | `*_metadata.dart` | BBox, anchors, widths |

## Installation

```bash
pip install -r requirements.txt
```

## Usage

### Generate Font Path Data

```bash
python3 font_parser.py Bravura.otf glyphs.json
python3 font_parser.py Petaluma.otf glyphs.json
```

### Generate Metadata

```bash
python3 metadata_parser.py ../../assets/bravura_metadata.json glyphs.json
python3 metadata_parser.py ../../assets/petaluma_metadata.json glyphs.json
```

### Custom Output Path

```bash
python3 font_parser.py Bravura.otf glyphs.json custom_output.dart
python3 metadata_parser.py metadata.json glyphs.json custom_output.dart
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

## Output

### *_font.dart (Path Data)

```dart
const BravuraFont = {
    'glyphs': {
        'gClef': {
            'unicode': "uniE050",
            'path': "M 450,0 C 450,139...",
        },
    },
    'generatedOn': '2025-04-25 18:00:00'
};
```

### *_metadata.dart (Metadata)

```dart
const BravuraMetadata = {
  'fontName': 'Bravura',
  'fontVersion': 1.392,
  'engravingDefaults': {
    'staffLineThickness': 0.13,
    'stemThickness': 0.12,
    ...
  },
  'glyphAdvanceWidths': {
    'gClef': 2.684,
    ...
  },
  'glyphBBoxes': {
    'gClef': {
      'bBoxNE': [2.556, 4.392],
      'bBoxSW': [-0.18, -2.632],
    },
    ...
  },
  'glyphsWithAnchors': {
    'noteheadWhole': {
      'stemUpSE': [1.328, -0.5],
      'stemDownNW': [0.0, 0.5],
    },
    ...
  },
  'generatedOn': '2025-04-25 18:00:00'
};
```

## Directory Structure

```
simple_sheet_music/
├── assets/
│   ├── bravura_metadata.json    # SMuFL metadata (input)
│   └── petaluma_metadata.json
├── glyphs/                      # Generated output
│   ├── bravura_font.dart
│   ├── bravura_metadata.dart
│   ├── petaluma_font.dart
│   └── petaluma_metadata.dart
└── tools/font_parser/
    ├── font_parser.py           # Path extractor
    ├── metadata_parser.py       # Metadata extractor
    ├── glyphs.json              # Glyph definitions
    ├── Bravura.otf              # Font files (input)
    ├── Petaluma.otf
    ├── README.md
    └── requirements.txt
```

## Dependencies

- Python 3.6+
- fonttools 4.38.0+
