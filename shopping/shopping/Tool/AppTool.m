//
//  AppTool.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "AppTool.h"

@implementation AppTool

//获取应用版本号
+ (NSString *)getAppVersion {
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [appInfo objectForKey:@"CFBundleShortVersionString"];
    
    return currentVersion;
}

//获取当前应用build版本号
+ (NSString *)getAppBuildVersion {
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [appInfo objectForKey:@"CFBundleVersion"];
    
    return currentVersion;
}

//获取app名称
+ (NSString *)getAppName {
    NSDictionary *appInfo = [[NSBundle mainBundle]infoDictionary];
    NSString *appName = [appInfo objectForKey:@"CFBundleDisplayName"];
    
    return appName;
}

@end
