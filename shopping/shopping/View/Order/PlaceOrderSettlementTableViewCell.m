//
//  PlaceOrderSettlementTableViewCell.m
//  shopping
//
//  Created by chentao on 16/1/4.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "PlaceOrderSettlementTableViewCell.h"

@implementation PlaceOrderSettlementTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(OrderHeader *)orderHeader
{
    _lbGoodTotalPrice.text = [NSString stringWithFormat:@"￥%.2f", orderHeader.totalPrice];
    _lbFirstOrderPlus.text = [NSString stringWithFormat:@"-￥%.2f", orderHeader.firstOrderDiscountPrice];
    _lbDeliveryPrice.text = [NSString stringWithFormat:@"+￥%.2f", orderHeader.deliveryPrice];
    _lbPayPrice.text = [NSString stringWithFormat:@"￥%.2f", orderHeader.paidPrice];}

@end
