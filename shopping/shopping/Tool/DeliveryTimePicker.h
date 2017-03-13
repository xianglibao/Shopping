//
//  DeliveryTimePicker.h
//  shopping
//
//  Created by chentao on 16/1/18.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"
#import "Protocol.h"
#import "DeliveryTimeCell.h"
#import "DeliveryTimeInfo.h"
#import "DateTool.h"

@interface DeliveryTimePicker : UIView

@property (nonatomic, retain) id<DeliveryTimeDelegate> delegate;

- (void)show;
- (instancetype)initWithParentView:(UIView*)view;

@end
