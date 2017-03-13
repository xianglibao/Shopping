//
//  PlaceOrderViewController.h
//  shopping
//
//  Created by chentao on 15/12/21.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressListTableViewCell.h"
#import "PlaceOrderGoodDetailTableViewCell.h"
#import "PlaceOrderSettlementTableViewCell.h"
#import "Address.h"
#import "OrderHeader.h"
#import "OrderDetail.h"
#import "ShoppingCartDetail.h"
#import "PayViewController.h"
#import "ColorTool.h"
#import "OrderService.h"
#import "Public.h"
#import "SVProgressHUD.h"
#import "Protocol.h"

#import "DeliveryTimePicker.h"

@interface PlaceOrderViewController : UIViewController

@property (nonatomic, retain) Address *address;
@property (nonatomic, retain) NSArray *shoppingCartDetailList;

@property (nonatomic, retain) UIViewController *vc;

@end
