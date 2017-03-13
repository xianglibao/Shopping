//
//  ChangePhoneNumberViewController.h
//  shopping
//
//  Created by chentao on 15/12/28.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StringTool.h"
#import "AlertTool.h"
#import "UserTool.h"
#import "UserService.h"
#import "MD5Tool.h"
#import "Protocol.h"
#import "SVProgressHUD.h"
#import "ColorTool.h"

@interface ChangePhoneNumberViewController : UIViewController

@property (nonatomic, retain) id<EditUserDelegate> delegate;

@end
