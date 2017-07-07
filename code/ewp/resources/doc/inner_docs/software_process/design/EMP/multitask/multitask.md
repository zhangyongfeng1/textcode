# 多任务设计
------- | --------- | ----- | --------------
V1.0    | 2015.8.27 | 周长晋 | 初稿
- 根任务模块：指当前应用程序的任务模块，该任务在整个程序中有且仅有一个，关闭则程序退出。
- 子任务模块：可随时打开关闭的业务模块，嵌套与根任务中，由根任务创建，可存在多个。

- 根任务可以通过添加标签打开一个新的子任务，或者删除标签关闭（结束）该子任务；
- 根任务模块可通过标签页看到当前已打开的多个任务，并可以通过点击标签页切换子任务的显示；
- 子任务支持emp和h5两种任务类型；
- 各个子任务彼此独立，无数据共享，无操作交互。子任务与根任务间也无数据共享，无操作交互；
- 各任务只通过全局样式库共享样式，一些可以被继承的样式无需从根任务模块传递给子任务模块；
- 需后台保存交易数据（跨会话存在）的“已暂存任务”功能，暂不考虑实现。
- `name`：控件的name
- `class`：控件应用的样式
- `hide`：显示/隐藏

##### 样式支持
- `left`、`right`、`top`、bottom：控件的位置
- `background-color`、`background-image`、`filter`：背景色、背景图和渐变色
- `display`、`visbility`：显示/隐藏
- 涉及公共操作的接口无需特殊处理，包括`accelerometer`、`audio`、`corp`、`database`、`file`、`gesture`、`gps`、`http`、`json`、`kv`、`offline`、`qrcode`、`screen`、`system`、`timer`、`utility`、`video`、`window`及control剩余接口；

#### 子任务页面显示

子任务控件内的页面显示内容，可通过调用`setInnerHTML`接口局部刷新的方式显示。

	local subTask1 = document:getElementbyId("task1");
	subTask1：setInnerHTML(<content>...</content>);

为保证通用性，子任务控件支持接收现在规范的页面报文结构，但由于子任务的特殊性，需要对body控件的实现做修改。之前的body控件，强制是铺满整个屏幕的，因此对`width`、`height`、`left`、`right`、`top`、`bottom`样式都是不支持的，而子任务控件里的body需要对这些样式增加支持，因此我们需要在解析body的时候增加判断，看当前body属于父任务dom树还是子任务dom树，以此来决定是否应用这些样式。

产品目前没有控件reload的接口，要实现子任务控件的reload，需要扩展新的lua接口。

### h5类型子任务