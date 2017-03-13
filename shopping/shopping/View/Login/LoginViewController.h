//
//  LoginViewController.h
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserService.h"
#import "StringTool.h"
#import "AlertTool.h"
#import "UserTool.h"
#import "Protocol.h"
#import "MD5Tool.h"
#import "SVProgressHUD.h"
#import "ColorTool.h"

@interface LoginViewController : UIViewController

@property (nonatomic, retain) id<LoginDelegate> delegate;

@end
