//
//  BaseNavigationController.m
//  MVPFramework
//
//  Created by 李超峰 on 2020/5/22.
//  Copyright © 2020 李超峰. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)loadView {
    [super loadView];
    //去掉导航栏上的黑线
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // bg.png为自己ps出来的想要的背景颜色。
//    UIColor *topleftColor = [UIColor colorWithRed:60/255.0f green:182/255.0f blue:255/255.0f alpha:1.0f];
//    UIColor *bottomrightColor = [UIColor colorWithRed:51/255.0f green:121/255.0f blue:253/255.0f alpha:1.0f];
//    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor] size:CGSizeMake(self.navigationBar.frame.size.width, self.navigationBar.frame.size.height + 20)] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor] size:CGSizeMake(self.navigationBar.frame.size.width, self.navigationBar.frame.size.height + 20)]];
//    [self.navigationBar setShadowImage:[UIImage new]];
//    [self setStatusBarBackgroundColor:kUIToneBackgroundColor];
    //状态栏颜色
//    [[UIApplication sharedApplication] setStatusBarStyle:kStatusBarStyle];
    //title颜色和字体
//    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kUIToneTextColor,
//                                               NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
    if ([UIDevice currentDevice].systemVersion.floatValue > 7.0) {
        //导航背景颜色
        self.navigationBar.barTintColor = [UIColor whiteColor];
    }
    
    //系统返回按钮图片设置
    NSString *imageName = @"back_more";
//    if (kStatusBarStyle == UIStatusBarStyleLightContent) {
//        imageName = @"back_more";
//    }
    UIImage *image = [UIImage imageNamed:imageName];
    [[UINavigationBar appearance] setBackIndicatorImage:image];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width-1, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setTintColor:kUIToneTextColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0)
                                                         forBarMetrics:UIBarMetricsDefault];    
}
- (void)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
}

#pragma mark - 侧滑手势

- (void)addGestureRecognizer {
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    //获取系统手势的target数组
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    //获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
    id gestureRecognizerTarget = [_targets firstObject];
    //获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    //通过前面的打印，我们从控制台获取出来它的方法签名。
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    //创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:touch.view];
    
    CGFloat absX = fabs(touchLocation.x);
    CGFloat absY = fabs(touchLocation.y);
    
    // 设置滑动有效距离
    if (MAX(absX, absY) > 10)
        return NO;
    
    if (absX > absY ) {
        
        if (touchLocation.x<0) {
            
            //向左滑动
            return YES;
        }else{
            //向右滑动
            return NO;
        }
        
    } else if (absY > absX) {
        if (touchLocation.y<0) {
            
            //向上滑动
            return YES;
        }else{
            
            //向下滑动
            return YES;
        }
    }

    return  YES;
}

#pragma mark -  push 设置

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    for (Class classes in self.rootVcAry) {
        if ([viewController isKindOfClass:classes]) {
            if (self.navigationController.viewControllers.count > 0) {
                viewController.hidesBottomBarWhenPushed = YES;
            } else {
                viewController.hidesBottomBarWhenPushed = NO;
            }
        } else {
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark -  RootVc

- (NSMutableArray *)rootVcAry {
    if (!_rootVcAry) {
        _rootVcAry = [NSMutableArray new];
    }
    return _rootVcAry;
}

@end
