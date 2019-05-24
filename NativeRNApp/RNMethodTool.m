//
//  RNMethodTool.m
//  NativeRNApp
//
//  Created by mxy on 2018/11/21.
//

#import "RNMethodTool.h"

#import "RNMethodTool.h"
#import "AppDelegate.h"
#import "ReactViewController.h"
#import "UIApplication+Visible.h"
@implementation RNMethodTool

//SINGLETON_FOR_CLASS(RNMethodTool);
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotification:) name:@"RNNotificationName" object:nil];
    }
    return self;
}
+ (BOOL)requiresMainQueueSetup

{
    
    return YES;
    
}
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
}

//这个就是暴露给其他原生类的方法了
+(void)emitMethod
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RNNotificationName" object:nil userInfo:@{@"name":@"Notify"}];

}


@end
