//
//  UserManager.m
//  MiAiApp
//
//  Created by Mxy on 2017/5/22.
//  Copyright © 2017年 Mxy. All rights reserved.
//

#import "UserManager.h"
//#import <UMSocialCore/UMSocialCore.h>
#import "LoginLogic.h"
#import "LLLockPassword.h"

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager);

- (instancetype)init{
    self = [super init];
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick)
                                                     name:KNotificationOnKick
                                                   object:nil];
    }
    return self;
}
#pragma mark ————— 带参数登录 —————
-(void)loginWithParams:(NSDictionary *)params completion:(loginBlock)completion{
   
    [PPNetworkHelper POST:@"member/login" parameters:params showProgress:YES success:^(NSDictionary *dicInfo, BOOL isSuccess, NSString *errorMessage) {
        if (isSuccess) {
            UserInfo *info = [[UserInfo alloc]init];
            [info setValuesForKeysWithDictionary:dicInfo];
            [UserManager sharedUserManager].curUserInfo = info;
            self.isLogined = YES;
            [self saveUserInfo];
            completion(YES,errorMessage);
        } else {
            completion(NO,errorMessage);
        }
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error.description);
    }];
}
-(void)autoLoginToServer:(loginBlock)completion{
    
}
#pragma mark ————— 储存用户信息 —————
-(void)saveUserInfo{
    if (self.curUserInfo) {
        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
        NSDictionary *dic = [self.curUserInfo modelToJSONObject];
        [cache setObject:dic forKey:KUserModelCache];
    }
    
}
#pragma mark ————— 加载缓存的用户信息 —————
-(BOOL)loadUserInfo{
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        self.curUserInfo = [UserInfo modelWithJSON:userDic];
        return YES;
    }
    return NO;
}
#pragma mark ————— 被踢下线 —————
- (void)onKick{
    [self logout:nil];
}
#pragma mark ————— 退出登录 —————
- (void)logout:(void (^)(BOOL, NSString *))completion{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogout object:nil];//被踢下线通知用户退出直播间
    self.curUserInfo = nil;
    self.isLogined = NO;

    //移除缓存
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    YYCache *userInfo = [[YYCache alloc]initWithName:KUserInfoStateCache];
    [userInfo removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    
    //移除银行卡相关缓存信息
    YYCache *bankStateCache = [[YYCache alloc]initWithName:kBankInfoState];
    [bankStateCache removeObjectForKey:kBankInfoState];
    
    YYCache *bankCache = [[YYCache alloc]initWithName:kBankInfoCache];
    [bankCache removeObjectForKey:kBankInfoCache];
    //移除指纹设置
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"touchIDOn"];
    //移除手势设置
    [LLLockPassword saveLockPassword:nil];
    
    
    KPostNotification(KNotificationLoginStateChange, @NO);
}
#pragma mark ————— 强制退出登录 —————
- (void)forceLogout{
    [self logout:nil];
    KPostNotification(KNotificationLogout, nil);
    [[[UIApplication sharedApplication] visibleViewController].navigationController popToRootViewControllerAnimated:NO];
    [LoginLogic showLoginViewController];
    [kAppWindow makeToast:@"请重新登录"];

    
}

- (BOOL)isGesturePasswordSet{
    BOOL isSet = NO;
    
    NSString * password = [LLLockPassword loadLockPassword];
    
    if([password isKindOfClass:[NSString class]])
    {
        if (password.length>0) {
            return YES;
        }
    }
    return isSet;
}

- (BOOL)isTouchIDSet{
    BOOL isSet = NO;
    
    isSet = [[[NSUserDefaults standardUserDefaults] valueForKey:@"touchIDOn"] boolValue];
    return isSet;
}

- (void)setTouchIDSet:(BOOL)touchIDSet{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:touchIDSet] forKey:@"touchIDOn"];
}

@end
