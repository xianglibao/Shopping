//
//  AddressListViewController.h
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressService.h"
#import "AlertTool.h"
#import "UserTool.h"
#import "AddressSo.h"
#import "Protocol.h"
#import "SVProgressHUD.h"

@interface AddressListViewController : UIViewController

@property (nonatomic, assign) BOOL fromShoppingCart;

@property (nonatomic, retain) id<ChangeAddressDelegate> delegate;

@end
