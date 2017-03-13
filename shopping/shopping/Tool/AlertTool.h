//
//  AlertTool.h
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "CustomIOSAlertView.h"

@interface AlertTool : NSObject

+(void)showWaitAlert:(NSString *)msg view:(UIView *)view;

+(void)updateWaitAlert:(NSString *)msg;

+(void)hideWaitAlert;

+(void)showAlert:(NSString *)errMsg;

+(void)showAlert:(NSString *)errMsg listener:(id)listener;

+(void)showText:(NSString *)str;

+(void)showText:(NSString *)str delay:(NSTimeInterval)delay;

+(void)showAlert:(NSString *)errMsg tag:(NSInteger)tag listener:(id)listener;

+(void)showText:(NSString *)str view:(UIView*)view;

+ (void)showAlertWithConfirm:(NSString *)errMsg listener:(id<UIAlertViewDelegate>)listener;

+ (void)showAlertWithConfirm:(NSString *)errMsg tag:(NSInteger)tag listener:(id<UIAlertViewDelegate>)listener;

@end
