# TallyBook

### 写在前面

刚学习iOS时想着做一个app，以巩固相关知识。但是一直没有付诸行动，现在接触iOS已经有一年半了，工作中对一些知识都是一知半解，为了弥补这些短板，开始从零到一实现一个自己感兴趣的软件。

###  工程设想

（这里主要补充相关知识点，各个部分均会给出具体的讲解）

- 启动画面
- nagivation bar
- 数据存储：阅读现有的轮子
- cocopods
- 横竖屏切换：
- 多 target
- Extension
- 网络请求：





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

![image-20210802004145658](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20210802004145658.png)

### Logo

<a target="_blank" href="https://icons8.com/icon/IRqeJZEBgSb_/wallet">Wallet</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>

Asset里面是各种图片资源，这里有默认的AppIcon，可以看到Apple针对不同的设备要求提供不同大小的Icon，这里推荐一个免费的素材网站：https://icons8.com/。

直接将相应大小的icon拖入对应的位置即可，此时在桌面的icon，和xcode的icon均已经替换。注意：这里如果拖入尺寸错误的icon，会导致编译失败。可以看到我这里的icon是带有黑边的，这是因为我选择的png图片，且存在alpha通道，可以选择jpg的图片。

![image-20210801235444422](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20210801235444422.png)

