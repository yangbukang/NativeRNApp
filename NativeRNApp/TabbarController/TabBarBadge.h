//
//  TabBarBadge.h
//  MiAiApp
//
//  Created by Mxy on 2017/5/24.
//  Copyright © 2017年 Mxy. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 tabbar 红点
 */
@interface TabBarBadge : UIButton

/**
 *  TabBar item badge value
 */
@property (nonatomic, copy) NSString *badgeValue;

/**
 *  TabBar's item count
 */
@property (nonatomic, assign) NSInteger tabBarItemCount;

/**
 *  TabBar item's badge title font
 */
@property (nonatomic, strong) UIFont *badgeTitleFont;

@end
