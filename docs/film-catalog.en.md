# Sigma fp film simulation recipe catalog — 82 entries

[English / 中英对照](film-catalog.en.md) · [简体中文](film-catalog.md) · [Project home](../README.md)

Maintainer: `@Jhih he`

**82 named recipes, 73 distinct target parameter sets. On-camera color acceptance: 0/82.** Brand and film names are style references, not exact reproductions or official partnerships. Values below are candidate configuration values, not measured color matches.

## Read the parameters

Color/WB are firmware mode identifiers; K is fixed color temperature when used (0 is the stored value for recipes using another WB mode). AB/GM are candidate white-balance offsets, not calibrated Sony-equivalent steps. Contrast, sharpness and saturation are UI indices; the runtime maps their ±5 range to even setter values in ±10. Recipe 22 uses Toning 7; all others use 0. The Chinese and English tables describe the same existing data; this documentation update changes no parameters.

| ID (Sony ID) | Brand / 品牌 | Recipe / 配方 | fp color / WB / K / AB / GM | Contrast / sharpness / saturation / Toning | Clamped fields | Pending / unsupported fields |
| --- | --- | --- | --- | --- | --- | --- |
| 1 (60) | Hasselblad / 哈苏 | HNCS Natural / 哈苏 HNCS 自然色 | 2/41/0/0/0 | -2/0/-2/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 2 (added) | Hasselblad / 哈苏 | Nature Soft / 哈苏参考 · 自然柔和 | 2/41/0/0/0 | 0/-1/0/0 | none | hncs_not_recreated, wb_offset_direction_uncalibrated |
| 3 (added) | Hasselblad / 哈苏 | Portrait Soft / 哈苏参考 · 柔和人像 | 3/41/0/0/0 | -2/-1/0/0 | none | hncs_not_recreated, wb_offset_direction_uncalibrated |
| 4 (added) | Hasselblad / 哈苏 | Landscape Clear / 哈苏参考 · 清透风景 | 4/41/0/0/0 | 0/-1/1/0 | none | hncs_not_recreated, wb_offset_direction_uncalibrated |
| 5 (added) | Hasselblad / 哈苏 | Warm Daylight / 哈苏参考 · 暖日光 | 2/70/5600/1/0 | -1/-1/0/0 | none | hncs_not_recreated, wb_offset_direction_uncalibrated |
| 6 (added) | Hasselblad / 哈苏 | True HNCS Community / 哈苏参考 · True HNCS 社区适配 | 3/41/0/1/0 | -1/1/1/0 | none | hncs_not_recreated, wb_offset_direction_uncalibrated, community_controls_not_supported |
| 7 (9) | Fujifilm / 富士 | Provia Standard / Provia 标准 | 0/41/0/0/0 | 0/0/2/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 8 (10) | Fujifilm / 富士 | Velvia Vivid / Velvia 鲜艳 | 1/41/0/0/0 | 3/0/5/0 | sat | wb_offset_direction_uncalibrated, matrix, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 9 (11) | Fujifilm / 富士 | Astia Soft / Astia 柔和 | 3/41/0/1/0 | -2/0/0/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 10 (12) | Fujifilm / 富士 | Classic Chrome / 经典正片 | 0/41/0/3/-1 | 3/0/-2/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 11 (13) | Fujifilm / 富士 | Classic Negative / 经典负片 | 0/41/0/-1/-1 | 5/2/-5/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 12 (14) | Fujifilm / 富士 | Nostalgic Negative / 怀旧负片 | 0/41/0/3/0 | 0/0/2/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 13 (15) | Fujifilm / 富士 | Reala Ace / Reala Ace | 0/41/0/0/0 | 2/0/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 14 (16) | Fujifilm / 富士 | Pro Neg Standard / Pro Neg 标准 | 3/41/0/0/0 | -2/0/-3/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 15 (17) | Fujifilm / 富士 | Pro Neg High / Pro Neg 高反差 | 3/41/0/0/0 | 2/0/-3/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 16 (18) | Fujifilm / 富士 | Eterna Cinema / Eterna 电影 | 2/41/0/0/0 | -3/-2/-5/0 | sat | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 17 (19) | Fujifilm / 富士 | Eterna Bleach Bypass / Eterna 漂白旁路 | 2/41/0/0/0 | 5/0/-5/0 | sat | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 18 (20) | Fujifilm / 富士 | Acros / Acros 黑白 | 11/41/0/0/0 | 2/2/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 19 (21) | Fujifilm / 富士 | Acros Yellow Filter / Acros + 黄滤镜 | 11/70/4000/0/0 | 2/2/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 20 (22) | Fujifilm / 富士 | Acros Red Filter / Acros + 红滤镜 | 11/70/2500/0/0 | 5/0/0/0 | none | wb_offset_direction_uncalibrated, pe, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 21 (23) | Fujifilm / 富士 | Acros Green Filter / Acros + 绿滤镜 | 11/70/5600/0/-4 | 2/2/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 22 (24) | Fujifilm / 富士 | Sepia / 棕褐色调 | 11/41/0/0/0 | 0/0/0/7 | none | style_approximation, wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 23 (25) | Fujifilm / 富士 | Pro 400H / 富士 Pro 400H | 13/41/0/-1/-1 | -3/0/-3/0 | none | style_approximation, wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 24 (26) | Fujifilm / 富士 | Fortia 50 / 富士 Fortia 50 | 1/41/0/-1/0 | 3/0/5/0 | sat | wb_offset_direction_uncalibrated, matrix, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 25 (27) | Fujifilm / 富士 | Superia 400 / 富士 Superia 400 | 0/41/0/1/-1 | 2/0/2/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 26 (28) | Fujifilm / 富士 | C200 / 富士 C200 | 0/41/0/-1/-1 | 0/0/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 27 (29) | Fujifilm / 富士 | Natura 1600 / 富士 Natura 1600 | 3/41/0/1/0 | -3/0/-3/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 28 (48) | Ricoh GR / 理光 GR | Positive Film / GR 正片 | 0/41/0/2/0 | 3/0/5/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 29 (49) | Ricoh GR / 理光 GR | Negative Film / GR 负片 | 2/41/0/-1/-1 | 2/0/-3/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 30 (50) | Ricoh GR / 理光 GR | Bleach Bypass / GR 漂白旁路 | 2/41/0/0/0 | 5/0/-5/0 | sat | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 31 (51) | Ricoh GR / 理光 GR | Retro / GR 复古 | 0/41/0/3/1 | -2/0/-5/0 | none | wb_offset_direction_uncalibrated, pe, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 32 (52) | Ricoh GR / 理光 GR | Cross Process / GR 交叉冲洗 | 1/41/0/-2/-4 | 3/0/3/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 33 (53) | Ricoh GR / 理光 GR | High Contrast BW / GR 高反差黑白 | 11/41/0/0/0 | 5/2/0/0 | none | wb_offset_direction_uncalibrated, pe, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 34 (54) | Ricoh GR / 理光 GR | Hard Monotone / GR 硬调单色 | 11/41/0/0/0 | 3/3/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 35 (55) | Ricoh GR / 理光 GR | Soft Monotone / GR 柔调单色 | 11/41/0/0/0 | -3/-2/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 36 (56) | Leica / 徕卡 | Contemporary / 徕卡 当代 | 0/41/0/0/0 | 2/0/2/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 37 (57) | Leica / 徕卡 | Classic / 徕卡 经典 | 0/41/0/1/0 | 3/0/-2/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 38 (58) | Leica / 徕卡 | Eternal / 徕卡 永恒 | 2/41/0/1/0 | -2/0/-5/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 39 (59) | Leica / 徕卡 | Monochrom / 徕卡 Monochrom 黑白 | 11/41/0/0/0 | 3/2/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 40 (1) | Sony / 索尼 | Standard / 出厂默认（标准） | 0/41/0/0/0 | 0/0/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 41 (2) | Sony / 索尼 | Portrait PT / 索尼 PT（肖像） | 3/41/0/0/0 | 0/0/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 42 (3) | Sony / 索尼 | Neutral NT / 索尼 NT（中性） | 2/41/0/0/0 | 0/0/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 43 (4) | Sony / 索尼 | Vivid VV / 索尼 VV（生动） | 1/41/0/0/0 | 0/0/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 44 (5) | Sony / 索尼 | Vivid VV2 / 索尼 VV2 | 1/41/0/0/0 | 2/0/3/0 | none | wb_offset_direction_uncalibrated, matrix, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 45 (6) | Sony / 索尼 | Film FL / 索尼 FL（胶片感） | 2/41/0/1/0 | -2/0/-5/0 | sat | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 46 (7) | Sony / 索尼 | Instant IN / 索尼 IN（即时感） | 2/41/0/0/1 | -5/0/-5/0 | sat | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 47 (8) | Sony / 索尼 | Soft High Key SH / 索尼 SH（柔和高亮） | 13/41/0/1/0 | -3/0/-3/0 | none | style_approximation, wb_offset_direction_uncalibrated, pe, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 48 (30) | Kodak / 柯达 | Portra 160 / 柯达 Portra 160 | 3/41/0/1/1 | -3/0/-5/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 49 (31) | Kodak / 柯达 | Portra 400 / 柯达 Portra 400 | 3/41/0/3/-1 | -2/0/-2/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 50 (32) | Kodak / 柯达 | Portra 800 / 柯达 Portra 800 | 3/41/0/1/-1 | -3/0/-3/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 51 (33) | Kodak / 柯达 | Gold 200 / 柯达金 200 | 0/41/0/3/-1 | 2/0/3/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 52 (34) | Kodak / 柯达 | UltraMax 400 / 柯达 Ultra Max 400 | 0/41/0/0/-1 | 0/0/0/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 53 (35) | Kodak / 柯达 | ColorPlus 200 / 柯达 Color Plus 200 | 0/41/0/2/-1 | 2/0/2/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 54 (36) | Kodak / 柯达 | Ektar 100 / 柯达 Ektar 100 | 0/41/0/0/0 | 2/2/5/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 55 (37) | Kodak / 柯达 | E100 Reversal / 柯达 E100 反转片 | 0/41/0/-1/0 | 2/0/5/0 | none | style_approximation, wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 56 (38) | Kodak / 柯达 | Kodachrome 64 / 柯达克罗姆 64 | 1/41/0/-1/0 | 3/2/5/0 | none | style_approximation, wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 57 (39) | Kodak / 柯达 | Vision3 500T Daylight / 柯达 Vision3 500T（日光） | 2/70/3200/0/0 | 0/0/-2/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 58 (40) | Kodak / 柯达 | Vision 200T Asteroid City / 柯达 Vision 200T（小行星城） | 2/70/5000/2/-3 | -5/0/-3/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 59 (41) | Kodak / 柯达 | Tri-X 400 / 柯达 Tri-X 400 | 11/41/0/0/0 | 3/3/0/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 60 (42) | Kodak / 柯达 | T-Max / 柯达 T-Max | 11/41/0/0/0 | 3/5/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 61 (43) | Kodak / 柯达 | Tri-X 1600 Push / 柯达 Tri-X 1600（增感） | 11/41/0/0/0 | 5/0/0/0 | none | wb_offset_direction_uncalibrated, pe, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 62 (44) | CineStill / 电影静帧 | 50D Blue Velvet / Cinestill 50D（蓝丝绒） | 0/70/5500/-1/1 | -2/0/-3/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 63 (45) | CineStill / 电影静帧 | 800T / Cinestill 800T | 2/70/3200/0/1 | 0/0/0/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 64 (46) | Cinema / 电影风格 | Classic Cinema / 经典电影色 | 0/70/6000/2/0 | -2/0/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 65 (47) | Cinema / 电影风格 | Rec709 Flat / Rec709 视频（偏平直） | 2/41/0/0/0 | -3/0/-3/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 66 (61) | Canon / 佳能 | Standard / 佳能 标准 | 0/41/0/1/1 | 2/0/2/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 67 (62) | Canon / 佳能 | Portrait / 佳能 肖像 | 3/41/0/1/1 | 0/-2/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 68 (63) | Canon / 佳能 | Faithful / 佳能 可靠 | 2/41/0/0/0 | 0/0/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 69 (64) | Nikon / 尼康 | Flat / 尼康 平面 | 2/41/0/0/0 | -5/-2/-5/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 70 (65) | Nikon / 尼康 | Vivid / 尼康 鲜艳 | 1/41/0/0/0 | 2/2/2/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 71 (66) | Panasonic / 松下 | L.Monochrome D / 松下 L.单色 D | 11/41/0/0/0 | 5/2/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 72 (67) | Panasonic / 松下 | L.Classic Neo / 松下 L.经典 Neo | 2/41/0/2/0 | -2/0/-5/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 73 (68) | Olympus / 奥林巴斯 | Pop Art / 奥林巴斯 流行艺术 | 1/41/0/0/0 | 3/0/5/0 | sat | wb_offset_direction_uncalibrated, matrix, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 74 (69) | Olympus / 奥林巴斯 | Pale Light Color / 奥林巴斯 淡彩轻快 | 13/41/0/0/0 | -3/0/-5/0 | none | style_approximation, wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 75 (70) | Agfa / 爱克发 | Vista 200 / 爱克发 Vista 200 | 0/41/0/2/1 | 2/0/3/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 76 (71) | Agfa / 爱克发 | Ultra 100 / 爱克发 Ultra 100 | 1/41/0/0/0 | 2/0/5/0 | sat | wb_offset_direction_uncalibrated, matrix, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 77 (72) | Polaroid / 宝丽来 | Instant / 宝丽来 / 拍立得 | 0/41/0/1/2 | -3/0/-5/0 | none | wb_offset_direction_uncalibrated, pe, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 78 (73) | Ilford / 伊尔福德 | HP5 / 伊尔福德 HP5 | 11/41/0/0/0 | 2/0/0/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 79 (74) | Ilford / 伊尔福德 | FP4 / 伊尔福德 FP4 | 11/41/0/0/0 | 2/2/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 80 (75) | Ilford / 伊尔福德 | Delta 100 / 伊尔福德 Delta 100 | 11/41/0/0/0 | 2/2/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 81 (76) | Ilford / 伊尔福德 | Delta 3200 / 伊尔福德 Delta 3200 | 11/41/0/0/0 | 5/-3/0/0 | none | wb_offset_direction_uncalibrated, ev, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |
| 82 (77) | Ilford / 伊尔福德 | Pan F 50 / 伊尔福德 Pan F 50 | 11/41/0/0/0 | 3/3/0/0 | none | wb_offset_direction_uncalibrated, dro, normalized_strength_heuristic, wb_step_equivalence_unmeasured |

See the [adaptation audit](catalog-adaptation-audit.en.md) for unsupported fields, identical target groups and calibration requirements, and the [test guide](native-testing.en.md) for loading, controls and recovery.
