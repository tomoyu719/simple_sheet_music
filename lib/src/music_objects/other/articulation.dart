// import 'dart:ui';

// const _accentAbove = '';
// const _accentBelow = '';
// const _staccatoAbove = '';
// const _staccatoBelow = '';
// const _tenutoAbove = '';
// const _tenutoBelow = '';
// const _staccatissimoAbove = '';
// const _staccatissimoBelow = '';
// const _marcatoAbove = '';
// const _marcatoBelow = '';
// const _marcatoStaccatoAbove = '';
// const _marcatoStaccatoBelow = '';
// const _accentStaccatoAbove = '';
// const _accentStaccatoBelow = '';
// const _tenutoStaccatoAbove = '';
// const _tenutoStaccatoBelow = '';
// const _tenutoAccentAbove = '';
// const _tenutoAccentBelow = '';

// const _accentAboveBbox = Rect.fromLTRB(0.0, 0.98, 1.356, 0.004);
// const _accentBelowBbox = Rect.fromLTRB(0.0, 0.0, 1.356, -0.976);
// const _staccatoAboveBbox = Rect.fromLTRB(0.0, 0.336, 0.336, 0.0);
// const _staccatoBelowBbox = Rect.fromLTRB(0.0, 0.0, 0.336, -0.336);
// const _tenutoAboveBbox = Rect.fromLTRB(-0.004, 0.192, 1.352, 0.0);
// const _tenutoBelowBbox = Rect.fromLTRB(-0.004, 0.0, 1.352, -0.192);
// const _staccatissimoAboveBbox = Rect.fromLTRB(0.004, 1.172, 0.4, -0.008);
// const _staccatissimoBelowBbox = Rect.fromLTRB(0.004, 0.0, 0.4, -1.18);
// const _marcatoAboveBbox = Rect.fromLTRB(-0.004, 1.012, 0.94, -0.004);
// const _marcatoBelowBbox = Rect.fromLTRB(-0.004, 0.0, 0.94, -1.016);
// const _marcatoStaccatoAboveBbox = Rect.fromLTRB(-0.004, 1.772, 0.94, 0.0);
// const _marcatoStaccatoBelowBbox = Rect.fromLTRB(-0.004, 0.0, 0.94, -1.812);
// const _accentStaccatoAboveBbox = Rect.fromLTRB(0.0, 1.68, 1.356, 0.0);
// const _accentStaccatoBelowBbox = Rect.fromLTRB(-0.004, 0.0, 1.352, -1.644);
// const _tenutoStaccatoAboveBbox = Rect.fromLTRB(-0.004, 0.96, 1.352, 0.0);
// const _tenutoStaccatoBelowBbox = Rect.fromLTRB(-0.004, 0.0, 1.352, -0.968);
// const _tenutoAccentAboveBbox = Rect.fromLTRB(-0.004, 1.38, 1.356, 0.0);
// const _tenutoAccentBelowBbox = Rect.fromLTRB(-0.004, 0.0, 1.356, -1.38);

// enum Articulation {
//   accent(_accentAbove, _accentBelow, _accentAboveBbox, _accentBelowBbox),
//   staccato(
//       _staccatoAbove, _staccatoBelow, _staccatoAboveBbox, _staccatoBelowBbox),
//   tenuto(_tenutoAbove, _tenutoBelow, _tenutoAboveBbox, _tenutoBelowBbox),
//   staccatissimo(_staccatissimoAbove, _staccatissimoBelow,
//       _staccatissimoAboveBbox, _staccatissimoBelowBbox),
//   marcato(_marcatoAbove, _marcatoBelow, _marcatoAboveBbox, _marcatoBelowBbox),
//   marcatoStaccato(_marcatoStaccatoAbove, _marcatoStaccatoBelow,
//       _marcatoStaccatoAboveBbox, _marcatoStaccatoBelowBbox),
//   accentStaccato(_accentStaccatoAbove, _accentStaccatoBelow,
//       _accentStaccatoAboveBbox, _accentStaccatoBelowBbox),
//   tenutoStaccato(_tenutoStaccatoAbove, _tenutoStaccatoBelow,
//       _tenutoStaccatoAboveBbox, _tenutoStaccatoBelowBbox),
//   tenutoAccent(_tenutoAccentAbove, _tenutoAccentBelow, _tenutoAccentAboveBbox,
//       _tenutoAccentBelowBbox);

//   final String aboveGlyph;
//   final String belowGlyph;
//   final Rect aboveBbox;
//   final Rect belowBbox;

//   const Articulation(
//       this.aboveGlyph, this.belowGlyph, this.aboveBbox, this.belowBbox);

//   Rect bbox(StemDirection stemDirection) =>
//       stemDirection.isUp ? belowBbox : aboveBbox;

//   String glyph(StemDirection stemDirection) =>
//       stemDirection.isUp ? belowGlyph : aboveGlyph;
// }
