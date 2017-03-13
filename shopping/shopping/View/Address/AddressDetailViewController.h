//
//  AddressDetailViewController.h
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
#import "AddressService.h"
#import "AlertTool.h"
#import "UserTool.h"
#import "AddressSearchViewController.h"
#import "Protocol.h"
#import "Public.h"
#import "StringTool.h"
#import "SVProgressHUD.h"
#import "ColorTool.h"

@interface AddressDetailViewController : UIViewController

@property (nonatomic, retain) id<AddressDelegate> delegate;

@property (nonatomic, retain) Address *address;

@end
