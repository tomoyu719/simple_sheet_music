# OTF Font Parser

A Python tool for reading OTF files and extracting font information, with support for generating Dart font constants from CSV input.

## Features

- Extract basic font information from OTF files
- Generate Dart font constants with CSV input mapping
- Get the following information for each glyph:
  - Name
  - Bounding box
  - Path commands (SVG format)
  - Unicode value
  - Width information

## Installation

Install the required dependencies:

```bash
pip install -r requirements.txt
```

Or:

```bash
pip install fonttools
```

## Usage

### 1. Generate Dart font constants from CSV

The primary use case is to generate Dart font constants using a CSV file that maps display names to Unicode glyph names:

```bash
python3 font_parser.py Bravura.otf glyphs.csv
python3 font_parser.py Bravura.otf glyphs.csv output.dart
```

**CSV Format:**
```csv
name,unicode
timeSig0,uniE080
timeSig1,uniE081
timeSig2,uniE082
```

**Generated Dart Output:**
```dart
const BravuraFont = {
  'glyphs': {
    'timeSig0': {
      'unicode': "uniE080",
      'path': "M 450,0 C 450,139 354,251...",
    },
    'timeSig1': {
      'unicode': "uniE081", 
      'path': "M 24,13 C 24,13 20,7 20,0...",
    },
  },
  'generatedOn': '2025-07-12 23:45:48'
};
```

### 2. Display specific glyph information

```bash
python3 font_parser.py path/to/font.otf A
```

### 3. Display entire font information

```bash
python3 font_parser.py path/to/font.otf
```

### 4. Use in Python code

```python
from font_parser import OTFFontParser

# Load font file
parser = OTFFontParser("path/to/font.otf")

# Generate Dart font from CSV
dart_code = parser.export_dart_font("glyphs.csv", "output.dart")

# Get font information
font_info = parser.get_font_info()
print(f"Font name: {font_info.font_name}")
print(f"Total glyphs: {len(font_info.glyphs)}")
```

## Output Data Structure

### Dart Font Constant
```dart
const FontName = {
  'glyphs': {
    'displayName': {
      'unicode': "unicodeValue",
      'path': "SVG path commands",
    },
  },
  'generatedOn': 'timestamp'
};
```

### Glyph Information (Python API)
```python
{
    'name': str,
    'unicode_value': int | None,
    'unicode_char': str | None,
    'bounding_box': {
        'xMin': float,
        'yMin': float,
        'xMax': float,
        'yMax': float,
        'width': float,
        'height': float
    },
    'path_commands': str,  # SVG format: "M 97,-125 C 186,-125 295,-43 295,42 Z"
    'advance_width': float
}
```

## Dependencies

- Python 3.6+
- fonttools 4.38.0+