//
//  DeviceTool.h
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceTool : NSObject

//系统版本 4.0
+ (NSString *)getSystemVersion;

//Universally Unique Identifier
+ (NSString *)getUUID;

//device name /My iphone
+ (NSString *)getDeviceName;

//设备型号
+ (NSString *)getDeviceModel;

+ (NSString *)getPhoneNumber;

+ (NSString *)getDeviceID;

+ (float)getScreenWidth;

+ (float)getScreenHeight;

@end
