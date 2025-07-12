# OTF Font Parser

A Python tool for reading OTF files and extracting font information, with support for generating Dart font constants from CSV input.

## Features

- Generate Dart font constants from OTF files using CSV input mapping
- Extract SVG path data for specified glyphs
- Support for custom glyph naming through CSV configuration

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


## Dependencies

- Python 3.6+
- fonttools 4.38.0+