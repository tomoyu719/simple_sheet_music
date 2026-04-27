# VRT（Visual Regression Testing）導入計画書

## 1. 概要

### 1.1 目的
`simple_sheet_music`パッケージの各音楽記号（音符、休符、音部記号、調号など）の描画結果を視覚的に検証し、意図しない描画変更を検出する。

### 1.2 対象範囲
- **パッケージ**: `simple_sheet_music`（メインパッケージのみ）
- **テスト対象**: 各音楽記号の個別描画

### 1.3 採用ツール
- **[alchemist](https://pub.dev/packages/alchemist)** (Very Good Ventures製)
  - Flutter公式のGolden Testを拡張したツール
  - 複数デバイスサイズでのスナップショット生成が可能
  - CI環境での安定したテスト実行をサポート

---

## 2. テスト対象コンポーネント

| カテゴリ | コンポーネント | ファイル |
|---------|---------------|----------|
| 音部記号 | Clef | `lib/src/music_objects/clef/clef.dart` |
| 音符 | Note (単音) | `lib/src/music_objects/notes/single_note/note.dart` |
| 和音 | ChordNote | `lib/src/music_objects/notes/chord_note/chord_note.dart` |
| 休符 | Rest | `lib/src/music_objects/rest/rest.dart` |
| 調号 | KeySignature | `lib/src/music_objects/key_signature/key_signature.dart` |
| 臨時記号 | Accidental | `lib/src/music_objects/notes/accidental.dart` |
| 加線 | LegerLine | `lib/src/music_objects/notes/legerline.dart` |

---

## 3. 実装計画

### Phase 1: 環境セットアップ

#### 3.1.1 依存関係の追加

```yaml
# pubspec.yaml
dev_dependencies:
  alchemist: ^0.10.0
  flutter_test:
    sdk: flutter
```

#### 3.1.2 ディレクトリ構成

```
test/
├── goldens/                      # Golden画像格納ディレクトリ
│   ├── ci/                       # CI環境用のGolden画像
│   └── macos/                    # ローカル(macOS)用のGolden画像
├── golden_test/
│   ├── alchemist_config.dart     # Alchemist設定
│   ├── clef_golden_test.dart     # 音部記号のGoldenテスト
│   ├── note_golden_test.dart     # 音符のGoldenテスト
│   ├── rest_golden_test.dart     # 休符のGoldenテスト
│   ├── key_signature_golden_test.dart  # 調号のGoldenテスト
│   └── accidental_golden_test.dart     # 臨時記号のGoldenテスト
└── ...
```

#### 3.1.3 Alchemist設定ファイル

```dart
// test/golden_test/alchemist_config.dart
import 'package:alchemist/alchemist.dart';

const kGoldenTestTheme = GoldenTestTheme(
  backgroundColor: Color(0xFFFFFFFF),
);

AlchemistConfig buildAlchemistConfig() {
  return AlchemistConfig(
    theme: kGoldenTestTheme,
    platformGoldensConfig: PlatformGoldensConfig(
      enabled: !isRunningInCi,
    ),
  );
}

bool get isRunningInCi => Platform.environment['CI'] == 'true';
```

### Phase 2: テストケース実装

#### 3.2.1 音部記号（Clef）のテスト例

```dart
// test/golden_test/clef_golden_test.dart
import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

import 'alchemist_config.dart';

void main() {
  goldenTest(
    'clef types render correctly',
    fileName: 'clef_types',
    builder: () => GoldenTestGroup(
      scenarioConstraints: BoxConstraints.tight(const Size(100, 150)),
      children: [
        GoldenTestScenario(
          name: 'treble clef',
          child: _buildClefWidget(ClefType.treble),
        ),
        GoldenTestScenario(
          name: 'bass clef',
          child: _buildClefWidget(ClefType.bass),
        ),
        GoldenTestScenario(
          name: 'alto clef',
          child: _buildClefWidget(ClefType.alto),
        ),
      ],
    ),
  );
}

Widget _buildClefWidget(ClefType type) {
  // 描画用のWidgetを構築
  // 実装詳細はプロジェクトの構造に応じて調整
}
```

#### 3.2.2 テストケース一覧

| テストファイル | テストシナリオ |
|---------------|---------------|
| `clef_golden_test.dart` | Treble, Bass, Alto, Tenor各音部記号 |
| `note_golden_test.dart` | 全音符〜64分音符、付点音符、符尾の向き |
| `rest_golden_test.dart` | 全休符〜64分休符 |
| `key_signature_golden_test.dart` | 長調・短調（♯系・♭系） |
| `accidental_golden_test.dart` | シャープ、フラット、ナチュラル、ダブルシャープ、ダブルフラット |

### Phase 3: CI環境構築

#### 3.3.1 GitHub Actions Workflow

```yaml
# .github/workflows/vrt.yml
name: Visual Regression Test

on:
  push:
    tags:
      - 'v*'  # リリースタグ作成時のみ実行
  workflow_dispatch:  # 手動実行も可能

jobs:
  golden-test:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.24.3"
          channel: stable

      - name: Install dependencies
        run: flutter pub get

      - name: Run Golden Tests
        run: flutter test --tags=golden
        env:
          CI: true

      - name: Upload Golden Failures
        if: failure()
        uses: actions/upload-artifact@v4
        with:
          name: golden-failures
          path: test/failures/
          retention-days: 7
```

---

## 4. 運用ルール

### 4.1 Golden画像の更新フロー

1. **ローカルで変更を確認**
   ```bash
   flutter test --update-goldens --tags=golden
   ```

2. **差分を目視確認**
   - `test/goldens/`配下の変更をGitで確認
   - 意図した変更であることを確認

3. **PRにGolden画像の変更を含める**
   - レビュアーは画像差分を確認

4. **CI用Golden画像の更新**
   ```bash
   CI=true flutter test --update-goldens --tags=golden
   ```

### 4.2 フォント一貫性の確保

- VRTではSMuFLフォント（Bravura/Petaluma）の描画を検証
- フォントファイルはリポジトリに含まれているため、環境差異は最小限
- ただし、OS間でのアンチエイリアス差異に注意

### 4.3 失敗時の対応

| 状況 | 対応 |
|------|------|
| 意図した変更による失敗 | Golden画像を更新してコミット |
| 意図しない変更による失敗 | 原因を調査し、コードを修正 |
| 環境差異による失敗 | CI環境用のGolden画像を別途管理 |

---

## 5. スケジュール

| Phase | 内容 | 期間目安 |
|-------|------|---------|
| Phase 1 | 環境セットアップ・設定ファイル作成 | 1日 |
| Phase 2 | テストケース実装（音部記号、音符） | 2-3日 |
| Phase 2 | テストケース実装（休符、調号、臨時記号） | 2-3日 |
| Phase 3 | CI環境構築・動作確認 | 1日 |
| - | レビュー・調整 | 1日 |

---

## 6. リスクと対策

| リスク | 影響 | 対策 |
|--------|------|------|
| OS間のレンダリング差異 | CI/ローカルで結果が異なる | CI専用のGolden画像を管理 |
| Flutterバージョン更新 | Golden画像の再生成が必要 | バージョン固定、更新時に再生成 |
| フォントレンダリング変更 | 全Golden画像の更新が必要 | フォントバージョンを固定 |

---

## 7. 参考資料

- [alchemist pub.dev](https://pub.dev/packages/alchemist)
- [Flutter Golden Tests Documentation](https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html)
- [Very Good Ventures - Golden Testing Guide](https://verygood.ventures/blog/golden-testing-with-flutter)

---

## 8. 承認欄

| 役割 | 氏名 | 日付 | 署名 |
|------|------|------|------|
| 作成者 | | | |
| レビュアー | | | |
| 承認者 | | | |
