//
//  BaseInfoService.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "BaseInfoService.h"

@implementation BaseInfoService

#pragma mark - 派送费用

+ (void)searchDispatchFee:(DispFeeRuleSo*)dispFeeRuleSo
             onSuccess:(void (^)(NSArray *feeList))onSuccess
                onFail:(void (^)(NSString *error, NSInteger statusCode))onFail {
    NSString *urlStr = @"http://121.40.211.32:8080/spmk-war-1.0.0/rest/app/base/disp_fee_rule/search";
    
    NSDictionary *param = [DispFeeRuleSo toDictionary:dispFeeRuleSo];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            onSuccess(nil);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        
        if (statusCode == 403) {
            //[UserUtil setTokenError:YES];
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 订单金额限制，首单减额

+ (void)searchDiscount:(DiscountRuleSo*)discountRuleSo
             onSuccess:(void (^)(NSArray *discountList))onSuccess
                onFail:(void (^)(NSString *error, NSInteger statusCode))onFail {
    NSString *urlStr = @"http://121.40.211.32:8080/spmk-war-1.0.0/rest/app/base/discount_rule/search";
    
    NSDictionary *param = [DiscountRuleSo toDictionary:discountRuleSo];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            onSuccess(nil);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        
        if (statusCode == 403) {
            //[UserUtil setTokenError:YES];
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 店家信息

+ (void)fetchShopInfo:(NSInteger)shopId
             onSuccess:(void (^)(ShopInfo *orderList))onSuccess
                onFail:(void (^)(NSString *error, NSInteger statusCode))onFail {
    NSString *urlStr = @"http://121.40.211.32:8080/spmk-war-1.0.0/rest/app/base/discount_rule/search";
    
    //NSDictionary *param = [OrderSo toDictionary:orderSo];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:[NSNumber numberWithInteger:shopId] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            onSuccess(nil);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        
        if (statusCode == 403) {
            //[UserUtil setTokenError:YES];
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 反馈

+ (void)createFeedback:(Feedback*)feedback
             onSuccess:(void (^)(Feedback *feedback))onSuccess
                onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getFeedBackUrl];
    
    NSDictionary *param = [Feedback toDictionary:feedback];
    
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
            
            NSArray *feedbackList = [Feedback toModelListByJsonArray:response.voList];
            if (feedbackList == nil || feedbackList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(feedbackList[0]);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        
        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

#pragma mark - 客服电话

+ (void)SearchCodeInfo:(CodeSo*)codeSo
             onSuccess:(void (^)(NSArray *codeInfoList))onSuccess
                onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getServicePhoneUrl];
    
    NSDictionary *param = [CodeSo toDictionary:codeSo];
    
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
            
            NSArray *codeInfoList = [CodeInfo toModelListByJsonArray:response.voList];
            
            onSuccess(codeInfoList);
        } else {
            onFail(@"服务端返回数据有误", operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        
        if (statusCode == 403) {
            onFail(@"用户信息过期,请重新登录", statusCode);
        } else {
            onFail([NSString stringWithFormat:@"通讯异常(%ld)",(long)statusCode], statusCode);
        }
    }];
}

@end
