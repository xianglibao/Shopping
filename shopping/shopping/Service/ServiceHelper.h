//
//  ServiceHelper.h
//  shopping
//
//  Created by chentao on 15/11/30.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserTool.h"
#import "AFNetworking.h"

@interface ServiceHelper : NSObject

+ (void)fill:(AFHTTPRequestOperationManager *)manager;

+ (void)fill:(AFHTTPRequestOperationManager *)manager
   needToken:(BOOL) needToken;

@end
