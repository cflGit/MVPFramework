//
//  HomePresenter.h
//  MVPFramework
//
//  Created by 李超峰 on 2020/9/2.
//  Copyright © 2020 李超峰. All rights reserved.
//

#import "HttpPresenter.h"
#import "HomeModel.h"

@protocol HomePresenterProtocol <NSObject>

- (void)onGetDataSourceSuccess:(id)model;

- (void)onGetDataSourceFail:(NSInteger) errorCode des:(NSString *)des;

@end


@interface HomePresenter : HttpPresenter

- (void)getMovieListWithUrlString:(NSString *)urlString param:(NSDictionary *)param;

@end
