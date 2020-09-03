//
//  HttpPresenter.h
//  MVP
//
//  Created by 李超峰 on 2020/9/2.
//  Copyright © 2020 李超峰. All rights reserved.
//

#import "Presenter.h"
#import "HttpResponseHandle.h"
#import "HttpClient.h"
#import "HKHttpResponse.h"
#import <YYModel.h>
@interface HttpPresenter<E> : Presenter<E> <HttpResponseHandle>

@property (nonatomic,strong)HttpClient *httpClient;

@end
