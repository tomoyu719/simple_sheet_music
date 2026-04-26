import 'package:flutter/material.dart';

import 'glyph_catalog_page.dart';

void main() {
  runApp(const GlyphCatalogApp());
}

class GlyphCatalogApp extends StatelessWidget {
  const GlyphCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMuFL Glyph Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SMuFL Glyph Catalog'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const GlyphCatalogPage(),
      ),
    );
  }
}
