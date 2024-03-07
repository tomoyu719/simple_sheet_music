import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/measure/ledgerline/ledgerline_helper.dart';

void main() {
  test('Upper ledger line number should be calculated correctly', () {
    // Arrange
    const notePosition = 10;

    // Assert
    expect(upperLedgerLineNum(notePosition), 3);
    expect(lowerLedgerLineNum(notePosition), 0);
  });

  test('Lower ledger line number should be calculated correctly', () {
    // Arrange
    const notePosition = -8;

    // Assert
    expect(upperLedgerLineNum(notePosition), 0);
    expect(lowerLedgerLineNum(notePosition), 2);
  });
}
