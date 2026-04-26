# SMuFL Glyph Catalog 実装計画

## 作成ファイル一覧

| # | ファイルパス | 説明 |
|---|-------------|------|
| 1 | `catalog/pubspec.yaml` | Flutter パッケージ設定 |
| 2 | `catalog/analysis_options.yaml` | Lint 設定 |
| 3 | `catalog/lib/main.dart` | エントリポイント |
| 4 | `catalog/lib/glyph_catalog_page.dart` | カタログ画面 + グリフ定義 |
| 5 | `catalog/lib/glyph_row.dart` | 各グリフ行ウィジェット |
| 6 | `catalog/web/index.html` | Web エントリポイント |
| 7 | `catalog/web/manifest.json` | PWA マニフェスト |
| 8 | `.github/workflows/deploy_catalog.yml` | GitHub Pages デプロイ |

---

## 対象グリフ（29種）

### Clef (3種)
| グリフ名 | コードポイント | 生成コード |
|---------|---------------|-----------|
| gClef | uniE050 | `Clef.treble()` |
| cClef | uniE05C | `Clef.alto()` |
| fClef | uniE062 | `Clef.bass()` |

### Rest (8種)
| グリフ名 | コードポイント | 生成コード |
|---------|---------------|-----------|
| restWhole | uniE4E3 | `Rest(RestType.whole)` |
| restHalf | uniE4E4 | `Rest(RestType.half)` |
| restQuarter | uniE4E5 | `Rest(RestType.quarter)` |
| rest8th | uniE4E6 | `Rest(RestType.eighth)` |
| rest16th | uniE4E7 | `Rest(RestType.sixteenth)` |
| rest32nd | uniE4E8 | `Rest(RestType.thirtySecond)` |
| rest64th | uniE4E9 | `Rest(RestType.sixtyFourth)` |
| rest128th | uniE4EA | `Rest(RestType.hundredTwentyEighth)` |

### Notehead (3種)
| グリフ名 | コードポイント | 生成コード |
|---------|---------------|-----------|
| noteheadWhole | uniE0A2 | `Note(Pitch.c4, noteDuration: NoteDuration.whole)` |
| noteheadHalf | uniE0A3 | `Note(Pitch.c4, noteDuration: NoteDuration.half)` |
| noteheadBlack | uniE0A4 | `Note(Pitch.c4)` |

### Accidental (5種)
| グリフ名 | コードポイント | 生成コード |
|---------|---------------|-----------|
| accidentalFlat | uniE260 | `Note(Pitch.c4, accidental: Accidental.flat)` |
| accidentalNatural | uniE261 | `Note(Pitch.c4, accidental: Accidental.natural)` |
| accidentalSharp | uniE262 | `Note(Pitch.c4, accidental: Accidental.sharp)` |
| accidentalDoubleSharp | uniE263 | `Note(Pitch.c4, accidental: Accidental.doubleSharp)` |
| accidentalDoubleFlat | uniE264 | `Note(Pitch.c4, accidental: Accidental.doubleFlat)` |

### Flag (10種)
| グリフ名 | コードポイント | 生成コード |
|---------|---------------|-----------|
| flag8thUp | uniE240 | `Note(Pitch.c4, noteDuration: NoteDuration.eighth)` |
| flag8thDown | uniE241 | `Note(Pitch.a5, noteDuration: NoteDuration.eighth)` |
| flag16thUp | uniE242 | `Note(Pitch.c4, noteDuration: NoteDuration.sixteenth)` |
| flag16thDown | uniE243 | `Note(Pitch.a5, noteDuration: NoteDuration.sixteenth)` |
| flag32ndUp | uniE244 | `Note(Pitch.c4, noteDuration: NoteDuration.thirtySecond)` |
| flag32ndDown | uniE245 | `Note(Pitch.a5, noteDuration: NoteDuration.thirtySecond)` |
| flag64thUp | uniE246 | `Note(Pitch.c4, noteDuration: NoteDuration.sixtyFourth)` |
| flag64thDown | uniE247 | `Note(Pitch.a5, noteDuration: NoteDuration.sixtyFourth)` |
| flag128thUp | uniE248 | `Note(Pitch.c4, noteDuration: NoteDuration.hundredsTwentyEighth)` |
| flag128thDown | uniE249 | `Note(Pitch.a5, noteDuration: NoteDuration.hundredsTwentyEighth)` |

---

## 検証コマンド

```bash
# ローカル実行
cd catalog && flutter pub get && flutter run -d chrome

# ビルド確認
cd catalog && flutter build web --release --base-href "/simple_sheet_music/"
```

---

## GitHub Pages 設定

リポジトリ Settings > Pages で:
- **Source**: GitHub Actions を選択

---

## デプロイ後URL

`https://tomoyu719.github.io/simple_sheet_music/`
