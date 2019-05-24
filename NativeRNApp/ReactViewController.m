//
//  ReactViewController.m
//  NativeRNApp
//
//  Created by 朱源浩 on 16/8/13.
//  Copyright © 2016年 稀饭. All rights reserved.
//

#import "ReactViewController.h"
#import <React/RCTRootView.h>

#define kHostName  @"http://localhost:8081/"
/**
 @"http://localhost:8081/"
 @"http://10.100.1.36:8081/"
 @"http://10.100.1.22:8081/"
 **/
@interface ReactViewController ()

@end

@implementation ReactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_urlString) {
         _urlString = @"index.ios";
    }
    
    NSString * strUrl = [NSString stringWithFormat:@"%@%@.bundle?platform=ios&dev=true",kHostName,_urlString];
//    NSString *bundleName = [NSString stringWithFormat:@"%@.jsbundle",_urlString];
//    NSString * strUrl = [[NSBundle mainBundle] pathForResource:bundleName ofType:nil];
    NSURL * jsCodeLocation = [NSURL URLWithString:strUrl];
    // jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];


    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                         moduleName:@"NativeRNApp"
                                                  initialProperties:nil
                                                      launchOptions:nil];
    rootView.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64);
    [self.view addSubview:rootView];
    //self.view = rootView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    NSLog(@"dealloc");
}
@end
