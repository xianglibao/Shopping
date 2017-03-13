//
//  UserTool.h
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUser.h"
#import "JsonSerializer.h"
#import "AppTool.h"
#import "Address.h"

@interface UserTool : NSObject

//用户信息
+ (void)setUser:(AppUser *)user;

+ (AppUser *)getUser;

+ (BOOL)isLogin;

+ (void)setCurrentAddress:(NSNumber*)addressId key:(NSNumber*)userId;

+ (NSNumber*)getCurrentAddressType:(NSNumber*)userId;

@end
