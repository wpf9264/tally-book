//
//  AppDelegate.m
//  TallyBook
//
//  Created by 三木 on 2021/8/1.
//

#import "AppDelegate.h"
#import "TBFunctionRootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

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
    // Override point for customization after application launch.
    self.mainWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    TBFunctionRootViewController *rootVC = [[TBFunctionRootViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.mainWindow.rootViewController = navi;
    [self.mainWindow makeKeyAndVisible];
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

#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
