#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SMuFL Metadata Parser
Tool for extracting glyph metadata from SMuFL JSON files and generating Dart code.
"""

import sys
import json
from typing import Dict, Any, Optional
from pathlib import Path
from datetime import datetime


class MetadataParser:
    """SMuFL metadata parser class"""

    def __init__(self, metadata_path: str):
        """
        Initialize

        Args:
            metadata_path (str): Path to SMuFL metadata JSON file
        """
        self.metadata_path = Path(metadata_path)
        if not self.metadata_path.exists():
            raise FileNotFoundError(f"Metadata file not found: {metadata_path}")

        with open(self.metadata_path, 'r', encoding='utf-8') as f:
            self.metadata = json.load(f)

    def _get_font_name(self) -> str:
        """Get font name from metadata"""
        return self.metadata.get('fontName', 'Unknown')

    def load_glyphs(self, glyph_file_path: str) -> Dict[str, str]:
        """
        Load glyph names from CSV or JSON file

        Args:
            glyph_file_path (str): Path to CSV or JSON file

        Returns:
            Dict[str, str]: Dictionary mapping glyph names to unicode values
        """
        path = Path(glyph_file_path)
        glyph_mapping = {}

        if path.suffix.lower() == '.json':
            with open(path, 'r', encoding='utf-8') as f:
                data = json.load(f)
                for category, glyphs in data.items():
                    if isinstance(glyphs, dict):
                        for glyph_name, glyph_info in glyphs.items():
                            if isinstance(glyph_info, dict) and 'codepoint' in glyph_info:
                                codepoint = glyph_info['codepoint']
                                unicode_value = codepoint.replace('U+', 'uni')
                                glyph_mapping[glyph_name] = unicode_value
        else:
            # CSV format
            import csv
            with open(path, 'r', encoding='utf-8') as f:
                reader = csv.reader(f)
                first_row = next(reader)
                has_header = any('name' in str(cell).lower() for cell in first_row)
                f.seek(0)
                reader = csv.reader(f)
                if has_header:
                    next(reader)
                for row in reader:
                    if len(row) >= 2 and row[0].strip():
                        glyph_mapping[row[0].strip()] = row[1].strip()

        return glyph_mapping

    def export_dart_metadata(self, glyph_file_path: str, output_path: str = None) -> str:
        """
        Export metadata as Dart code format

        Args:
            glyph_file_path (str): CSV or JSON file with glyph names to include
            output_path (str, optional): Output file path for Dart code

        Returns:
            str: Dart code string
        """
        glyph_mapping = self.load_glyphs(glyph_file_path)
        if not glyph_mapping:
            raise ValueError("No valid glyph names found in glyph file")

        font_name = self._get_font_name().replace(' ', '').replace('-', '')
        const_name = font_name[0].lower() + font_name[1:] + 'Metadata'

        # Extract relevant data
        engraving_defaults = self.metadata.get('engravingDefaults', {})
        glyph_advance_widths = self.metadata.get('glyphAdvanceWidths', {})
        glyph_bboxes = self.metadata.get('glyphBBoxes', {})
        glyphs_with_anchors = self.metadata.get('glyphsWithAnchors', {})

        dart_lines = []
        dart_lines.append(f"const {const_name} = {{")

        # Font info
        dart_lines.append(f"  'fontName': '{self.metadata.get('fontName', '')}',")
        dart_lines.append(f"  'fontVersion': {self.metadata.get('fontVersion', 0)},")

        # Engraving defaults
        dart_lines.append("  'engravingDefaults': {")
        for key, value in engraving_defaults.items():
            if isinstance(value, list):
                dart_lines.append(f"    '{key}': {json.dumps(value)},")
            elif isinstance(value, str):
                dart_lines.append(f"    '{key}': '{value}',")
            else:
                dart_lines.append(f"    '{key}': {value},")
        dart_lines.append("  },")

        # Glyph advance widths (filtered by glyph_mapping)
        width_entries = []
        for glyph_name in glyph_mapping.keys():
            if glyph_name in glyph_advance_widths:
                width_entries.append(f"    '{glyph_name}': {glyph_advance_widths[glyph_name]},")
        width_count = len(width_entries)
        if width_entries:
            dart_lines.append("  'glyphAdvanceWidths': {")
            dart_lines.extend(width_entries)
            dart_lines.append("  },")
        else:
            dart_lines.append("  'glyphAdvanceWidths': <String, dynamic>{},")

        # Glyph bounding boxes (filtered by glyph_mapping)
        dart_lines.append("  'glyphBBoxes': {")
        bbox_count = 0
        for glyph_name in glyph_mapping.keys():
            if glyph_name in glyph_bboxes:
                bbox = glyph_bboxes[glyph_name]
                dart_lines.append(f"    '{glyph_name}': {{")
                dart_lines.append(f"      'bBoxNE': {bbox.get('bBoxNE', [0, 0])},")
                dart_lines.append(f"      'bBoxSW': {bbox.get('bBoxSW', [0, 0])},")
                dart_lines.append("    },")
                bbox_count += 1
        dart_lines.append("  },")

        # Glyphs with anchors (filtered by glyph_mapping)
        dart_lines.append("  'glyphsWithAnchors': {")
        anchor_count = 0
        for glyph_name in glyph_mapping.keys():
            if glyph_name in glyphs_with_anchors:
                anchors = glyphs_with_anchors[glyph_name]
                dart_lines.append(f"    '{glyph_name}': {{")
                for anchor_name, anchor_value in anchors.items():
                    dart_lines.append(f"      '{anchor_name}': {anchor_value},")
                dart_lines.append("    },")
                anchor_count += 1
        dart_lines.append("  },")

        dart_lines.append(f"  'generatedOn': '{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}',")
        dart_lines.append("};")
        dart_lines.append("")  # Add trailing newline

        dart_code = '\n'.join(dart_lines)

        # Write to file if output path provided
        if output_path:
            try:
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(dart_code)
                print(f"Dart metadata exported to: {output_path}")
                print(f"  - Glyph widths: {width_count}")
                print(f"  - Glyph bboxes: {bbox_count}")
                print(f"  - Glyphs with anchors: {anchor_count}")
            except Exception as e:
                print(f"Error writing Dart file: {e}")

        return dart_code


def main():
    """Main function"""
    if len(sys.argv) < 3:
        print("Usage: python metadata_parser.py <metadata JSON> <glyphs file> [output file]")
        print("Examples:")
        print("  python metadata_parser.py bravura_metadata.json glyphs.json")
        print("  python metadata_parser.py bravura_metadata.json glyphs.json output.dart")
        return

    metadata_path = sys.argv[1]
    glyph_file_path = sys.argv[2]

    try:
        parser = MetadataParser(metadata_path)

        if len(sys.argv) > 3:
            output_path = sys.argv[3]
        else:
            # Generate output file name in lib/src/fonts/ directory
            script_dir = Path(__file__).parent
            fonts_dir = script_dir.parent.parent / "lib" / "src" / "fonts"
            font_name = parser._get_font_name().replace(' ', '').replace('-', '').lower()
            output_path = str(fonts_dir / f"{font_name}_metadata.dart")

        parser.export_dart_metadata(glyph_file_path, output_path)

    except Exception as e:
        print(f"Error: {e}")
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
