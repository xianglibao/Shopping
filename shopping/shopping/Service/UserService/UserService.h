//
//  UserService.h
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "JsonSerializer.h"
#import "ServiceHelper.h"
#import "AppUser.h"
#import "NetConfig.h"
#import "ServerResponse.h"

@interface UserService : NSObject

#pragma mark - 发送验证码

+ (void)sendSignCode:(AppUser *)user
           onSuccess:(void (^)(BOOL success))onSuccess
              onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

#pragma mark - 注册

+ (void)signUp:(AppUser*)user
     onSuccess:(void (^)(AppUser *user))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

#pragma mark - 登录

+ (void)login:(AppUser*)user
    onSuccess:(void (^)(AppUser *user))onSuccess
       onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

#pragma mark - 主键查询

+ (void)getUserById:(long)userId
          onSuccess:(void (^)(AppUser *user))onSuccess
             onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

#pragma mark - 更新

+ (void)update:(AppUser*)user
     onSuccess:(void (^)(AppUser *user))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

@end
