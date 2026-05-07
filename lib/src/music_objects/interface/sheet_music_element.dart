/// Base class for any element that can be rendered in sheet music.
///
/// This includes both `MusicalSymbol` (atomic notation elements like notes, clefs)
/// and structural containers like `Measure` and `Staff`.
abstract class SheetMusicElement {
  const SheetMusicElement();
}
