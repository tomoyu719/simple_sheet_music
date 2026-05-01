# SheetMusicMetrics → SheetMusicLayout 統合計画書

## 概要

`SheetMusicMetrics` クラスを `SheetMusicLayout` クラスに統合し、クラス構造を簡素化する。

## 背景と関連情報

### 関連 Issue / PR

| ID | タイトル | 状態 | 関連性 |
|----|---------|------|--------|
| [PR #43](https://github.com/tomoyu719/simple_sheet_music/pull/43) | Merge Metrics and Renderer classes into unified Renderer classes | MERGED | 同様の統合パターンを適用済み（MeasureMetrics→MeasureRenderer, StaffMetrics→StaffRenderer, MusicalSymbolMetrics→MusicalSymbolRenderer） |
| [PR #44](https://github.com/tomoyu719/simple_sheet_music/pull/44) | Implement setter pattern for position information in renderers | OPEN | SheetMusicMetricsに変更あり。本計画とは独立して進める |
| [Issue #27](https://github.com/tomoyu719/simple_sheet_music/issues/27) | Separation of Responsibilities in SheetMusicRenderer | OPEN | スケール調整の責務分離が提案されている。本計画と直交する |

### 現在のクラス構造

```
SimpleSheetMusic (Widget)
  │
  ├── SheetMusicMetrics   ← 削除対象
  │     └── musicalSymbols, staffRenderers, サイズ計算
  │
  ├── SheetMusicLayout    ← 統合先
  │     └── metrics参照, パディング・スケール計算, render()
  │
  └── SheetMusicRenderer  ← 維持（CustomPainter）
        └── paint(), shouldRepaint()
```

### 統合後のクラス構造

```
SimpleSheetMusic (Widget)
  │
  ├── SheetMusicLayout    ← 統合後
  │     └── musicalSymbols, staffRenderers, サイズ計算,
  │         パディング・スケール計算, render()
  │
  └── SheetMusicRenderer  ← 維持（薄いラッパー）
        └── paint(), shouldRepaint()
```

## 統合対象ファイル

### 削除されるファイル

| ファイル | 役割 |
|---------|------|
| `lib/src/sheet_music_metrics.dart` | SheetMusicMetrics クラス定義 |
| `test/mock/mock_sheet_music_metrics.dart` | モッククラス |

### 変更されるファイル

| ファイル | 変更内容 |
|---------|----------|
| `lib/src/sheet_music_layout.dart` | SheetMusicMetrics の機能を統合 |
| `lib/src/simple_sheet_music.dart` | SheetMusicMetrics のインポート削除、SheetMusicLayout の呼び出し変更 |
| `test/sheet_music_metrics_test.dart` | テスト対象を SheetMusicLayout に変更（またはファイル名変更） |

## 詳細設計

### 1. SheetMusicLayout への統合内容

`SheetMusicMetrics` から移行するフィールド・メソッド：

```dart
// 移行するフィールド
final List<MusicalSymbol> musicalSymbols;
final ClefType initialClefType;
final KeySignatureType initialKeySignatureType;
final GlyphMetadata metadata;
final GlyphPaths paths;

// 移行するキャッシュ
List<MeasureRenderer>? _measureRenderersCache;
List<StaffRenderer>? _staffRenderersCache;

// 移行するプロパティ
List<MeasureRenderer> get _measureRenderers { ... }
List<StaffRenderer> get staffRenderers { ... }
StaffRenderer get _maximumWidthStaff { ... }
double get maximumStaffWidth { ... }
double get maximumStaffHorizontalMarginSum { ... }
double get staffUpperHeight { ... }
double get staffLowerHeight { ... }
double get staffsHeightSum { ... }  // 既存の _staffsHeightsSum と統合
```

### 2. SheetMusicLayout コンストラクタの変更

**Before:**
```dart
SheetMusicLayout(
  this.metrics,
  this.lineColor, {
  required this.widgetHeight,
  required this.widgetWidth,
});
```

**After:**
```dart
SheetMusicLayout({
  required this.musicalSymbols,
  required this.initialClefType,
  required this.initialKeySignatureType,
  required this.metadata,
  required this.paths,
  required this.lineColor,
  required this.widgetWidth,
  required this.widgetHeight,
});
```

### 3. SimpleSheetMusic の変更

**Before:**
```dart
final metricsBuilder = SheetMusicMetrics(
  musicalSymbols,
  initialClefType,
  initialKeySignatureType,
  metadata,
  glyphPath,
);
final layout = SheetMusicLayout(
  metricsBuilder,
  lineColor,
  widgetWidth: width,
  widgetHeight: height,
);
```

**After:**
```dart
final layout = SheetMusicLayout(
  musicalSymbols: musicalSymbols,
  initialClefType: initialClefType,
  initialKeySignatureType: initialKeySignatureType,
  metadata: metadata,
  paths: glyphPath,
  lineColor: lineColor,
  widgetWidth: width,
  widgetHeight: height,
);
```

### 4. テストの移行

`test/sheet_music_metrics_test.dart` → `test/sheet_music_layout_test.dart` にリネーム（または既存ファイルに統合）

- テスト対象クラスを `SheetMusicLayout` に変更
- `MockSheetMusicMetrics` は不要になるため削除

## 実装手順

### Phase 1: 準備

1. [ ] 新規ブランチ作成（例: `feature/consolidate-metrics-to-layout`）
2. [ ] 現状の全テストがパスすることを確認

### Phase 2: SheetMusicLayout の拡張

3. [ ] `sheet_music_layout.dart` に `SheetMusicMetrics` のフィールド・メソッドを追加
4. [ ] コンストラクタを変更（named parameters 化）
5. [ ] `metrics.` プレフィックスを削除し、自身のプロパティを参照するように変更

### Phase 3: 呼び出し元の更新

6. [ ] `simple_sheet_music.dart` の `SheetMusicMetrics` インポート削除
7. [ ] `SimpleSheetMusic.build()` で直接 `SheetMusicLayout` を生成するよう変更

### Phase 4: テストの移行

8. [ ] `test/sheet_music_metrics_test.dart` を `test/sheet_music_layout_test.dart` にリネーム
9. [ ] テスト内の `SheetMusicMetrics` を `SheetMusicLayout` に置換
10. [ ] `test/mock/mock_sheet_music_metrics.dart` を削除

### Phase 5: クリーンアップ

11. [ ] `lib/src/sheet_music_metrics.dart` を削除
12. [ ] エクスポート文の更新（もしあれば）
13. [ ] 全テスト実行・パス確認

### Phase 6: レビュー・マージ

14. [ ] PR 作成
15. [ ] コードレビュー
16. [ ] マージ

## リスクと考慮事項

### リスク

| リスク | 影響度 | 対策 |
|--------|--------|------|
| PR #44 との競合 | 中 | PR #44 マージ後にリベースして解決 |
| 破壊的変更 | 低 | SheetMusicMetrics は internal API のため外部影響なし |
| テスト不足 | 低 | 既存テストをそのまま移行 |

### Issue #27 との関係

Issue #27 では `SheetMusicRenderer` からスケール調整を祖先ウィジェットに移す提案がある。本計画は Issue #27 と直交するため、どちらを先に実施しても問題ない。ただし、将来的に Issue #27 を実施する場合、`SheetMusicLayout` からスケール関連のロジック（`canvasScale`, `_widthScale`, `_heightScale`）を分離する可能性がある。

## 完了条件

- [ ] `SheetMusicMetrics` クラスが削除されている
- [ ] `SheetMusicLayout` に全機能が統合されている
- [ ] 全 85 テストがパス
- [ ] Golden テストがパス
- [ ] example アプリが正常動作

## 参考: PR #43 の統合パターン

PR #43 では以下の統合が行われた：

| Before | After |
|--------|-------|
| `MeasureMetrics` + `MeasureRenderer` | `MeasureRenderer` |
| `StaffMetrics` + `StaffRenderer` | `StaffRenderer` |
| `MusicalSymbolMetrics` + `MusicalSymbolRenderer` | `MusicalSymbolRenderer` |

本計画でも同様に、Metrics クラスの機能を対応するクラスに統合するアプローチを採用する。

---

作成日: 2026-04-27
作成者: Claude Code
