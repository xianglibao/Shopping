//
//  ServicePhonePicker.h
//  shopping
//
//  Created by chentao on 16/2/22.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"
#import "Protocol.h"
#import "BaseInfoService.h"
#import "AlertTool.h"
#import "SVProgressHUD.h"
#import "ServicePhoneCell.h"

@interface ServicePhonePicker : UIView

@property (nonatomic, retain) id<ServicePhoneDelegate> delegate;

- (void)show;
- (instancetype)initWithParentView:(UIView*)view;

@end
