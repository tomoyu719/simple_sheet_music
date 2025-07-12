#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
OTF Font Parser
Tool for reading OTF files and extracting font information (boundingBox, path, name)
"""

import os
import sys
import csv
from typing import Dict, List, Tuple, Optional, Set
from dataclasses import dataclass
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


@dataclass
class GlyphInfo:
    """Data class for storing glyph information"""
    name: str
    unicode_value: Optional[int]
    bounding_box: Tuple[float, float, float, float]  # (xMin, yMin, xMax, yMax)
    path_commands: str  # SVG path format command string
    advance_width: float


@dataclass
class FontInfo:
    """Data class for storing font information"""
    font_name: str
    family_name: str
    style_name: str
    version: str
    units_per_em: int
    ascender: int
    descender: int
    line_gap: int
    glyphs: Dict[str, GlyphInfo]


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
    
    def get_font_info(self) -> FontInfo:
        """
        Get basic font information
        
        Returns:
            FontInfo: Font information
        """
        # Get information from name table
        name_table = self.font['name']
        font_name = self._get_name_by_id(name_table, 1) or "Unknown"  # Family name
        family_name = self._get_name_by_id(name_table, 1) or "Unknown"
        style_name = self._get_name_by_id(name_table, 2) or "Regular"  # Subfamily name
        version = self._get_name_by_id(name_table, 5) or "Unknown"  # Version
        
        # Get header information
        head_table = self.font['head']
        units_per_em = head_table.unitsPerEm
        
        # Get metrics information
        hhea_table = self.font.get('hhea')
        if hhea_table:
            ascender = hhea_table.ascent
            descender = hhea_table.descent
            line_gap = hhea_table.lineGap
        else:
            ascender = 0
            descender = 0
            line_gap = 0
        
        # Get glyph information
        glyphs = self._extract_all_glyphs()
        
        return FontInfo(
            font_name=font_name,
            family_name=family_name,
            style_name=style_name,
            version=version,
            units_per_em=units_per_em,
            ascender=ascender,
            descender=descender,
            line_gap=line_gap,
            glyphs=glyphs
        )
    
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
    
    def _extract_all_glyphs(self) -> Dict[str, GlyphInfo]:
        """
        Extract information for all glyphs
        
        Returns:
            Dict[str, GlyphInfo]: Glyph information dictionary with glyph names as keys
        """
        glyphs = {}
        
        # Get Unicode mapping
        cmap = self.font.getBestCmap() or {}
        unicode_to_glyph = {v: k for k, v in cmap.items()}
        
        # Process all glyphs
        for glyph_name in self.font.getGlyphNames():
            try:
                glyph_info = self._extract_glyph_info(glyph_name, unicode_to_glyph)
                if glyph_info:
                    glyphs[glyph_name] = glyph_info
            except Exception as e:
                print(f"Error processing glyph '{glyph_name}': {e}")
                continue
        
        return glyphs
    
    def _extract_glyph_info(self, glyph_name: str, unicode_to_glyph: Dict[int, str]) -> Optional[GlyphInfo]:
        """
        Extract information for a single glyph
        
        Args:
            glyph_name (str): Glyph name
            unicode_to_glyph (Dict[int, str]): Mapping from Unicode values to glyph names
            
        Returns:
            Optional[GlyphInfo]: Glyph information
        """
        if glyph_name not in self.glyph_set:
            return None
        
        glyph = self.glyph_set[glyph_name]
        
        # Get Unicode value
        unicode_value = None
        for unicode_val, mapped_glyph in unicode_to_glyph.items():
            if mapped_glyph == glyph_name:
                unicode_value = unicode_val
                break
        
        # Get bounding box
        if hasattr(glyph, 'xMin'):
            bounding_box = (glyph.xMin, glyph.yMin, glyph.xMax, glyph.yMax)
        else:
            bounding_box = (0, 0, 0, 0)
        
        # Get path commands
        path_commands = self._extract_path_commands(glyph)
        
        # Get width
        advance_width = glyph.width if hasattr(glyph, 'width') else 0
        
        return GlyphInfo(
            name=glyph_name,
            unicode_value=unicode_value,
            bounding_box=bounding_box,
            path_commands=path_commands,
            advance_width=advance_width
        )
    
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
    
    def export_dart_font(self, csv_path: str = None, output_path: str = None) -> str:
        """
        Export font glyphs as Dart code format
        
        Args:
            csv_path (str, optional): CSV file with glyph names to include
            output_path (str, optional): Output file path for Dart code
            
        Returns:
            str: Dart code string
        """
        font_info = self.get_font_info()
        
        # Load glyph mapping from CSV if provided
        glyph_mapping = {}
        if csv_path:
            glyph_mapping = self.load_csv_glyphs(csv_path)
            if not glyph_mapping:
                print("Warning: No valid glyph names found in CSV file")
        
        # Get font name for the constant name
        font_name = font_info.family_name.replace(' ', '').replace('-', '')
        
        # Build Dart code
        dart_lines = []
        dart_lines.append(f"const {font_name}Font = {{")
        dart_lines.append("    'glyphs': {")
        
        # Add glyphs
        glyph_count = 0
        
        if glyph_mapping:
            # Use CSV mapping
            for display_name, font_glyph_name in glyph_mapping.items():
                if font_glyph_name in font_info.glyphs:
                    glyph = font_info.glyphs[font_glyph_name]
                    
                    # Skip glyphs without path data
                    if not glyph.path_commands.strip():
                        continue
                    
                    # Use the unicode value from CSV
                    unicode_value = glyph_mapping[display_name]
                    
                    dart_lines.append(f"        '{display_name}': {{")
                    dart_lines.append(f"            'unicode': \"{unicode_value}\",")
                    dart_lines.append(f"            'path': \"{glyph.path_commands}\",")
                    dart_lines.append("        },")
                    glyph_count += 1
        else:
            # Fallback to all glyphs
            for glyph_name, glyph in font_info.glyphs.items():
                # Skip glyphs without path data
                if not glyph.path_commands.strip():
                    continue
                    
                # Get unicode value as hex string
                unicode_hex = ""
                if glyph.unicode_value:
                    unicode_hex = f"U+{glyph.unicode_value:04X}"
                    
                dart_lines.append(f"        '{glyph_name}': {{")
                dart_lines.append(f"            'unicode': \"{unicode_hex}\",")
                dart_lines.append(f"            'path': \"{glyph.path_commands}\",")
                dart_lines.append("        },")
                glyph_count += 1
        
        # Remove trailing comma from last glyph
        if dart_lines and dart_lines[-1].endswith(","):
            dart_lines[-1] = dart_lines[-1][:-1]
        
        dart_lines.append("    },")
        dart_lines.append(f"    'generatedOn': '{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}'")
        dart_lines.append("};")
        
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
        print("Usage: python font_parser.py <OTF file path> <CSV file> [output file]")
        print("Examples:")
        print("  python font_parser.py Bravura.otf glyphs.csv")
        print("  python font_parser.py Bravura.otf glyphs.csv output.dart")
        return
    
    font_path = sys.argv[1]
    csv_path = sys.argv[2]
    
    try:
        parser = OTFFontParser(font_path)
        
        # Third argument is output file path
        if len(sys.argv) > 3:
            output_path = sys.argv[3]
        else:
            # Generate output file name based on font name
            font_info = parser.get_font_info()
            font_name = font_info.family_name.replace(' ', '').replace('-', '').lower()
            output_path = f"{font_name}_font.dart"
        
        # Export as Dart file
        dart_code = parser.export_dart_font(csv_path, output_path)
    
    except Exception as e:
        print(f"Error: {e}")
        return 1
    
    return 0


if __name__ == "__main__":
    sys.exit(main())