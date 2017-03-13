//
//  ShoppingCartViewController.h
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartDao.h"
#import "ShoppingCartTableViewCell.h"
#import "AddressListTableViewCell.h"
#import "AddressListViewController.h"
#import "ShoppingCartDao.h"
#import "PlaceOrderViewController.h"
#import "GoodDetailViewController.h"
#import "GoodService.h"
#import "Protocol.h"
#import "AddressService.h"
#import "SVProgressHUD.h"

@interface ShoppingCartViewController : UIViewController

@property (nonatomic, retain) id<shoppingCartDelegate> delegate;

@end
