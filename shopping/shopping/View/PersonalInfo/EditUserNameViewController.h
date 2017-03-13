//
//  EditUserNameViewController.h
//  shopping
//
//  Created by chentao on 15/12/28.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserService.h"
#import "UserTool.h"
#import "AlertTool.h"
#import "Protocol.h"
#import "SVProgressHUD.h"

@interface EditUserNameViewController : UIViewController

@property (nonatomic, retain) id<EditUserDelegate> delegate;

@end
