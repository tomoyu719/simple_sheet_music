import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:xml/xml.dart';

class GlyphPaths {
  const GlyphPaths(this.allGlyphs);
  final Set<XmlElement> allGlyphs;
  static final Map<String, Path> _cachedPaths = {};

  /// Retrieves the [Path] object associated with the given [pathKey].
  Path parsePath(String pathKey) {
    if (_cachedPaths.containsKey(pathKey)) {
      return _cachedPaths[pathKey]!;
    }
    final svgPathStr = _pathKeyToPathStr(pathKey);
    final path = parseSvgPath(svgPathStr);

    // Reverses the Y-axis of the path. This is because the coordinate system of the canvas API is such that the origin (0,0) is at the top-left corner of the screen, and the Y-axis increases downwards.
    final pathYReversed = path.transform(Matrix4.rotationX(pi).storage);
    _cachedPaths.addEntries([MapEntry(pathKey, pathYReversed)]);

    return pathYReversed;
  }

  String _pathKeyToPathStr(String glyphName) => allGlyphs
      .firstWhere(
        (element) => element.getAttribute('glyph-name') == glyphName,
      )
      .getAttribute('d')!;
}
