#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HKHttpConfigure.h"
#import "HKHttpConstant.h"
#import "HKHttpManagerHeader.h"
#import "HKHttpLogger.h"
#import "HKHttpManager+Chain.h"
#import "HKHttpManager+Group.h"
#import "HKHttpManager+Validate.h"
#import "HKHttpManager.h"
#import "NSDictionary+JSON.h"
#import "NSString+Base64.h"
#import "HKHttpChainRequest.h"
#import "HKHttpGroupRequest.h"
#import "HKHttpRequest.h"
#import "HKRequestInterceptorProtocol.h"
#import "HKHttpResponse.h"
#import "HKResponseInterceptorProtocol.h"

FOUNDATION_EXPORT double HKHttpManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char HKHttpManagerVersionString[];

