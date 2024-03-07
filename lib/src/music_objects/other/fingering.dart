import 'dart:ui';

const _fingering0 = '';
const _fingering1 = '';
const _fingering2 = '';
const _fingering3 = '';
const _fingering4 = '';
const _fingering5 = '';

const _fingering0Bbox = Rect.fromLTRB(0.08, 1.004, 0.94, -0.004);
const _fingering1Bbox = Rect.fromLTRB(0.08, 1.016, 0.548, 0.0);
const _fingering2Bbox = Rect.fromLTRB(0.08, 1.012, 0.888, -0.012);
const _fingering3Bbox = Rect.fromLTRB(0.08, 1.008, 0.82, 0.0);
const _fingering4Bbox = Rect.fromLTRB(0.08, 1.012, 0.864, 0.004);
const _fingering5Bbox = Rect.fromLTRB(0.08, 1.032, 0.82, 0.0);

enum Fingering {
  fingering0(_fingering0, _fingering0Bbox),
  fingering1(_fingering1, _fingering1Bbox),
  fingering2(_fingering2, _fingering2Bbox),
  fingering3(_fingering3, _fingering3Bbox),
  fingering4(_fingering4, _fingering4Bbox),
  fingering5(_fingering5, _fingering5Bbox);

  final String glyph;
  final Rect bbox;

  const Fingering(this.glyph, this.bbox);
}
