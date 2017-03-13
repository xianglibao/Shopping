//
//  AddressSearchViewController.h
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "SVProgressHUD.h"
#import "Protocol.h"
#import "ColorTool.h"

@interface AddressSearchViewController : UIViewController

@property (nonatomic, retain) id<SearchAddressDelegate> delegate;

@end
