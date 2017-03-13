//
//  AppDelegate.h
//  shopping
//
//  Created by chentao on 15/11/12.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorTool.h"
#import "Public.h"
#import "OrderService.h"
#import "WXApi.h"
#import "OrderHeader.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, weak) id<WXApiDelegate> wxDelegate;
@property (nonatomic, weak) OrderHeader *orderHeader;

@end

