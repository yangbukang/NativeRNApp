//
//  ShareManager.h
//  MiAiApp
//
//  Created by Mxy on 2017/6/1.
//  Copyright © 2017年 Mxy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 分享 相关服务
 */
@interface ShareManager : NSObject

//单例
SINGLETON_FOR_HEADER(ShareManager)

@property (strong, nonatomic) NSDictionary *shareDic;

/**
 展示分享页面
 */
-(void)showShareView;
- (void)showShareCustomView;
- (void)showShareCustomView:(BOOL)animated title:(NSString *) title;
- (void)queryInviteinfoRequest;
@end
