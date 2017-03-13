//
//  ServiceHelper.m
//  shopping
//
//  Created by chentao on 15/11/30.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "ServiceHelper.h"

@implementation ServiceHelper

+ (void)fill:(AFHTTPRequestOperationManager *)manager {
    [self fill:manager needToken:YES];
}

+ (void)fill:(AFHTTPRequestOperationManager *)manager
   needToken:(BOOL) needToken {
    AppUser *user = [UserTool getUser];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
        [manager.requestSerializer setValue:user.phoneNumber forHTTPHeaderField:@"login_name"];
        [manager.requestSerializer setValue:user.password forHTTPHeaderField:@"token"];
}

@end
