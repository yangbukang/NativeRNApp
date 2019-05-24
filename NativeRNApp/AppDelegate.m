//
//  AppDelegate.m
//  NativeRNApp
//
//  Created by 朱源浩 on 16/8/13.
//  Copyright © 2016年 稀饭. All rights reserved.
//

#import "AppDelegate.h"
#import "RNMethodTool.h"
#ifndef __OPTIMIZE__
//#define NSLog(...) NSLog(__VA_ARGS__)
#define NSLog(...) printf("%s\n\n" , [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define NSLog(...){}
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initWindow];

    return YES;
}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    //    [[UIButton appearance] setShowsTouchWhenHighlighted:YES];
    //[UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = KWhiteColor;
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    if (!self.mainTabBar || ![self.window.rootViewController isKindOfClass:[MainTabBarController class]]) {
        self.mainTabBar = [MainTabBarController new];
        
        CATransition *anima = [CATransition animation];
        anima.type = @"cube";//设置动画的类型
        anima.subtype = kCATransitionFromRight; //设置动画的方向
        anima.duration = 0.3f;
        
        self.window.rootViewController = self.mainTabBar;
        
        [self.window.layer addAnimation:anima forKey:@"revealAnimation"];

    }
    NSLog(@"initWindow");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [RNMethodTool emitMethod];
//        
//    });
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
