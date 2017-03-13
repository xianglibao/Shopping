//
//  DeliveryTimeCell.h
//  shopping
//
//  Created by chentao on 16/1/18.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"
#import "Public.h"
#import "DeliveryTimeInfo.h"
#import "ColorTool.h"

@interface DeliveryTimeCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setData:(DeliveryTimeInfo *)deliveryTime;

@end
