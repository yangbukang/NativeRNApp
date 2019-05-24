//
//  UIApplication+Visible.h
//  WorkFrame
//
//  Created by Jingyuzhao on 2017/3/2.
//  Copyright © 2017年 tiannu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Visible)

/**
 获得当前app主窗口的ViewController

 @return 主窗口ViewController
 */
- (UIViewController *)visibleViewController;
/**
 获得当前app主窗口ViewController所在的导航
 
 @return 主窗口ViewController所在导航
 */
- (UINavigationController *)visibleNavigationController;

/**
 调用：
 UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
 [nav pushViewController:newVC animated:YES];
 */
@end
