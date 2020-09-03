//
//  BaseTabBarController.h
//  MVPFramework
//
//  Created by 李超峰 on 2020/5/22.
//  Copyright © 2020 李超峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController

#pragma 设置小红点数值
- (void)setBadgeValue:(NSString *)badgeValue index:(NSInteger)index;//设置指定tabar 小红点的值
#pragma 设置小红点显示或者隐藏
- (void)showBadgeWithIndex:(int)index;//显示小红点 没有数值
- (void)hideBadgeWithIndex:(int)index;//隐藏小红点 没有数值
@end
