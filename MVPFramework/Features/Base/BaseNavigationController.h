//
//  BaseNavigationController.h
//  MVPFramework
//
//  Created by 李超峰 on 2020/5/22.
//  Copyright © 2020 李超峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

@property (nonatomic,strong) NSMutableArray *rootVcAry;

- (void)setStatusBarBackgroundColor:(UIColor *)color;

@end
