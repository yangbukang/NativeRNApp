//
//  UserInfo.h
//  MiAiApp
//
//  Created by Mxy on 2017/5/23.
//  Copyright © 2017年 Mxy. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserInfo : NSObject

@property (nonatomic,copy) NSString * status;//用户状态
@property (nonatomic,copy) NSString * mobilephone;//手机号
@property (nonatomic,copy) NSString * bank;//银行卡名字
@property (nonatomic,copy) NSString * login_token;//登录token
@property (nonatomic,copy) NSString * bank_account_tail;//银行卡后四位
@property (nonatomic,copy) NSString * name;//用户名
@property (nonatomic,copy) NSString * id_code;//身份证号
@property (nonatomic,copy) NSString * user_id;//用户id
@property (nonatomic,copy) NSString * register_time;//注册时间
@property (nonatomic,copy) NSString * bank_status;//银行卡绑定状态
@property (nonatomic,assign) NSInteger bank_count;

//@property(nonatomic,assign,getter=isGesturePasswordSet,readonly)BOOL gesturePasswordSet;
//@property(nonatomic,assign,getter=isTouchIDSet)BOOL touchIDSet;

@end
