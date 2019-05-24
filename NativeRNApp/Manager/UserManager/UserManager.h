//
//  UserManager.h
//  MiAiApp
//
//  Created by Mxy on 2017/5/22.
//  Copyright © 2017年 Mxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
typedef void (^loginBlock)(BOOL success, NSString * des);

#define isLogin [UserManager sharedUserManager].isLogined
#define curUser [UserManager sharedUserManager].curUserInfo
#define userManager [UserManager sharedUserManager]
/**
 包含用户相关服务
 */
@interface UserManager : NSObject
//单例
SINGLETON_FOR_HEADER(UserManager)

//当前用户
@property (nonatomic, strong) UserInfo *curUserInfo;
@property (nonatomic, assign) BOOL isLogined;
@property (nonatomic,copy) NSDictionary *updateInfoDict;

@property(nonatomic,assign,getter=isGesturePasswordSet,readonly)BOOL gesturePasswordSet;
@property(nonatomic,assign,getter=isTouchIDSet)BOOL touchIDSet;

#pragma mark - ——————— 登录相关 ————————

/**
 带参登录
 @param params 参数，手机和账号登录需要
 @param completion 回调
 */
-(void)loginWithParams:(NSDictionary *)params completion:(loginBlock)completion;

/**
 自动登录

 @param completion 回调
 */
-(void)autoLoginToServer:(loginBlock)completion;

/**
 退出登录

 @param completion 回调
 */
- (void)logout:(loginBlock)completion;

/**
 强制退出登录

 */
- (void)forceLogout;

/**
 加载缓存用户数据

 @return 是否成功
 */
-(BOOL)loadUserInfo;

/**
 保存用户信息
 */
-(void)saveUserInfo;

@end
