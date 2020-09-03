//
//  BaseTabBarController.m
//  MVPFramework
//
//  Created by 李超峰 on 2020/5/22.
//  Copyright © 2020 李超峰. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseTableViewController.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

#pragma mark - ♻️life cycle // 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSVProgressHUD];
    [self removeTabarTopLine];
    [self setViewControllers];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [UITabBar appearance].tintColor = [UIColor redColor];
}

- (void)setSVProgressHUD {
    //SVProgressHUDMaskType 设置显示的样式
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom]; //样式使用自定义
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];// 整个后面的背景选择
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];// 弹出框颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];// 弹出框内容颜色
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
}

- (void)setViewControllers {
    //UITabBarController 数据源
    NSMutableDictionary *homeDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"HomeController",@"class",@"首页",@"title",@"shouyeweidianji",@"image",@"shouyedianji",@"selectedImage",@"badgeValue",@"0", nil];
    NSMutableDictionary *mineDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MineController",@"class",@"首页",@"title",@"wodeweidianji",@"image",@"wodedianji",@"selectedImage",@"badgeValue",@"0", nil];
    NSArray *dataAry = @[homeDic,mineDic];
    for (NSDictionary *dataDic in dataAry) {
        //每个tabar的数据
        Class classs = NSClassFromString(dataDic[@"class"]);
        NSString *title =dataDic[@"title"];
        NSString *imageName = dataDic[@"image"];
        NSString *selectedImage = dataDic[@"selectedImage"];
        NSString *badgeValue = dataDic[@"badgeValue"];
        [self addChildViewController:[self ittemChildViewController:classs title:title imageName:imageName selectedImage:selectedImage badgeValue:badgeValue]];
    }
}

- (BaseNavigationController *)ittemChildViewController:(Class)classs title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage badgeValue:(NSString *)badgeValue {
    UIViewController *vc = [classs new];
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.title = title;
    //小红点
    vc.tabBarItem.badgeValue = badgeValue.intValue > 0 ? badgeValue : nil;
    //导航
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [nav.rootVcAry addObject:classs];
    return nav;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([item.title isEqualToString:@"首页"]) {
        //底部导航首页
    }
}

#pragma mark - 🚪public // 公有方法
//设置指定tabar 小红点的值
- (void)setBadgeValue:(NSString *)badgeValue index:(NSInteger)index {
    if (index + 1 > self.viewControllers.count || index < 0) {
        //越界或者数据异常直接返回
        return;
    }
    BaseNavigationController *base = self.viewControllers[index];
    if (base.viewControllers.count == 0) {
        return;
    }
    UIViewController *vc = base.viewControllers[0];
    vc.tabBarItem.badgeValue = badgeValue.intValue > 0 ? badgeValue : nil;
}

//显示小红点 没有数值
- (void)showBadgeWithIndex:(int)index {
    [self showBadgeOnItemIndex:index];
}
//隐藏小红点 没有数值
- (void)hideBadgeWithIndex:(int)index {
    [self hideBadgeOnItemIndex:index];
}

#pragma mark - 🔒private // 私有方法
//去掉tabBar顶部线条
- (void)removeTabarTopLine {
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance* tabbarAppearance = self.tabBar.standardAppearance;
        self.tabBar.standardAppearance = tabbarAppearance;
    } else {
        // Fallback on earlier versions
        self.tabBar.backgroundImage = [UIImage new];
        self.tabBar.shadowImage = [UIImage new];
    }
}
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.tabBar.frame;
    
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger tabbarItemNums = dele.baseTabBar.viewControllers.count;
    
    //确定小红点的位置
    float percentX = (index +0.6) / tabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    [self.tabBar addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.tabBar.subviews) {
        
        if (subView.tag == 888+index) {
            
            [subView removeFromSuperview];
            
        }
    }
}

@end
