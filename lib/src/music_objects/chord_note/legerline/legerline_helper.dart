import 'dart:math';

/// Returns the number of upper ledger lines needed for a given note position.
/// The note position is an integer value representing the distance from the center line.
/// If the note position is negative, it means the note is below the center line.
/// If the note position is positive, it means the note is above the center line.
/// The function calculates the number of upper ledger lines based on the note position.
/// If the note position is less than 4, it returns 0.
/// Otherwise, it calculates the number of upper ledger lines by dividing the note position by 2 and subtracting 2.
/// The result is clamped to a minimum value of 0.
int upperLedgerLineNum(int notePosition) => max(notePosition ~/ 2 - 2, 0);

/// Returns the number of lower ledger lines needed for a given note position.
/// The note position is an integer value representing the distance from the center line.
/// If the note position is negative, it means the note is below the center line.
/// If the note position is positive, it means the note is above the center line.
/// The function calculates the number of lower ledger lines based on the note position.
/// If the note position is greater than -4, it returns 0.
/// Otherwise, it calculates the number of lower ledger lines by dividing the absolute value of the note position by 2 and subtracting 2.
/// The result is clamped to a minimum value of 0.
int lowerLedgerLineNum(int notePosition) => max(-notePosition ~/ 2 - 2, 0);
