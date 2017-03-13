//
//  BaseInfoService.h
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "JsonSerializer.h"
#import "ServiceHelper.h"
#import "OrderSo.h"
#import "DiscountRuleSo.h"
#import "DispFeeRuleSo.h"
#import "ShopInfo.h"
#import "Feedback.h"
#import "NetConfig.h"
#import "ServerResponse.h"
#import "CodeInfo.h"
#import "CodeSo.h"

@interface BaseInfoService : NSObject

+ (void)searchDispatchFee:(DispFeeRuleSo*)dispFeeRuleSo
                onSuccess:(void (^)(NSArray *feeList))onSuccess
                   onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)searchDiscount:(DiscountRuleSo*)discountRuleSo
             onSuccess:(void (^)(NSArray *discountList))onSuccess
                onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)fetchShopInfo:(NSInteger)shopId
            onSuccess:(void (^)(ShopInfo *orderList))onSuccess
               onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)createFeedback:(Feedback*)feedback
             onSuccess:(void (^)(Feedback *feedback))onSuccess
                onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)SearchCodeInfo:(CodeSo*)codeSo
              onSuccess:(void (^)(NSArray *codeInfoList))onSuccess
                 onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

@end
