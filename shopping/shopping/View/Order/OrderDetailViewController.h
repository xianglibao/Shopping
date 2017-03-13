//
//  OrderDetailViewController.h
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailTableViewCell.h"
#import "OrderHeader.h"
#import "OrderService.h"
#import "AlertTool.h"
#import "SVProgressHUD.h"
#import "SettlementTableViewCell.h"
#import "PayViewController.h"

@interface OrderDetailViewController : UIViewController

@property (nonatomic, retain) OrderHeader *orderHeader;

@end
