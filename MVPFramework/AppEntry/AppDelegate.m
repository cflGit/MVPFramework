//
//  AppDelegate.m
//  MVPFramework
//
//  Created by 李超峰 on 2020/5/22.
//  Copyright © 2020 李超峰. All rights reserved.
//

#import "AppDelegate.h"
#import "AvoidCrash.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - ♻️life cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    _baseTabBar = [BaseTabBarController new];
    self.window.rootViewController = _baseTabBar;
    [self.window makeKeyAndVisible];
    //启动防止崩溃功能
    [AvoidCrash makeAllEffective];
    return YES;
}

@end
