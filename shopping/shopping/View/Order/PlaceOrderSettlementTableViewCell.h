//
//  PlaceOrderSettlementTableViewCell.h
//  shopping
//
//  Created by chentao on 16/1/4.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderHeader.h"
#import "OrderDetail.h"

@interface PlaceOrderSettlementTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbGoodTotalPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbFirstOrderPlus;
@property (weak, nonatomic) IBOutlet UILabel *lbDeliveryPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbPayPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbFirstOrderPlusTitle;

- (void)setData:(OrderHeader *)orderHeader;

@end
