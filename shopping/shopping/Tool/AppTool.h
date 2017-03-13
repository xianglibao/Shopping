//
//  AppTool.h
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppTool : NSObject

//软件版本
+(NSString *)getAppVersion;

//软件名字
+(NSString *)getAppName;

+(NSString *)getAppBuildVersion;

@end
