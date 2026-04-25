import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class GlyphPaths {
  const GlyphPaths(this.glyphs);
  final Map<String, dynamic> glyphs;
  static final Map<String, Path> _cachedPaths = {};

  /// Retrieves the [Path] object associated with the given [pathKey].
  Path parsePath(String pathKey) {
    if (_cachedPaths.containsKey(pathKey)) {
      return _cachedPaths[pathKey]!;
    }

    final glyphData = glyphs[pathKey] as Map<String, dynamic>?;
    if (glyphData == null) {
      throw Exception('Glyph not found: $pathKey');
    }

    final svgPathStr = glyphData['path'] as String;
    final path = parseSvgPath(svgPathStr);

    // Reverses the Y-axis of the path. This is because the coordinate system
    // of the canvas API is such that the origin (0,0) is at the top-left corner
    // of the screen, and the Y-axis increases downwards.
    final pathYReversed = path.transform(Matrix4.rotationX(pi).storage);
    _cachedPaths[pathKey] = pathYReversed;

    return pathYReversed;
  }
}
