//
//  GoodService.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "GoodService.h"

@implementation GoodService

#pragma mark - 主页商品展示

+ (void)fetchGoodList:(CategorySo*)categorySo
           onSuccess:(void (^)(NSArray *categoryInfoList))onSuccess
              onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getFetchGoodListUrl];
    
    NSDictionary *param = [CategorySo toDictionary:categorySo];
    
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
            
            NSArray *categoryInfoList = [CategoryInfo toModelListByJsonArray:response.voList];
            
            onSuccess(categoryInfoList);
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

#pragma mark - 侧栏类别显示

+ (void)FetchAllCategory:(CategorySo*)categorySo
           onSuccess:(void (^)(NSArray *categoryInfoList))onSuccess
              onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getFetchAllCategoryUrl];
    
    NSDictionary *param = [CategorySo toDictionary:categorySo];
    
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
            
            NSArray *categoryInfoList = [CategoryInfo toModelListByJsonArray:response.voList];
            
            onSuccess(categoryInfoList);
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

#pragma mark - 搜索商品

+ (void)searchGood:(GoodSo*)goodSo
           onSuccess:(void (^)(NSArray *goodList))onSuccess
              onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getSearchGoodUrl];
    
    NSDictionary *param = [GoodSo toDictionary:goodSo];
    
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
            
            NSArray *goodList = [Good toModelListByJsonArray:response.voList];
            
            onSuccess(goodList);
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

#pragma mark - 根据ID搜索商品

+ (void)getGoodById:(long)goodId
         onSuccess:(void (^)(Good *good))onSuccess
            onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getFetchGoodByIdUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    
    AppUser *user = [UserTool getUser];
    [request setHTTPMethod:@"POST"];
    
    NSString *contentType = [NSString stringWithFormat:@"application/json;charset=UTF-8"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request addValue:user.phoneNumber forHTTPHeaderField: @"login_name"];
    [request addValue:user.password forHTTPHeaderField: @"token"];
    
    [request setHTTPBody:[[NSString stringWithFormat:@"%ld", goodId] dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            
            NSArray *goodList = [Good toModelListByJsonArray:response.voList];
            if (goodList == nil || goodList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(goodList[0]);
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
    
    [op start];
}

@end
