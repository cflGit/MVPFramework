//
//  HomeController.m
//  MVPFramework
//
//  Created by 李超峰 on 2020/5/26.
//  Copyright © 2020 李超峰. All rights reserved.
//

#import "HomeController.h"
#import "HomePresenter.h"

@interface HomeController ()<HomePresenterProtocol>

@property (nonatomic,strong)HomePresenter *homePresenter;

@end

@implementation HomeController

#pragma mark - ♻️life cycle // 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
}
- (void)setupData{
    [self.homePresenter getMovieListWithUrlString:@"satinApi" param:@{@"type":@"1",
                                                                      @"page":@"1"}];
}

#pragma mark - 🍐delegate // 代理

#pragma mark - 🎬event response // 事件触发方法

#pragma mark - 🔒private // 私有方法
- (void)onGetDataSourceSuccess:(id)model{
    //同一个presenter如果存在多个回调，可以通过Model的类型来判断回调
//    if ([model isKindOfClass:[HomeModel class]]) {
//        [self.homeMainView configViewWithHomeModel:model];
//    }else if([model isKindOfClass:[HomeBannerModel class]]){
//
//    }
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"result" message:@"request success" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alertCtl animated:YES completion:nil];
}

- (void)onGetDataSourceFail:(NSInteger)errorCode des:(NSString *)des{
//    [self.homeMainView showErrorView];
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"result" message:@"request fail" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alertCtl animated:YES completion:nil];
}

#pragma mark - 🚪public // 公有方法

#pragma mark - 😴lazy load //懒加载
- (HomePresenter *)homePresenter{
    if (!_homePresenter) {
        _homePresenter = [[HomePresenter alloc] initWithView:self];
    }
    return _homePresenter;
}


@end
