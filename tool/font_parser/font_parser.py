#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
OTF Font Parser
Tool for reading OTF files and extracting font information (boundingBox, path, name)
"""

import os
import sys
import csv
import json
from typing import Dict, List, Tuple, Optional
from pathlib import Path
from datetime import datetime

try:
    from fontTools.ttLib import TTFont
    from fontTools.pens.recordingPen import RecordingPen
    from fontTools.misc.transform import Transform
except ImportError:
    print("fonttools is required. Please install it:")
    print("pip install fonttools")
    sys.exit(1)






class OTFFontParser:
    """OTF font parser class"""
    
    def __init__(self, font_path: str):
        """
        Initialize
        
        Args:
            font_path (str): Path to OTF file
        """
        self.font_path = Path(font_path)
        if not self.font_path.exists():
            raise FileNotFoundError(f"Font file not found: {font_path}")
        
        self.font = TTFont(str(self.font_path))
        self.glyph_set = self.font.getGlyphSet()
    
    def _get_font_family_name(self) -> str:
        """
        Get font family name
        
        Returns:
            str: Font family name
        """
        name_table = self.font['name']
        return self._get_name_by_id(name_table, 1) or "Unknown"
    
    def _get_name_by_id(self, name_table, name_id: int) -> Optional[str]:
        """
        Get name from name table by specified ID
        
        Args:
            name_table: Name table
            name_id (int): Name ID
            
        Returns:
            Optional[str]: Name string
        """
        for record in name_table.names:
            if record.nameID == name_id:
                return str(record)
        return None
    
    def _get_glyph_path(self, glyph_name: str) -> str:
        """
        Get SVG path for a specific glyph
        
        Args:
            glyph_name (str): Glyph name
            
        Returns:
            str: SVG path commands
        """
        if glyph_name not in self.glyph_set:
            return ""
        
        glyph = self.glyph_set[glyph_name]
        return self._extract_path_commands(glyph)
    
    
    def _extract_path_commands(self, glyph) -> str:
        """
        Extract path commands from glyph and return as SVG path format string
        
        Args:
            glyph: Glyph object
            
        Returns:
            str: SVG path format command string
        """
        pen = RecordingPen()
        try:
            glyph.draw(pen)
            return self._convert_to_svg_path(pen.value)
        except Exception as e:
            print(f"Path extraction error: {e}")
            return ""
    
    def _convert_to_svg_path(self, commands: List[Tuple[str, Tuple]]) -> str:
        """
        Convert fontTools path commands to SVG path format string
        
        Args:
            commands: fontTools path command list
            
        Returns:
            str: SVG path format string
        """
        svg_parts = []
        
        for cmd, args in commands:
            if cmd == 'moveTo':
                x, y = args[0]
                svg_parts.append(f"M {int(x)},{int(y)}")
            elif cmd == 'lineTo':
                x, y = args[0]
                svg_parts.append(f"L {int(x)},{int(y)}")
            elif cmd == 'curveTo':
                if len(args) == 3:  # Cubic Bezier
                    x1, y1 = args[0]
                    x2, y2 = args[1]
                    x3, y3 = args[2]
                    svg_parts.append(f"C {int(x1)},{int(y1)} {int(x2)},{int(y2)} {int(x3)},{int(y3)}")
                elif len(args) == 2:  # Quadratic Bezier
                    x1, y1 = args[0]
                    x2, y2 = args[1]
                    svg_parts.append(f"Q {int(x1)},{int(y1)} {int(x2)},{int(y2)}")
            elif cmd == 'qCurveTo':
                # Quadratic curve
                if args:
                    for i in range(0, len(args), 2):
                        if i + 1 < len(args):
                            x1, y1 = args[i]
                            x2, y2 = args[i + 1]
                            svg_parts.append(f"Q {int(x1)},{int(y1)} {int(x2)},{int(y2)}")
            elif cmd == 'closePath':
                svg_parts.append("Z")
        
        return ' '.join(svg_parts)
    
    
    def load_csv_glyphs(self, csv_path: str) -> Dict[str, str]:
        """
        Load glyph names and unicode values from CSV file
        
        Args:
            csv_path (str): Path to CSV file with name and unicode columns
            
        Returns:
            Dict[str, str]: Dictionary mapping display names to unicode values
        """
        glyph_mapping = {}
        
        try:
            with open(csv_path, 'r', encoding='utf-8') as csvfile:
                # Try to detect if the first row is a header
                first_line = csvfile.readline()
                csvfile.seek(0)
                
                # Check if first line looks like a header
                reader = csv.reader(csvfile)
                first_row = next(reader)
                
                # If first row contains 'name' or 'unicode', treat as header
                has_header = any('name' in str(cell).lower() or 'unicode' in str(cell).lower() 
                               for cell in first_row)
                
                csvfile.seek(0)
                reader = csv.reader(csvfile)
                
                if has_header:
                    next(reader)  # Skip header
                
                for row in reader:
                    if len(row) >= 2 and row[0].strip():
                        display_name = row[0].strip()
                        unicode_value = row[1].strip()
                        glyph_mapping[display_name] = unicode_value
                        
        except Exception as e:
            print(f"Error reading CSV file: {e}")

        return glyph_mapping

    def load_json_glyphs(self, json_path: str) -> Dict[str, str]:
        """
        Load glyph names and unicode values from JSON file

        Args:
            json_path (str): Path to JSON file with categorized glyphs

        Returns:
            Dict[str, str]: Dictionary mapping display names to unicode glyph names
        """
        glyph_mapping = {}

        try:
            with open(json_path, 'r', encoding='utf-8') as jsonfile:
                data = json.load(jsonfile)

                # Iterate through categories
                for category, glyphs in data.items():
                    if isinstance(glyphs, dict):
                        for glyph_name, glyph_info in glyphs.items():
                            if isinstance(glyph_info, dict) and 'codepoint' in glyph_info:
                                # Convert U+E050 to uniE050 format
                                codepoint = glyph_info['codepoint']
                                unicode_value = codepoint.replace('U+', 'uni')
                                glyph_mapping[glyph_name] = unicode_value

        except Exception as e:
            print(f"Error reading JSON file: {e}")

        return glyph_mapping

    def load_glyphs(self, file_path: str) -> Dict[str, str]:
        """
        Load glyph names from CSV or JSON file (auto-detect by extension)

        Args:
            file_path (str): Path to CSV or JSON file

        Returns:
            Dict[str, str]: Dictionary mapping display names to unicode glyph names
        """
        path = Path(file_path)
        if path.suffix.lower() == '.json':
            return self.load_json_glyphs(file_path)
        else:
            return self.load_csv_glyphs(file_path)

    def export_dart_font(self, glyph_file_path: str, output_path: str = None) -> str:
        """
        Export font glyphs as Dart code format based on CSV or JSON mapping

        Args:
            glyph_file_path (str): CSV or JSON file with glyph names to include
            output_path (str, optional): Output file path for Dart code

        Returns:
            str: Dart code string
        """
        # Load glyph mapping from CSV or JSON
        glyph_mapping = self.load_glyphs(glyph_file_path)
        if not glyph_mapping:
            raise ValueError("No valid glyph names found in glyph file")
        
        # Get font name for the constant name (lowerCamelCase)
        font_name = self._get_font_family_name().replace(' ', '').replace('-', '')
        const_name = font_name[0].lower() + font_name[1:] + 'Glyphs'

        # Build Dart code
        dart_lines = []
        dart_lines.append(f"const {const_name} = {{")
        dart_lines.append("  'glyphs': {")

        # Add glyphs from mapping (keyed by unicode for compatibility)
        glyph_count = 0
        for display_name, unicode_value in glyph_mapping.items():
            path_commands = self._get_glyph_path(unicode_value)

            # Skip glyphs without path data
            if not path_commands.strip():
                continue

            # Use unicode (e.g., uniE050) as key for lookup compatibility
            dart_lines.append(f"    '{unicode_value}': {{")
            dart_lines.append(f"      'name': '{display_name}',")
            dart_lines.append(f"      'path': \"{path_commands}\",")
            dart_lines.append("    },")
            glyph_count += 1
        
        # Remove trailing comma from last glyph
        if dart_lines and dart_lines[-1].endswith(","):
            dart_lines[-1] = dart_lines[-1][:-1]

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
                print(f"Dart code exported to: {output_path}")
                print(f"Total glyphs exported: {glyph_count}")
            except Exception as e:
                print(f"Error writing Dart file: {e}")
        
        return dart_code


def main():
    """Main function"""
    if len(sys.argv) < 3:
        print("Usage: python font_parser.py <OTF file path> <glyphs file> [output file]")
        print("Examples:")
        print("  python font_parser.py Bravura.otf glyphs.json")
        print("  python font_parser.py Bravura.otf glyphs.csv")
        print("  python font_parser.py Bravura.otf glyphs.json output.dart")
        return

    font_path = sys.argv[1]
    glyph_file_path = sys.argv[2]

    try:
        parser = OTFFontParser(font_path)

        # Third argument is output file path
        if len(sys.argv) > 3:
            output_path = sys.argv[3]
        else:
            # Generate output file name in lib/src/fonts/ directory
            script_dir = Path(__file__).parent
            fonts_dir = script_dir.parent.parent / "lib" / "src" / "fonts"
            font_name = parser._get_font_family_name().replace(' ', '').replace('-', '').lower()
            output_path = str(fonts_dir / f"{font_name}_glyphs.dart")

        # Export as Dart file
        dart_code = parser.export_dart_font(glyph_file_path, output_path)
    
    except Exception as e:
        print(f"Error: {e}")
        return 1
    
    return 0


if __name__ == "__main__":
    sys.exit(main())