//
//  OrderService.h
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
#import "NetConfig.h"
#import "ServerResponse.h"
#import "OrderHeader.h"
#import "AlipaySignSo.h"
#import "WeixinSignSo.h"
#import "WeixinSignInfo.h"

@interface OrderService : NSObject

+ (void)fetchOrderList:(OrderSo*)orderSo
             onSuccess:(void (^)(NSArray *orderList))onSuccess
                onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)searchOrderDetail:(OrderSo*)orderSo
                onSuccess:(void (^)(NSArray *orderList))onSuccess
                   onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)calcOrderFee:(OrderHeader*)orderHeader
           onSuccess:(void (^)(OrderHeader *orderHeader))onSuccess
              onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)submitOrder:(OrderHeader*)orderHeader
          onSuccess:(void (^)(OrderHeader *orderHeader))onSuccess
             onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)signForAlipay:(AlipaySignSo*)signSo
            onSuccess:(void (^)(NSString *signString))onSuccess
               onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)submitClientPayResult:(OrderHeader*)orderHeader
                    onSuccess:(void (^)(OrderHeader *orderHeader))onSuccess
                       onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)cancelOrder:(OrderHeader*)orderHeader
          onSuccess:(void (^)(OrderHeader *orderHeader))onSuccess
             onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)signForWxpay:(WeixinSignSo*)signSo
           onSuccess:(void (^)(WeixinSignInfo *signInfo))onSuccess
              onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)receiveGood:(OrderHeader*)orderHeader
          onSuccess:(void (^)(OrderHeader *orderHeader))onSuccess
             onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

@end
