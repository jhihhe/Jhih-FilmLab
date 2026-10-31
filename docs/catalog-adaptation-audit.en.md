# Color recipe adaptation audit

[English](catalog-adaptation-audit.en.md) · [简体中文](catalog-adaptation-audit.md)

Maintainer: `@Jhih he`

## What has been checked

All 77 upstream records are retained, plus 5 Hasselblad-inspired presets: 82 sequential entries, with original Sony fields and fp target values preserved. They currently produce **73 distinct target parameter sets**, not 82 independently verified looks or exact reproductions.

The user reported preview/photo changes in v0.3.4. That evidence does not validate later builds or all recipes. On-camera color acceptance remains **0/82**. Offline checks cover ARM application instructions, 15-slot restoration paths and parameter-slot bounds. API stubs check call order/arguments; they do not prove correct ISP output or real-camera execution.

## Features without an equivalent implementation

| Difference | Recipes affected | Limitation |
| --- | ---: | --- |
| DRO | 77 | Original values retained; Sony Dynamic Range Optimizer not implemented |
| Nonzero color matrix | 5 | Sony PP3 matrices are not written to the Sigma ISP |
| Picture effects | 6 | No equivalent image operation |
| Nonzero EV | 31 | User exposure compensation is not automatically changed |
| Approximate base modes | 6 | Proprietary Sony looks cannot be reproduced by matching enum values |
| White-balance axes | 82 | UI captures support warm/cool and green/magenta trends; raw integer sign and Sony-equivalent step size remain unverified |

Modes named Standard or Vivid do not imply identical curves or matrices across Sony and Sigma. Equal numeric settings do not imply equal strength.

## Values affected by range limits

| Recipe ID | Name | Saturation mapping: Sony → fp |
| --- | --- | --- |
| 8 | Velvia | 5 → 5 |
| 16 | Eterna | -4 → -5 |
| 17 | Eterna Bleach Bypass | -6 → -5 |
| 24 | Fortia 50 | 4 → 5 |
| 30 | GR Bleach Bypass | -6 → -5 |
| 45 | Sony FL | -4 → -5 |
| 46 | Sony IN | -4 → -5 |
| 73 | Olympus Pop Art | 8 → 5 |
| 76 | Agfa Ultra 100 | 6 → 5 |

These are the report's range-normalization/clamping cases. Values are heuristic mappings, not measured color equivalence.

## Identical target parameter groups

- 08 Velvia / 73 Olympus Pop Art
- 17 Eterna Bleach Bypass / 30 GR Bleach Bypass
- 18 Acros / 79 Ilford FP4 / 80 Ilford Delta 100
- 33 GR High Contrast B&W / 71 Panasonic L.Monochrome D
- 34 GR Hard Monotone / 59 Kodak Tri-X 400 / 82 Ilford Pan F 50
- 38 Leica Eternal / 45 Sony FL
- 42 Sony NT / 68 Canon Faithful

Identical target settings do not prove pixel-identical camera output; AWB and scene conditions still vary.

## Captures needed for calibration

An original DNG + JPEG pair can establish a baseline, but cannot prove all recipes match Sony. With the camera powered off, remove the FilmLab startup files (`AutoRun.txt`, `FilmLab.BIN`, and any legacy FilmLab `fpSup.BIN`), fully power-cycle, and record the original camera settings. Do not reset all settings.

Capture a stock Standard baseline at zero contrast/sharpness/saturation, with fixed ISO, exposure, lens/focal length and WB. Record K and offsets, and disable automatic shadow-changing optimization. Include neutral gray/white, skin, red/green/blue, shadows and highlights; a measured physical chart is preferable. Use stable daylight and stable indoor light. Use shutter DNG/JPEG files, not `SS__` screen captures; file prefixes vary with camera configuration.

Source ±3 controls are normalized to fp ±5 indices with rounding and clamping. Auto recipes use Auto (Natural) = 41; fixed-K recipes retain K. Sony Light → PowderBlue, Night → Neutral, and Autumn → SunsetRed are inferred approximations. High-contrast monochrome uses Monochrome/+5 contrast; Pop Color uses +5 saturation; remaining effects are not implemented.

Repeat the same scene, lighting and manual exposure using the selected FilmLab recipe, recording ID and settings. Auto (Natural) captures at zero, A2, B2, G2 and M2 have already been supplied. They do not establish raw setter signs or Sony-equivalent WB steps. Screen/monitor chart photographs are not certified color references.

Matching a Sony recipe additionally requires reference photos from the target Sony camera under matching light/exposure, preferably with RAW. Sigma-only samples do not supply the target color response. Until calibrated, do not label results as a perfect match.

See the [82-entry bilingual catalog](film-catalog.en.md) for exact target values and pending fields.
