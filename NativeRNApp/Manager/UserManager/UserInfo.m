//
//  UserInfo.m
//  MiAiApp
//
//  Created by Mxy on 2017/5/23.
//  Copyright © 2017年 Mxy. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    self.status = [NSString stringWithFormat:@"%@",[keyedValues valueForKey:@"status"]];
    self.mobilephone = [NSString stringWithFormat:@"%@",[keyedValues valueForKey:@"mobilephone"]];
    self.bank = [NSString stringWithFormat:@"%@",[keyedValues valueForKey:@"bank"]];
    self.login_token = [NSString stringWithFormat:@"%@",[keyedValues valueForKey:@"login_token"]];
    self.bank_account_tail = [NSString stringWithFormat:@"%@",[keyedValues valueForKey:@"bank_account_tail"]];
    self.name = [NSString stringWithFormat:@"%@",[keyedValues valueForKey:@"name"]];
    self.id_code = [NSString stringWithFormat:@"%@",[keyedValues valueForKey:@"id_code"]];
    self.user_id = [NSString stringWithFormat:@"%@",[keyedValues valueForKey:@"user_id"]];
    self.register_time = [NSString stringWithFormat:@"%@",[keyedValues valueForKey:@"register_time"]];
    NSString *bank_status = [NSString stringWithFormat:@"%@",[keyedValues valueForKey:@"register_time"]];
    SafeStr(bank_status);
    self.bank_status = bank_status;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

//- (BOOL)isGesturePasswordSet{
//    BOOL isSet = NO;
//    
//    NSString * password = [LLLockPassword loadLockPassword];
//    
//    if([password isKindOfClass:[NSString class]])
//    {
//        if (password.length>0) {
//            return YES;
//        }
//    }
//    return isSet;
//}
//
//- (BOOL)isTouchIDSet{
//    BOOL isSet = NO;
//    
//    isSet = [[[NSUserDefaults standardUserDefaults] valueForKey:@"touchIDOn"] boolValue];
//    return isSet;
//}
//
//- (void)setTouchIDSet:(BOOL)touchIDSet{
//    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:touchIDSet] forKey:@"touchIDOn"];
//}

@end
