# 应用生命周期

参考：

- [iOS应用程序的生命周期 - 简书 (jianshu.com)](https://www.jianshu.com/p/aa50e5350852)





## 应用状态

- Not running：app还没运行

- Inactive：app运行在foreground但没有接收事件

- Active：app运行在foreground和正在接收事件

- Background：运行在background和正在执行代码

- Suspended：运行在background但没有执行代码

  <img src="/Users/wangpengfei/Library/Application Support/typora-user-images/image-20211010223904233.png" alt="image-20211010223904233" style="zoom:50%;" align = "left"/>

## AppDelegate

### 定义

- AppDelegate 是应用程序的委托对象，其继承自 UIResponder 类，并遵守 UIApplicationDelegate 委托协议。
- UIResponder 类可以使子类AppDelegate 具有处理响应事件的能力，而 UIApplicationDelegate 委托协议使 AppDelegate 能够成为应用程序委托对象，这种对象能够响应应用程序的生命周期。
- 继承的一系列方法在应用生命周期的不同阶段会被回调，定义如下：

```objective-c
// 启动时的第一次机会来执行代码
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions
{
    NSLog(@"current method:%@.", NSStringFromSelector(_cmd));
    return YES;
}

// 应用启动并进行初始化时会调用该方法并发出通知 UIApplicationDidFinishLaunchingNotification。这个阶段会实例化根视图控制器
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"current method:%@.", NSStringFromSelector(_cmd));
    return YES;
}

// 应用进人前台并处于活动状态时调用该方法井发出通知 UIApplicationDidBecomeActiveNotification 这个阶段可以恢复UI的状态（例如游戏状态等）
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"current method:%@.", NSStringFromSelector(_cmd));
}

// 应用从活动状态进人到非活动状态时调用该方法并发出通知 UIApplicationWillResignActiveNotification。这个阶段可以保存U的状态（例如游戏状态等）
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"current method:%@.", NSStringFromSelector(_cmd));
}

//应用进人后台时调用该方法并发出通知。这个阶段可以保存用户数据，释放一些资源（例如释放数据库资源等）
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"current method:%@.", NSStringFromSelector(_cmd));
}

// 应用进人到前台，但是还没有处于活动状态时调用该方法井发出通知 UIApplicationWillEnterForegroundNotification。这个阶段可以恢复用户数据
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"current method:%@.", NSStringFromSelector(_cmd));
}

// 应用被终止时调用该方法井发出通知 UIApplicationWillTerminateNotification，但内存清除时除外。这个阶段释放一些资源，也可以保存用户数据
- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"current method:%@.", NSStringFromSelector(_cmd));
}
iOS应用的状态：
```

### 验证

#### 未启动 -> 启动

- 应用未启动时，首次点击，其状态变化为：Not running -> Inactive -> Active![截屏2021-10-10 下午10.18.39](/Users/wangpengfei/Desktop/截屏2021-10-10 下午10.18.39.png)

#### 活动 -> 退后台

- 点击home键，应用回到后台（可在后台运行），其状态变化为：Active -> Inactive -> Background -> Suspened![image-20211010222836273](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20211010222836273.png)

- 如果修改 info.plist 中该选项，则表示应用不可在后台运行，退后台后应用会直接被杀死，状态变化为：Active -> Inactive -> Background -> Suspened -> Not Running，可以看到在应用挂起后直接被终止。![image-20211010222316342](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20211010222316342.png)

  ![image-20211010222051539](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20211010222051539.png)

#### 后台 -> 回前台

- 点击应用，回到前台，其状态变化为：Suspended ->Background -> Inactive ->  Active![image-20211010223033593](/Users/wangpengfei/Library/Application Support/typora-user-images/image-20211010223033593.png)

## SceneDelegate

- 在iOS13 中引入了 SceneDelegate ，