//
//  AddressService.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "AddressService.h"

@implementation AddressService

#pragma mark - 创建

+ (void)create:(Address*)address
     onSuccess:(void (^)(Address *address))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getAddressCreateUrl];
    
    NSDictionary *param = [Address toDictionary:address];
    
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
            
            NSArray *addressList = [Address toModelListByJsonArray:response.voList];
            
            if (addressList == nil || addressList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(addressList[0]);
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

#pragma mark - 查询

+ (void)search:(AddressSo*)so
     onSuccess:(void (^)(NSArray *addressList))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getAddressSearchUrl];
    
    NSDictionary *param = [AddressSo toDictionary:so];
    
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
            
            NSArray *addressList = [Address toModelListByJsonArray:response.voList];
            
            onSuccess(addressList);
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

#pragma mark - 更新

+ (void)update:(Address*)address
     onSuccess:(void (^)(Address *address))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getAddressUpdateUrl];
    
    NSDictionary *param = [Address toDictionary:address];
    
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
            
            NSArray *addressList = [Address toModelListByJsonArray:response.voList];
            
            if (addressList == nil || addressList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(addressList[0]);
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

#pragma mark - 删除

+ (void)delete:(Address*)address
     onSuccess:(void (^)(BOOL success))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getAddressDeleteUrl];
    
    NSDictionary *param = [Address toDictionary:address];
    
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
            
            NSArray *addressList = [Address toModelListByJsonArray:response.voList];
            
            if (addressList == nil || addressList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(addressList[0]);
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
