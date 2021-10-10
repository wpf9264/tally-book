# TallyBook

### 写在前面

刚学习iOS时想着做一个app，以巩固相关知识。但是一直没有付诸行动，现在接触iOS已经有一年半了，工作中对一些知识都是一知半解，为了弥补这些短板，开始从零到一实现一个自己感兴趣的软件。

###  工程设想

（这里主要补充相关知识点，各个部分均会给出具体的讲解）

- 启动画面
- nagivation bar
- KVO
- MVVM
- MVC
- schema
  - 端内
  - 端外
- JSB
  - h5
  - lynx
  - RN
- OperationQueue
- 数据存储：阅读现有的轮子
- cocopods
- podfile
- 横竖屏切换：
- 多 target
- Extension
- 网络请求：
- 日志系统
- 日历
- 运行时 hook





## 创建工程 

- 定位：一个记账软件
- Class Prefix：定为 TB
- Bundle Identify：sanmu.TallyBook

### 启动页面

这里显示有个 LaunchScreen.storyboard 文件。

Storyboard是Apple提供的一种简化的布局界面，通过xml描述界面，不能编程。虽然无法制作非常灵活的界面，但满足启动界面是没问题的，比如设定背景色背景图、设定前景文字、图片的位置。storyboard 的优势是启动速度快。在App的真实首页被渲染完成前，可以快速给用户提供一个基于Storyboard的启动屏。

苹果App Store审核要求应用在启动时，不能使用启动图片，必须改为使用Storyboard来制作启动界面。[应用程序更新的截止日期已延长 - 新闻 - 苹果开发人员 (apple.com)](https://developer.apple.com/news/?id=03262020b)

这里需要选择使用启动图

![image-20210802000418380](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20210802000418380.png)

这里添加一个UIView用来展示logo

![image-20210802001933701](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20210802001933701.png)

![image-20210802001319471](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20210802001319471.png)

另外添加一个UILabel，展示app名称，这里为label设置约束，和logo的相对距离设置为80.![image-20210802002716115](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20210802002716115.png)

此时设置完，运行后发现看不到启动图，是因为运行太快，需要设置延时。注意，这里sleep仅仅是为了测试。![image-20210802004319028](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20210802004319028.png)

再次运行后发现布局有问题，查看约束发现是仅限定了“长+宽+上”，少了水平方向的约束。同时选中view和image，点击对齐，选择垂直对齐就可。同理，image和label也需要设置。

***这里需要注意，苹果会自动缓存开屏图片，如果更换图片后会发现不生效，只需要重启一次即可。***

![image-20210802004145658](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20210802004145658.png)

### Logo

<a target="_blank" href="https://icons8.com/icon/IRqeJZEBgSb_/wallet">Wallet</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>

Asset里面是各种图片资源，这里有默认的AppIcon，可以看到Apple针对不同的设备要求提供不同大小的Icon，这里推荐一个免费的素材网站：https://icons8.com/。

直接将相应大小的icon拖入对应的位置即可，此时在桌面的icon，和xcode的icon均已经替换。注意：这里如果拖入尺寸错误的icon，会导致编译失败。可以看到我这里的icon是带有黑边的，这是因为我选择的png图片，且存在alpha通道，可以选择jpg的图片。

![image-20210801235444422](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20210801235444422.png)

### AppDelegate & SceneDelegate 联系

[(47条消息) iOS 13 SceneDelegate适配_仰望星空的博客-CSDN博客](https://blog.csdn.net/weixin_38735568/article/details/101266408?utm_medium=distribute.pc_relevant.none-task-blog-2~default~BlogCommendFromMachineLearnPai2~default-4.base&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2~default~BlogCommendFromMachineLearnPai2~default-4.base)

这里暂时先不关注SceneDelegate的作用，适配 iOS 13 以下的设备。



## 基础能力

### 日历

日历是一个基础能力，在各个地方都会用到，因此期望提供通用接口，支持选择日期，或者具体的时间点。

在这里发现一个问题





### 导航栏

这个是系统自带的导航栏，但是我期望支持全面，并且在顶部支持自定义的事件，因此隐藏导航栏。

需要了解导航栏的作用



### tab bar

底部提供能力：明细，图标，新增，社区，我的。



### slider bar

图标tab支持年月周维度



### top vc

需要在当前页面展示SDK页面。

这需要了解keywindow 和 多window的关系，如果没有window会怎样。



### push 与 present 的区别





### 宏定义

屏幕宽度

屏幕高度

顶部安全距离

底部安全距离

机型判断



### YYcache





### 布局约束







