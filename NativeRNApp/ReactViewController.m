//
//  ReactViewController.m
//  NativeRNApp
//
//  Created by mxy on 16/8/13.
//

#import "ReactViewController.h"
#import <React/RCTRootView.h>

#define kHostName  @"http://localhost:8081/"
/**
 @"http://10.100.1.36:8081/"
 **/
//LoadType 1为加载在线资源包 2为加载本地资源包
#define kLoadType 2
@interface ReactViewController ()

@end

@implementation ReactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_urlString) {
         _urlString = @"index.ios";
    }
    NSString * strUrl;
    if (kLoadType == 1) {
        strUrl = [NSString stringWithFormat:@"%@%@.bundle?platform=ios&dev=true",kHostName,_urlString];
    }else{
        NSString *bundleName = [NSString stringWithFormat:@"%@.jsbundle",_urlString];
        strUrl = [[NSBundle mainBundle] pathForResource:bundleName ofType:nil];
    }
    NSURL * jsCodeLocation = [NSURL URLWithString:strUrl];

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
