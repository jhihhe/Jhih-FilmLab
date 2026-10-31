# Sigma fp camera test guide — v0.7.5 Sepia candidate

[English](native-testing.en.md) · [简体中文](native-testing.md) · [Project home](../README.md)

Maintainer: `@Jhih he`

> [!WARNING]
> **Only Sigma fp firmware 5.02. Not fp L. Offline validation only: current-version startup, stability, HUD and restoration have not completed camera testing. Color acceptance: 0/82.**
>
> Freezes, crashes, unexpected restarts, abnormal images, interrupted shooting/recording, and loss of unsaved images/data are possible. Early development builds froze after startup. Back up images, record your settings, use a spare SD card and avoid important shoots. Settings may persist after uninstalling; RAM loading is not a guarantee of safety.

This is an SD-card runtime program, not an official firmware update. v0.7.5 sets the Toning candidate to **7 for recipe 22 (Sepia)** and 0 for the other recipes. This is an offline-analysis candidate, not a verified color match. The existing ZIP contains Chinese instructions; this page supplies English guidance without changing the binary package.

## 1. Prepare and load

1. Confirm the camera is a **Sigma fp on 5.02**. Back up the card and photograph or write down original color, white-balance, Effect/Toning and button settings.
2. Read the [adaptation limits](catalog-adaptation-audit.en.md) and [third-party notices](../NOTICE.md). No upstream fpSup redistribution permission has been obtained.
3. Power off the camera. Copy the matching package's `AutoRun.txt` and `FilmLab.BIN` to the SD card root. Do not mix an old AutoRun configuration with a different BIN. Remove a legacy `fpSup.BIN` if it is from an older FilmLab setup; preserve a backup first.
4. Start the camera normally. Do **not** choose the official firmware-update command. The intended behavior is one runtime load per startup.
5. For initial tests use normal still-photo live view and a single JPEG capture. Stop at any unusual behavior. This is a test procedure, not a statement that the build has passed it.

## 2. Switch recipes

Hold **AEL**, then press:

| Button | Intended action |
| --- | --- |
| Left / Right | Move one recipe; wraps around 82 entries |
| Up / Down | Move ten recipes |
| OK | Restore the settings captured at this startup |

Holding a direction is not intended to repeat. Release and press it again. Do not switch in stock menus or playback. FilmLab listens to button events but does not suppress the camera's own button actions. The original function assigned to AEL can therefore still run.

The restoration snapshot lives in RAM and is lost after power-off. A successful setter or offline readback does not prove correct camera storage or image processing.

## 3. Read the HUD

- First line: Chinese brand + English recipe name, for example `哈苏 · Nature Soft`.
- Second line: recipe index and a short Chinese style description, for example `02/82` with neutral/soft/low-sharpness hints.
- Intended presentation: white letters with a black outline, no solid background bar; second line hides after about three seconds, restarting its timer on each switch.
- Names are ordered Hasselblad → Fujifilm → Ricoh GR → Leica → others. Use the [bilingual catalog](film-catalog.en.md) to identify all recipes.
- Chinese brand labels: 哈苏 = Hasselblad; 富士 = Fujifilm; 理光 GR = Ricoh GR; 徕卡 = Leica; 索尼 = Sony; 柯达 = Kodak; 伊尔福德 = Ilford.
- `准备就绪` means ready; `原始设置` means original/startup settings. These messages indicate intended program state, not completed color acceptance.

An English-only camera HUD is not implemented. Rendering, clearing, flicker and recovery after capture/playback still need hardware acceptance.

## 4. Distinguish screenshots from photographs

FilmLab does not automatically remap AEL. Check the camera's custom-button menu: if AEL is assigned to **Screenshot**, choose **AEL (Pressed)** or another function appropriate for your workflow. Check playback filtering as well; a Screenshot-only filter can hide ordinary photos.

Camera screenshots use `SS__xxxx.JPG` and are 1024 × 682 JPEGs. They are not suitable RAW/JPEG color-calibration samples. Use the shutter and check the resulting file name. FilmLab does not delete photos or change the playback filter automatically. See the [SIGMA fp firmware 5.0 English manual](https://www.sigma-global.com/en/support/download/fp_Manual_FW_Ver.5.0_EN_2.pdf), pages 88, 141 and 161, for the stock Screenshot and button/filter functions.

## 5. Stop loading or recover from a freeze

1. Try switching the camera off normally.
2. If it does not respond, disconnect all external power and remove the battery.
3. Use a card reader to remove `AutoRun.txt` and `FilmLab.BIN` from the card root. An older FilmLab installation may also have `fpSup.BIN`; do not leave a different loader configuration active.
4. Fully power-cycle the camera, then inspect and manually restore your recorded settings if needed.

Removing the files restores the normal startup path; it does **not** guarantee reversal of previously written settings or recovery of lost data. Do not reset all camera settings as a routine test step.

## 6. Record the actual camera result

Check cold startup, readable names on bright/dark backgrounds, no leftover key diagnostics, name changes from long to short, and correct HUD clearing. Capture and play back a normal shutter photo. Confirm no unintended `SS__` screenshots. Check switching, restoration and original color/WB/Effect/Toning values.

Stop testing if the display turns black, stock icons disappear, flickering occurs or the camera freezes. Report the exact step, firmware/build, recipe number and settings in English or Chinese. Do not call a recipe accepted merely because its name changed or its setters returned success. Controlled RAW/JPEG captures and target-camera references are needed to assess color matching.

## Technical and version notes

| Version / mechanism | Meaning and limits |
| --- | --- |
| v0.3.4 | User reported preview and photo changes; does not validate later builds |
| v0.5.x mapping | Sony ±3 controls scaled to fp ±5 with rounding/clamping; heuristic, not optical calibration. AWB recipes use Auto (Natural) = 41; recipes with a fixed K retain it |
| v0.7.0 HUD | Two-line bilingual HUD; local simulation does not prove rendering stability |
| v0.7.1 ABI | UI ±5 indices map to even setter values ±10; PowderBlue mode 13 maps to parameter slot 12. Old builds could send unsupported odd values |
| v0.7.2 baseline | Explicit Effect/Toning baseline and original-value restoration; current v0.7.5 Sepia exception is Toning 7 for recipe 22 |
| v0.7.3 | Do not use: it did not fully bypass monochrome WB-mode zeroing and could retry continuously or address the wrong WB slot |
| v0.7.4 WB fix | Reads raw WB mode/temperature and uses explicit firmware slots for BA/GM. Prepared-environment execution across 12 modes is not 12-mode camera acceptance |
| v0.7.5 | Sepia Toning candidate 7; no completed on-camera color acceptance |

Application completion requires parameter readback. Busy skips remain pending and retry at roughly 500 ms. Mode rechecks reduce false success but do not provide an atomic cross-thread guarantee. BA/GM snapshots use raw property words to preserve offsets hidden by monochrome getters. Offline ARM/API-stub tests do not establish ISP equivalence, hardware storage correctness or stability.

Stock COLOR-menu integration is not included. 77 upstream recipes and 5 additional Hasselblad-inspired presets remain in the 82-entry catalog, with 73 distinct parameter sets. No exact reproduction or “perfect adaptation” is claimed.
