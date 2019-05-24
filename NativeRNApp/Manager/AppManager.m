//
//  AppManager.m
//  MiAiApp
//
//  Created by Mxy on 2017/5/21.
//  Copyright © 2017年 Mxy. All rights reserved.
//

#import "AppManager.h"
//#import "AdPageView.h"
//#import "RootWebViewController.h"
//#import "YYFPSLabel.h"
//#import "LocationInfo.h"
//#import "DeviceInfo.h"
//#import "FMDeviceManager.h"
#import "YRJSONAdapter.h"
@implementation AppManager


+(void)appStart{
    //加载广告
//    AdPageView *adView = [[AdPageView alloc] initWithFrame:kScreen_Bounds withTapBlock:^{
//        RootNavigationController *loginNavi =[[RootNavigationController alloc] initWithRootViewController:[[RootWebViewController alloc] initWithUrl:@"http://www.hao123.com"]];
//        [kRootViewController presentViewController:loginNavi animated:YES completion:nil];
//    }];
//    adView = adView;
}
#pragma mark ————— FPS 监测 —————
+(void)showFPS{
//    YYFPSLabel *_fpsLabel = [YYFPSLabel new];
//    [_fpsLabel sizeToFit];
//    _fpsLabel.bottom = KScreenHeight - 55;
//    _fpsLabel.right = KScreenWidth - 10;
//    //    _fpsLabel.alpha = 0;
//    [kAppWindow addSubview:_fpsLabel];
}
#pragma mark ————— 获取设备信息 —————
+(NSString *)getDeviceInfo{
    NSMutableDictionary *infoDict = [NSMutableDictionary new];
    NSString *machine_dactylogram = @"";
    NSString *app_version = kCurrentVersion;
    NSString *device_type = @"";
    [infoDict setObject:@"2" forKey:@"phone_type"];
    [infoDict setObject:machine_dactylogram forKey:@"machine_dactylogram"];
    [infoDict setObject:app_version forKey:@"app_version"];
    [infoDict setObject:device_type forKey:@"device_type"];
    [infoDict setObject:@"Apple" forKey:@"device_brand"];
//    NSDictionary *loactionInfo = [AppDelegate shareAppDelegate].locationInfo;
//    NSString *appip = [AppDelegate shareAppDelegate].appIp;
//    SafeStr(appip);
//    if (!ValidDict(loactionInfo)) {
//        [infoDict setObject:@"0.0" forKey:@"longitude"];
//        [infoDict setObject:@"0.0" forKey:@"latitude"];
//        [infoDict setObject:@"" forKey:@"country"];
//        [infoDict setObject:@"" forKey:@"province"];
//        [infoDict setObject:@"" forKey:@"city"];
//        [infoDict setObject:@"" forKey:@"address"];
//    }
//    if (!ValidStr(appip)) {
//        appip = [DeviceInfo getRealIPAddress];
//    }
//
//    NSString *tongDun = [AppDelegate shareAppDelegate].tongDunDeviceInfo;
//    if (!ValidStr(tongDun)) {
//        tongDun = @"";
//    }
//    [infoDict setObject:tongDun forKey:@"td_blackbox"];
//    [infoDict setObject:appip forKey:@"ip"];
//    [infoDict setValuesForKeysWithDictionary:loactionInfo];
    
    NSString *jsonString = [infoDict JSONString];//[infoDict modelToJSONString];
    return jsonString;
}
@end
