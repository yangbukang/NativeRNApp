//
//  RNMethodTool.m
//  NativeRNApp
//
//  Created by Feifei on 2018/11/21.
//  Copyright © 2018年 稀饭. All rights reserved.
//

#import "RNMethodTool.h"

#import "RNMethodTool.h"
#import "AppDelegate.h"
#import "ReactViewController.h"
#import "UIApplication+Visible.h"
@implementation RNMethodTool

//SINGLETON_FOR_CLASS(RNMethodTool);

RCT_EXPORT_MODULE()
//这个方法也是必须实现的
-(NSArray<NSString *>*)supportedEvents
{

    //EventReminder 是监听的标识，类似 iOS 发通知 需要一个标识去识别，通过这个标识发送通知调用 RN方法
    return @[@"EventReminder",@"Event2Reminder"];
    
}

// RCT_EXPORT_METHOD( xxx) 暴露给 RN 调用的方法写这里面， xxx 是调用方法
RCT_EXPORT_METHOD(rn_doSometing)
{
    //里面就是做一些原生操作了，比如跳转，打开相册，相机之类
    [self sendEventWithName:@"EventReminder" body:@{@"name":@"原生方法产生的数据返回RN"}];

}

RCT_EXPORT_METHOD(pushViewWitnTitle:(NSString *)string url:(NSString *)url)
{
    //这也是暴露给 RN 的方法，弹出系统框，string 是 RN给过来的参数
    dispatch_async(dispatch_get_main_queue(), ^{
        
        ReactViewController *viewController = [[ReactViewController alloc] init];
        viewController.urlString = url;
        viewController.title = string;
        viewController.hidesBottomBarWhenPushed = YES;
        [[[UIApplication sharedApplication] visibleViewController].navigationController pushViewController:viewController animated:YES];
    });
    
}


-(void)handleNotification:(NSNotification *)noti
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //这是核心方法, EventReminder 是标识，在上面的数组 supportedEvents 方法里也要加入， body 是 传给 RN 的参数
        [self sendEventWithName:@"Event2Reminder" body:noti.userInfo ? noti.userInfo :@{}];
        
    });
     //[self sendEventWithName:@"Event2Reminder" body:noti.userInfo ? noti.userInfo :@{}];
    
}

//这个就是暴露给其他原生类的方法了
+(void)emitMethod
{
    //这里是加个通知，其他原生类里通过发送通知来调用 alertRNInfo 方法,就是实现发通知给 RN 的功能方法
//    RNMethodTool *rt = [RNMethodTool new];
//    [rt sendEventWithName:@"Event2Reminder" body:@{@"name":@"Event2"}];
    //[[NSNotificationCenter defaultCenter]addObserver:rt selector:@selector(handleNotification:) name:@"RNNotificationName" object:nil];
}

//我这里在 `AppDelegate.m`类调用来测试是否可以成功调用
/*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 
 [RNMethodTool emitMethod];
 
 });
 */

@end
