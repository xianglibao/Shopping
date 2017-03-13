//
//  OrderService.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "OrderService.h"

@implementation OrderService

#pragma mark - 订单列表

+ (void)fetchOrderList:(OrderSo*)orderSo
             onSuccess:(void (^)(NSArray *orderList))onSuccess
                onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getFetchOrderListUrl];
    
    NSDictionary *param = [OrderSo toDictionary:orderSo];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            ServerResponse *response = [ServerResponse toModel:operation.responseData];
            
            if (response == nil) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            if (!response.success) {
                onFail(response.msgContent, 100);
                return;
            }
            
            NSArray *orderHeaderList = [OrderHeader toModelListByJsonArray:response.voList];
            
            onSuccess(orderHeaderList);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 0) {
            onFail(@"网络异常", 100);
            return ;
        }

        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 订单详情

+ (void)searchOrderDetail:(OrderSo*)orderSo
                onSuccess:(void (^)(NSArray *orderList))onSuccess
                   onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getSearchOrderDetailUrl];
    
    NSDictionary *param = [OrderSo toDictionary:orderSo];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            ServerResponse *response = [ServerResponse toModel:operation.responseData];
            
            if (response == nil) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            if (!response.success) {
                onFail(response.msgContent, 100);
                return;
            }
            
            NSArray *orderHeaderList = [OrderHeader toModelListByJsonArray:response.voList];
            if (orderHeaderList == nil || orderHeaderList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(orderHeaderList);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 0) {
            onFail(@"网络异常", 100);
            return ;
        }

        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 计算订单费用

+ (void)calcOrderFee:(OrderHeader*)orderHeader
                onSuccess:(void (^)(OrderHeader *orderHeader))onSuccess
                   onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getCalcOrderFeeUrl];
    
    NSDictionary *param = [OrderHeader toDictionary:orderHeader];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            ServerResponse *response = [ServerResponse toModel:operation.responseData];
            
            if (response == nil) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            if (!response.success) {
                onFail(response.msgContent, 100);
                return;
            }
            
            NSArray *orderHeaderList = [OrderHeader toModelListByJsonArray:response.voList];
            if (orderHeaderList == nil || orderHeaderList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(orderHeaderList[0]);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 0) {
            onFail(@"网络异常", 100);
            return ;
        }

        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 确认下单

+ (void)submitOrder:(OrderHeader*)orderHeader
           onSuccess:(void (^)(OrderHeader *orderHeader))onSuccess
              onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getSubmitOrderUrl];
    
    NSDictionary *param = [OrderHeader toDictionary:orderHeader];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            ServerResponse *response = [ServerResponse toModel:operation.responseData];
            
            if (response == nil) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            if (!response.success) {
                onFail(response.msgContent, 100);
                return;
            }
            
            NSArray *orderHeaderList = [OrderHeader toModelListByJsonArray:response.voList];
            if (orderHeaderList == nil || orderHeaderList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(orderHeaderList[0]);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 0) {
            onFail(@"网络异常", 100);
            return ;
        }

        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 签名

+ (void)signForAlipay:(AlipaySignSo*)signSo
            onSuccess:(void (^)(NSString *signString))onSuccess
               onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getSignForAlipay];
    
    NSDictionary *param = [AlipaySignSo toDictionary:signSo];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            ServerResponse *response = [ServerResponse toModel:operation.responseData];
            
            if (response == nil) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            if (!response.success) {
                onFail(response.msgContent, 100);
                return;
            }
            
            NSArray *signStringList = response.voList;
            if (signStringList == nil || signStringList.count == 0) {
                onFail(@"获取签名字符串失败", 100);
                return;
            }
            
            onSuccess(signStringList[0]);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 0) {
            onFail(@"网络异常", 100);
            return ;
        }
        
        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 提交客户端支付结果

+ (void)submitClientPayResult:(OrderHeader*)orderHeader
                    onSuccess:(void (^)(OrderHeader *orderHeader))onSuccess
                       onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getSubmitPayResultUrl];
    
    NSDictionary *param = [OrderHeader toDictionary:orderHeader];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            ServerResponse *response = [ServerResponse toModel:operation.responseData];
            
            if (response == nil) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            if (!response.success) {
                onFail(response.msgContent, 100);
                return;
            }
            
            NSArray *orderHeaderList = [OrderHeader toModelListByJsonArray:response.voList];
            if (orderHeaderList == nil || orderHeaderList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(orderHeaderList[0]);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 0) {
            onFail(@"没有网络", 100);
            return ;
        }
        
        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 取消订单

+ (void)cancelOrder:(OrderHeader*)orderHeader
          onSuccess:(void (^)(OrderHeader *orderHeader))onSuccess
             onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getCancelOrderUrl];
    
    NSDictionary *param = [OrderHeader toDictionary:orderHeader];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            ServerResponse *response = [ServerResponse toModel:operation.responseData];
            
            if (response == nil) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            if (!response.success) {
                onFail(response.msgContent, 100);
                return;
            }
            
            NSArray *orderHeaderList = [OrderHeader toModelListByJsonArray:response.voList];
            if (orderHeaderList == nil || orderHeaderList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(orderHeaderList[0]);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 0) {
            onFail(@"网络异常", 100);
            return ;
        }
        
        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 微信支付

+ (void)signForWxpay:(WeixinSignSo*)signSo
            onSuccess:(void (^)(WeixinSignInfo *signInfo))onSuccess
               onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getSignForWeixinUrl];
    
    NSDictionary *param = [WeixinSignSo toDictionary:signSo];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            ServerResponse *response = [ServerResponse toModel:operation.responseData];
            
            if (response == nil) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            if (!response.success) {
                onFail(response.msgContent, 100);
                return;
            }
            
            NSArray *signStringList = response.voList;
            if (signStringList == nil || signStringList.count == 0) {
                onFail(@"获取签名字符串失败", 100);
                return;
            }
            
            WeixinSignInfo *signInfo = [WeixinSignInfo toModel:signStringList[0]];
            
            onSuccess(signInfo);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 0) {
            onFail(@"网络异常", 100);
            return ;
        }
        
        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 确认收货

+ (void)receiveGood:(OrderHeader*)orderHeader
           onSuccess:(void (^)(OrderHeader *orderHeader))onSuccess
              onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getReceiveGoodUrl];
    
    NSDictionary *param = [OrderHeader toDictionary:orderHeader];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            ServerResponse *response = [ServerResponse toModel:operation.responseData];
            
            if (response == nil) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            if (!response.success) {
                onFail(response.msgContent, 100);
                return;
            }
            
            NSArray *orderHeaderList = [OrderHeader toModelListByJsonArray:response.voList];
            if (orderHeaderList == nil || orderHeaderList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(orderHeaderList[0]);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 0) {
            onFail(@"网络异常", 100);
            return ;
        }
        
        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

@end
