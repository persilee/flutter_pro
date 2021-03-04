
![Flutter](https://cdn.lishaoy.net/flutterInstall/flutter_run5.png)

# Flutter 小案例

[![author](https://img.shields.io/badge/author-persilee-orange.svg)](https://github.com/persilee) [![blog](https://img.shields.io/badge/blog-lishaoy.net-blue.svg)](https://h.lishaoy.net)

这是一个基于 **Flutter** 的跨平台(iOS/Android)移动应用小案例，包含了一些基础 `Widget`、`provider`、`stream` 等的使用案例和一个完整的 `MVVM` 开发模式图片分享APP 。

移步 [点击观看Demo演示视频](https://www.bilibili.com/video/BV11t4y197cA/) 

移步 [点击观看Image App(MVVM Demo)演示视频](https://www.bilibili.com/video/BV1ur4y1A7of)

Tip: Image App 可以使用登录账户信息：
任意一个作者名字，密码都是：666666，如：

|  用户名      |     密码      |
|:---------:|:---------------:|
|persilee     |  密码：666666|
|摄影师蝈蝈小姐 |   密码：666666|
|翠花小拍      |  密码：666666|

或者，扫描二维码下载体验(android)：[flutterCase.apk](https://github.com/persilee/flutter_pro/releases/download/v1.0.2/flutterCase1.0.2.apk) ，iOS请自行运行代码体验效果

![用手机扫描下载体验](https://cdn.lishaoy.net/image/flutterMVVM/flutterCase1.0.2.png)

### 案例列表

基础小部件的使用，如下

| 序号  |                              案例(Base Widget Demo)             |
|:----:|:--------------------------------------------------------------  |
|   1  | [FloatingActionButtonDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/floating_action_button_demo.dart)      |
|   2  | [ButtonDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/button_demo.dart)     |
|   3  | [PopupMenuButtonDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/popup_menu_button_demo.dart) |
|   4  | [SimpleDialogDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/simple_dialog_demo.dart) |
|   5  | [AlertDialogDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/alert_dialog_demo.dart) |
|   6  | [BottomSheetDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/bottom_sheet_demo.dart) |
|   7  | [SnackBarDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/snack_bar_demo.dart) |
|   8  | [ExpansionPanelDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/expansion_panel_demo.dart) |
|   9  | [ChipDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/chip_demo.dart) |
|   10 | [DataTableDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/data_table_demo.dart) |
|   11 | [PaginatedDataTableDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/paginated_table_demo.dart) |
|   12 | [StepperDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/stepper_demo.dart) |
|   13 | [GridViewExtentDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/view_demo.dart) |
|   14 | [GridViewCountDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/view_demo.dart) |
|   15 | [LayoutDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/layout_demo.dart) |
|   16 | [SliverDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/sliver_demo.dart) |
|   17 | [ListViewDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/listview_demo.dart) |
|   18 | [CardDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/card_demo.dart) |
|   19 | [NavigatorDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/navigator_demo.dart) |
|   20 | [FormsDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/forms_demo.dart) |
|   21 | [TabBarView](https://github.com/persilee/flutter_pro/blob/master/lib/main.dart) |
|   22 | [DrawerDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/base_widget_demo/drawer_demo.dart) |

**provider** 的使用，如下

| 序号  |                              案例(provider🍷riverpod)                              |
|:----:|:--------------------------------------------------------------  |
|   1  | [ProviderCounterDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/provider_demo/provider_counter_demo.dart) 跨页面状态共享    |
|   2  | [ProviderGoodsListDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/provider_demo/goods_list_demo.dart) 使用 `Selector` 更新局部（小范围）状态   |
|   3  | [RiverPodDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/provider_demo/reverpod_page.dart) 使用 `RiverPod` 更优雅的管理state   |

**futureBuilder** 、 **streamBuilder** 的使用，如下

| 序号  |                              案例(stream)                              |
|:----:|:--------------------------------------------------------------  |
|   1  | [BaseStatefulDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/stream_demo/base_stateful_demo.dart) 基本的有状态 `Widget` 的使用   |
|   2  | [FutureBuilderDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/stream_demo/future_builder_demo.dart) `futureBuilder` 的使用  |
|   3  | [StreamBuilderDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/stream_demo/stream_builder_demo.dart)  `streamBuilder` 的使用且拆分UI和逻辑代码，更符合规范代码 |

**flutter flare** 的使用，如下

| 序号  |                              案例(flare)                              |
|:----:|:--------------------------------------------------------------  |
|   1  | [FlareSignInDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/flare_demo/flare_sign_in_demo.dart) 有趣的登录交互动画   |
|   2  | [FlareButtonDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/flare_demo/flare_button_demo.dart) 按钮动画   |
|   3  | [FlareSidebarMenuDemo](https://github.com/persilee/flutter_pro/blob/master/lib/demo/flare_demo/flare_sidebar_menu_demo.dart) 有趣的边栏动画   |


**flutter MVVM** 开发模式，如下
| 序号  |                              案例                        |
|:----:|:--------------------------------------------------------------  |
|   1  | [Http 模块](https://github.com/persilee/flutter_pro/tree/master/lib/http) 使用 Dio 和 retrofit 封装的网络请求模块   |
|   2  | [Model 数据模块](https://github.com/persilee/flutter_pro/tree/master/lib/models) rest api 请求json的序列化   |
|   3  | [View 模块](https://github.com/persilee/flutter_pro/tree/master/lib/pages) 展示的页面UI   |
|   4  | [ViewModel VM模块](https://github.com/persilee/flutter_pro/tree/master/lib/view_model) 处理页面数据、状态以及业务逻辑等   |
|   5  | [Utils](https://github.com/persilee/flutter_pro/tree/master/lib/utils) 一些工具类   |
|   6  | [Widgets](https://github.com/persilee/flutter_pro/tree/master/lib/widgets) 公共的组件和自定义组件等   |

### 更新日志

- 2021-02-23 23:26 新增 riverpod、Retrofit MVVM 开发模式 案例
- 2021-01-14 09:22 新增 riverpod 案例、provider 更新成 riverpod
- 2021-01-14 00:36 修复图片链接丢失问题及升级flutter sdk的代码问题
- 2020-07-04 00:46 发布 release v1.0.1 版
- 2020-06-30 14:26 新增 flutter flare 动画交互案例
- 2020-06-28 09:56 发布 release v1.0.0 版
- 2020-06-28 08:44 新增 My Page 案例
- 2020-06-28 07:15 新增 **futureBuilder** 、 **streamBuilder** 的使用案例
- 2020-06-27 02:15 新增 **provider** 的使用案例
- 2020-06-26 23:56 调整整体目录结构

### 相关

如想了解更多关于 **Flutter** 信息，请关注我的博客文章

| 序号  |                              文章                               |
|:----:|:--------------------------------------------------------------  |
|   1  | [Flutter 初识](https://h.lishaoy.net/beautifulFlutter.html)      |
|   2  | [Flutter 环境搭建](https://h.lishaoy.net/flutterInstall.html)     |
|   3  | [Flutter 初体验（实战）](https://h.lishaoy.net/fristFlutter.html) |
|   4  | [Flutter 10天高仿大厂App及小技巧积累总结（实战）](https://h.lishaoy.net/flutterctrip) |
|   5  | [Flutter Android 混合开发高仿大厂App（实战）](https://h.lishaoy.net/androidctrip) |
|   6  | [Flutter FutureBuilder and StreamBuilder 优雅的构建高质量项目](https://h.lishaoy.net/futruebuilder-streambuilder) |
|   7  | [Flutter (Flare) 最有趣用户交互动画没有之一](https://h.lishaoy.net/flutter-flare) |
|   7  | [Flutter 使用 Riverpod+Retrofit 构建MVVM开发模式](https://h.lishaoy.net/fluttermvvm) |
