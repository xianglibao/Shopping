//
//  AlertTool.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "AlertTool.h"
#import "AppDelegate.h"

@implementation AlertTool

static MBProgressHUD *infoHud;

+ (void)showWaitAlert:(NSString *)msg view:(UIView *)view {
    if (infoHud != nil) {
        [infoHud hide:NO];
    }
    
    infoHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    infoHud.labelText = msg;
}

+ (void)updateWaitAlert:(NSString *)msg {
    infoHud.labelText = msg;
}

+ (void)hideWaitAlert {
    [infoHud hide:YES];
}

+ (void)showAlert:(NSString *)errMsg listener:(id<UIAlertViewDelegate>)listener {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errMsg delegate:listener cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
}

+ (void)showAlertWithConfirm:(NSString *)errMsg listener:(id<UIAlertViewDelegate>)listener {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errMsg delegate:listener cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertView show];
}

+ (void)showAlertWithConfirm:(NSString *)errMsg tag:(NSInteger)tag listener:(id<UIAlertViewDelegate>)listener {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errMsg delegate:listener cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alertView.tag = tag;
    
    [alertView show];
}

+ (void)showAlert:(NSString *)errMsg tag:(NSInteger)tag listener:(id<UIAlertViewDelegate>)listener {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errMsg delegate:listener cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = tag;
    
    [alertView show];
}

+ (void)showAlert:(NSString *)errMsg {
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:errMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

+ (void)showText:(NSString *)str {
    dispatch_async(dispatch_get_main_queue(), ^{
        [AlertTool showText:str delay:1];
    });
}

+(void)showText:(NSString *)str view:(UIView*)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = str;
    hud.detailsLabelFont=[UIFont systemFontOfSize:17];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

+ (void)showText:(NSString *)str delay:(NSTimeInterval)delay {
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *win = [windows objectAtIndex:0];
    
    if (win.subviews.count > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[win.subviews objectAtIndex:0] animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = str;
        hud.detailsLabelFont=[UIFont systemFontOfSize:17];
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:delay];
    }
}

@end
