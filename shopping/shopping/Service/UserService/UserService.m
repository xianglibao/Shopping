//
//  UserService.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "UserService.h"

@implementation UserService

#pragma mark - 发送验证码

+ (void)sendSignCode:(AppUser *)user
           onSuccess:(void (^)(BOOL success))onSuccess
              onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getSendSignCodeUrl];
    
    NSDictionary *param = [AppUser toDictionary:user];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager needToken:NO];
    
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            onSuccess(nil);
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

#pragma mark - 注册

+ (void)signUp:(AppUser*)user
     onSuccess:(void (^)(AppUser *user))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getSignUpUrl];
    
    NSDictionary *param = [AppUser toDictionary:user];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager needToken:NO];
    
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
            
            NSArray *appUserList = [AppUser toModelListByJsonArray:response.voList];
            if (appUserList == nil || appUserList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }

            onSuccess(appUserList[0]);
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

#pragma mark - 登录

+ (void)login:(AppUser*)user
    onSuccess:(void (^)(AppUser *user))onSuccess
       onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getLoginUrl];
    
    NSDictionary *param = [AppUser toDictionary:user];
    
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

#pragma mark - 主键查询

+ (void)getUserById:(long)userId
          onSuccess:(void (^)(AppUser *user))onSuccess
             onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getSearchUserUrl];
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [ServiceHelper fill:manager];
    
    [manager POST:urlStr parameters:[NSNumber numberWithLong:userId] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            AppUser *user = [AppUser toModel:operation.responseString];
            onSuccess(user);
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

+ (void)update:(AppUser*)user
     onSuccess:(void (^)(AppUser *user))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail
{
    NSString *urlStr = [NetConfig getUpdateUserUrl];
    
    NSDictionary *param = [AppUser toDictionary:user];
    
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
            
            NSArray *appUserList = [AppUser toModelListByJsonArray:response.voList];
            if (appUserList == nil || appUserList.count == 0) {
                onFail(@"服务端返回数据有误", 100);
                return;
            }
            
            onSuccess(appUserList[0]);
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
