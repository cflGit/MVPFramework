//
//  HomePresenter.m
//  MVPFramework
//
//  Created by 李超峰 on 2020/9/2.
//  Copyright © 2020 李超峰. All rights reserved.
//

#import "HomePresenter.h"

@implementation HomePresenter

- (void)getMovieListWithUrlString:(NSString *)urlString param:(NSDictionary *)param{
    [self.httpClient get:urlString parameters:param];
}

#pragma mark - HttpResponseHandle

- (void)onSuccess:(id )responseObject{
    HKHttpResponse * responseObj = (HKHttpResponse *)responseObject;
    if ([responseObj.request.URL.absoluteString hasSuffix:@"satinApi"]) {
        HomeModel *model = [HomeModel yy_modelWithJSON:responseObj.content];
        if ([_view respondsToSelector:@selector(onGetDataSourceSuccess:)]) {
            [_view onGetDataSourceSuccess:model];
        }
    }else{
//        HomeBannerModel *model = [HomeBannerModel yy_modelWithJSON:responseObj.content];
    }
}

- (void)onFail:(id)clientInfo errCode:(NSInteger)errCode errInfo:(NSString *)errInfo{
    if ([_view respondsToSelector: @selector(onGetDataSourceFail:des:)]) {
        [_view onGetDataSourceFail:errCode des:errInfo];
    }
}

@end
