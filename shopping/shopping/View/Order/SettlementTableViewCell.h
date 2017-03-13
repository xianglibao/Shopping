//
//  SettlementTableViewCell.h
//  shopping
//
//  Created by chentao on 15/12/23.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderHeader.h"
#import "DateTool.h"

@interface SettlementTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbFirstOrderPlus;
@property (weak, nonatomic) IBOutlet UILabel *lbDeliveryPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbPayTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderTime;
@property (weak, nonatomic) IBOutlet UILabel *lbFirstOrderPlusTitle;

- (void)setData:(OrderHeader*)orderHeader;

@end
