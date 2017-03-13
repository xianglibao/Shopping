//
//  AddressService.h
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
#import "UserSo.h"
#import "NetConfig.h"
#import "Address.h"
#import "ServerResponse.h"
#import "AddressSo.h"

@interface AddressService : NSObject

+ (void)create:(Address *)address
     onSuccess:(void (^)(Address *address))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)search:(AddressSo *)so
     onSuccess:(void (^)(NSArray *addressList))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)update:(Address *)address
     onSuccess:(void (^)(Address *address))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)delete:(Address *)address
     onSuccess:(void (^)(BOOL success))onSuccess
        onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

@end
