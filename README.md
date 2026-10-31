<div align="center">

# 🎞️ Jhih’s FilmLab

**给 Sigma fp 多一点玩色彩的空间。**

![Camera](https://img.shields.io/badge/Camera-Sigma%20fp-20252b?style=for-the-badge)
![Firmware](https://img.shields.io/badge/Firmware-5.02-697f66?style=for-the-badge)
![Recipes](https://img.shields.io/badge/Recipes-82-d89173?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-实验中-e3a648?style=for-the-badge)
![License](https://img.shields.io/badge/License-非商业分享-7d8fa0?style=for-the-badge)

用相机的时候，想在取景、拍摄前就切换喜欢的色调。于是有了这个基于 fpSup 思路开发的机内实验项目。

</div>

> **现在还是测试项目。** v0.7.5 只完成离线检查，尚未完成实机启动与 82 项色彩验收；请不要把它当成稳定版或官方产品。

## 📷 这个项目在做什么？

- 🎨 整理了 **82 个色彩方案**，顺序优先哈苏、富士、理光 GR、徕卡等风格。
- 🔄 目标是在 Sigma fp 的预览画面中用按键切换，并显示中英文名称和风格提示。
- 🧪 用相机原有色彩参数做近似适配。82 个名字目前对应 **73 组不同参数**，并不是各品牌原机色彩的精确复刻。
- 🧭 在研究原厂 COLOR 菜单接入，但**目前还没有集成到发布版本**。

```mermaid
flowchart LR
    A[选择色彩方案] --> B[转换为 fp 参数]
    B --> C[相机预览与 JPEG]
    C --> D[实拍对照与逐项调整]
```

## 🔍 现在到哪一步了？

| 项目 | 状态 |
| --- | --- |
| 早期 v0.3.4 | 使用者确认切换时预览和照片会变化 |
| v0.7.5 Sepia 候选 | 已离线测试；**尚未完成相机实测** |
| 82 项色彩验收 | **0 / 82**，等待实拍和目标样片 |
| 原厂 COLOR 菜单 | 研究中，尚未加入安装包 |

Sony 的矩阵、部分特效、动态范围优化等没有得到等效实现，哈苏和其他品牌名称表示**风格参考**，不代表官方授权或相同色彩。相机固件本身和厂商图像处理算法没有在这里分发。

## 📦 源码与下载

这里先公开可区分的第一方实验源码、方案清单和保留 MIT 许可的上游配方数据。由于当前使用的 fpSup 固定版本没有随仓库提供明确的再分发许可证，**此仓库暂不包含 fpSup 加载器及其构建产物，也不提供可直接安装的 ZIP**。独立取得相应权限及依赖之前，本仓库内容不能单独构建完整安装包。

- [82 个方案清单](docs/film-catalog.md)
- [适配差异与已知限制](docs/catalog-adaptation-audit.md)
- [机内测试说明](docs/native-testing.md)（给已有测试包的用户；测试版未完成实机验收）
- [fpSup 上游项目](https://github.com/ijigen/fpSup)

## 🕹️ 计划中的使用方式

仅针对 **Sigma fp 固件 5.02**。已有匹配测试包的情况下，在拍摄预览界面按住 AEL：左/右切换一项，上/下切换十项，OK 恢复启动时保存的设置。组合键不会屏蔽原厂按键功能；开机与参数恢复行为需继续实测。卸载时关闭相机，移走卡根目录的 `AutoRun.txt` 和 `FilmLab.BIN`，完全断电重启；此前已写入相机的设置可能仍需检查或手动恢复。

## 🤝 一起玩，也一起把问题说清楚

如果你也用 Sigma fp，欢迎关注进展、提 Issue，分享你遇到的情况。喜欢这个方向的话，点个 **Star ⭐**，之后更新也方便找到。

维护者：**@Jhih he**。本项目与 SIGMA、Hasselblad、Fujifilm、Ricoh 或 Leica 无官方隶属关系。

## 📜 许可与来源

第一方内容按 [非商业使用许可](LICENSE) 分享。这属于**源代码可见的非商业许可**，不符合开源促进会（OSI）的开源定义。第三方内容各自适用其原许可：配方来源 [recipe-lab-sony-pmca-cn](https://github.com/jcx396905-gif/recipe-lab-sony-pmca-cn)，保留原作者 André Domingues 的 [MIT 许可](vendor/sony-recipe-lab/LICENSE)；加载方式参考 [fpSup](https://github.com/ijigen/fpSup)，作者 ijigen，相关代码未在此重新分发。
