//
//  AppDelegate.m
//  干部在线
//
//  Created by lixianjun on 14-12-29.
//  Copyright (c) 2014年 中青年. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LTPlayerSDK.h"
@interface AppDelegate ()
{
    RootViewController *_root;
    MainViewController * _main;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    _main = [[MainViewController alloc] init];
    _root = [[RootViewController alloc] init];
    
    
    _sideViewController = [[YRSideViewController alloc] init];
    _sideViewController.leftViewController = _root;
    _sideViewController.rootViewController = _main;
    
    _sideViewController.leftViewShowWidth = 230;
    _sideViewController.needSwipeShowMenu = true;
    
//    _mainVC =  [[mainTabBarViewController alloc] init];
    self.window.rootViewController = _sideViewController;
    
    //视频多线程的启动
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 启动PlayerService
        [LTPlayerSDK startPlayerService];
    });
    [LTPlayerSDK getPlayerView];
    sleep(1);
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if( self.ori_flag == 1){
        return UIInterfaceOrientationMaskAll;
    }
    else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
