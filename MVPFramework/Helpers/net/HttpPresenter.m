//
//  HttpPresenter.m
//  MVP
//
//  Created by 李超峰 on 2020/9/2.
//  Copyright © 2020 李超峰. All rights reserved.
//

#import "HttpPresenter.h"

@implementation HttpPresenter
- (instancetype) initWithView:(id)view{
    if (self = [super initWithView:view]) {
        _httpClient = [[HttpClient alloc] initWithHandle:self];
    }
    return self;
}
#pragma mark - HttpResponseHandle
- (void)onSuccess:(id)responseObject{
    
}

- (void)onFail:(id)clientInfo errCode:(NSInteger)errCode errInfo:(NSString *)errInfo{

}
@end
