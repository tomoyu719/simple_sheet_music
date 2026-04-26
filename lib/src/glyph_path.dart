import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class GlyphPaths {
  GlyphPaths(this.glyphs) : _fontId = identityHashCode(glyphs);
  final Map<String, dynamic> glyphs;
  final int _fontId;
  static final Map<String, Path> _cachedPaths = {};

  /// Retrieves the [Path] object associated with the given [pathKey].
  Path parsePath(String pathKey) {
    final cacheKey = '$_fontId:$pathKey';
    if (_cachedPaths.containsKey(cacheKey)) {
      return _cachedPaths[cacheKey]!;
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
    _cachedPaths[cacheKey] = pathYReversed;

    return pathYReversed;
  }
}
