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

> [!WARNING]
> **使用前请先了解风险：这是未经完整实机验收的实验测试包，仅适用于 Sigma fp 固件 5.02，不适用于 fp L 或其他固件版本。**
>
> 可能出现卡屏、死机、异常重启、预览或照片异常、拍摄/录制中断，以及未保存影像或数据丢失。早期开发版本曾出现开机卡死；最新版本的安全性与稳定性尚无法保证。82 个色彩方案均未完成逐项实机颜色验收。
>
> 请先备份照片并记录原相机设置，使用备用卡测试，勿用于重要拍摄。机内 RAM 加载不等于零风险：写入的白平衡、色彩等设置可能保留，删除启动文件不会自动撤销这些设置。
>
> **若卡死：**先尝试关机；无法关机时断开外接电源并取出电池。用读卡器移走卡根目录的 `AutoRun.txt` 和 `FilmLab.BIN`，完全断电后重启，再核对并手动恢复原设置。运行正常时可尝试 AEL＋OK 恢复本次启动快照，但该恢复行为仍待实测，断电后快照不会保留。

![早期相机屏幕演示](assets/fp-screen-example.jpg)

<sub>早期版本的相机屏幕截图；最新候选版仍待实测。</sub>

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

**[⬇️ 下载 v0.7.5 Sepia 测试包](downloads/Jhih-FilmLab-v0.7.5-sepia-candidate.zip)** · 仅 Sigma fp 固件 **5.02**

SHA-256：`f8d2e10326063574f2b3437afb050d01cd9b0e884eb2ab918d8a743d849634ba`

这是候选测试包，包含 AutoRun.txt、FilmLab.BIN 和中文机内测试说明；**尚未确认该版本实机启动、稳定性或 82 项色彩验收**。它引用 fpSup 加载方式；所用上游版本未发现明确再分发许可，也尚未取得作者授权。源码仓库不包含 fpSup 加载器源码，不能单独构建完整安装包。

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

第一方内容按 [非商业使用许可](LICENSE) 分享。这属于**源代码可见的非商业许可**，不符合开源促进会（OSI）的开源定义。第三方内容各自适用其原许可：配方来源 [recipe-lab-sony-pmca-cn](https://github.com/jcx396905-gif/recipe-lab-sony-pmca-cn)，保留原作者 André Domingues 的 [MIT 许可](vendor/sony-recipe-lab/LICENSE)；加载方式参考 [fpSup](https://github.com/ijigen/fpSup)，作者 ijigen，安装 ZIP 含其加载代码；当前尚未取得上游作者再分发授权。
