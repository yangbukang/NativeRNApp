//
//  MainTabBarController.m
//  MiAiApp
//
//  Created by Mxy on 2017/5/18.
//  Copyright © 2017年 Mxy. All rights reserved.
//

#import "MainTabBarController.h"

//#import "RootNavigationController.h"
//#import "DKBorrowMoneyViewController.h"
//#import "DKPayBackMoneyViewController.h"
//#import "MineViewController.h"
//#import "DKMoreViewController.h"
#import "ViewController.h"
#import "ReactViewController.h"
#import "TabBarItem.h"

@interface MainTabBarController ()<TabBarDelegate>

@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC
//记录上次选择的tabbar
@property (nonatomic,assign) NSUInteger lastIndex;
@end

@implementation MainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpAllChildViewController];

}
-(void)selectorOlderVC{
    [self setSelectedIndex:self.lastIndex];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self removeOriginControls];
}

#pragma mark ————— 初始化TabBar —————
-(void)setUpTabBar{
    [self.tabBar addSubview:({
        
        TabBar *tabBar = [[TabBar alloc] init];
        tabBar.frame     = self.tabBar.bounds;
        tabBar.delegate  = self;
        
        self.TabBar = tabBar;
    })];
    
}
#pragma mark - ——————— 初始化VC ————————
-(void)setUpAllChildViewController{
    _VCS = @[].mutableCopy;

    ReactViewController *borrowVC = [[ReactViewController alloc]init];
    [self setupChildViewController:borrowVC title:@"首页" navTitle:@"首页" imageName:@"icon_tabbar_homepage" seleceImageName:@"icon_tabbar_homepage_selected"];
    
    
    ReactViewController *recommendVC = [[ReactViewController alloc]init];
    recommendVC.urlString = @"recommend";
    [self setupChildViewController:recommendVC title:@"推荐" navTitle:@"推荐" imageName:@"icon_tabbar_more" seleceImageName:@"icon_tabbar_more_selected"];
    
    ViewController *mineVC = [[ViewController alloc]init];
    [self setupChildViewController:mineVC title:@"我的" navTitle:@"我的" imageName:@"icon_tabbar_mine" seleceImageName:@"icon_tabbar_mine_selected"];
    
    self.viewControllers = _VCS;
}
#define SafeStr(__POINTER) if (__POINTER == nil || [__POINTER isEqualToString:@"(null)"]){__POINTER = @"";}
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title navTitle:(NSString *)navTitle imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];

    //包装导航控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
    SafeStr(navTitle);
    controller.navigationItem.title = navTitle;
    [_VCS addObject:nav];
    
}

#pragma mark ————— 统一设置tabBarItem属性并添加到TabBar —————
- (void)setViewControllers:(NSArray *)viewControllers {
    
    self.TabBar.badgeTitleFont         = SYSTEMFONT(11.0f);
    self.TabBar.itemTitleFont          = SYSTEMFONT(10.0f);
    self.TabBar.itemImageRatio         = self.itemImageRatio == 0 ? 0.7 : self.itemImageRatio;
    self.TabBar.itemTitleColor         = [UIColor blackColor];
    self.TabBar.selectedItemTitleColor = [UIColor blueColor];//[UIColor colorWithHexString:@"008BD3"];
    
    self.TabBar.tabBarItemCount = viewControllers.count;
    
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIViewController *VC = (UIViewController *)obj;
        
        UIImage *selectedImage = VC.tabBarItem.selectedImage;
        VC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self addChildViewController:VC];
        
        [self.TabBar addTabBarItem:VC.tabBarItem];
    }];
}

#pragma mark ————— 选中某个tab —————
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    [super setSelectedIndex:selectedIndex];
    self.TabBar.selectedItem.selected = NO;
    self.TabBar.selectedItem = self.TabBar.tabBarItems[selectedIndex];
    self.TabBar.selectedItem.selected = YES;
}

#pragma mark ————— 取出系统自带的tabbar并把里面的按钮删除掉 —————
- (void)removeOriginControls {
    
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
        
        if ([obj isKindOfClass:[UIControl class]]) {
            
            [obj removeFromSuperview];
        }
    }];
}


#pragma mark - TabBarDelegate Method

- (void)tabBar:(TabBar *)tabBarView didSelectedItemFrom:(NSInteger)from to:(NSInteger)to {
     self.selectedIndex = to;
}
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{

}

@end
