//
//  PayViewController.h
//  shopping
//
//  Created by chentao on 15/12/21.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertTool.h"
#import "ColorTool.h"
#import "Public.h"
#import "OrderService.h"
#import <AlipaySDK/AlipaySDK.h>
#import "SVProgressHUD.h"
#import "ShoppingCartDao.h"
#import "Protocol.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "AppDelegate.h"

@interface PayViewController : UIViewController

@property (nonatomic, retain) OrderHeader *orderHeader;

@property (nonatomic, assign) BOOL fromOrderDetail;

@property (nonatomic, retain) UIViewController *vc;

@end
