/// Enum representing different types of note flags.
enum NoteFlagType {
  flag8th(
    upPathKey: _flag8thUpPathKey,
    downPathKey: _flag8thDownPathKey,
    upMetadataKey: _flag8thUpMetadataKey,
    downMetadataKey: _flag8thDownMetadataKey,
  ),
  flag16th(
    upPathKey: _flag16thUpPathKey,
    downPathKey: _flag16thDownPathKey,
    upMetadataKey: _flag16thUpMetadataKey,
    downMetadataKey: _flag16thDownMetadataKey,
  ),
  flag32nd(
    upPathKey: _flag32ndUpPathKey,
    downPathKey: _flag32ndDownPathKey,
    upMetadataKey: _flag32ndUpMetadataKey,
    downMetadataKey: _flag32ndDownMetadataKey,
  ),
  flag64th(
    upPathKey: _flag64thUpPathKey,
    downPathKey: _flag64thDownPathKey,
    upMetadataKey: _flag64thUpMetadataKey,
    downMetadataKey: _flag64thDownMetadataKey,
  ),
  flag128th(
    upPathKey: _flag128thUpPathKey,
    downPathKey: _flag128thDownPathKey,
    upMetadataKey: _flag128thUpMetadataKey,
    downMetadataKey: _flag128thDownMetadataKey,
  );

  const NoteFlagType({
    required this.upPathKey,
    required this.downPathKey,
    required this.upMetadataKey,
    required this.downMetadataKey,
  });

  /// The key for the upward path of the flag icon.
  final String upPathKey;

  /// The key for the downward path of the flag icon.
  final String downPathKey;

  /// The key for the upward metadata of the flag icon.
  final String upMetadataKey;

  /// The key for the downward metadata of the flag icon.
  final String downMetadataKey;

  static const _flag8thUpPathKey = 'uniE240';
  static const _flag8thDownPathKey = 'uniE241';
  static const _flag16thUpPathKey = 'uniE242';
  static const _flag16thDownPathKey = 'uniE243';
  static const _flag32ndUpPathKey = 'uniE244';
  static const _flag32ndDownPathKey = 'uniE245';
  static const _flag64thUpPathKey = 'uniE246';
  static const _flag64thDownPathKey = 'uniE247';
  static const _flag128thUpPathKey = 'uniE248';
  static const _flag128thDownPathKey = 'uniE249';

  static const _flag8thDownMetadataKey = 'flag8thDown';
  static const _flag8thUpMetadataKey = 'flag8thUp';
  static const _flag16thDownMetadataKey = 'flag16thDown';
  static const _flag16thUpMetadataKey = 'flag16thUp';
  static const _flag32ndDownMetadataKey = 'flag32ndDown';
  static const _flag32ndUpMetadataKey = 'flag32ndUp';
  static const _flag64thDownMetadataKey = 'flag64thDown';
  static const _flag64thUpMetadataKey = 'flag64thUp';
  static const _flag128thDownMetadataKey = 'flag128thDown';
  static const _flag128thUpMetadataKey = 'flag128thUp';
}
