//
//  SettlementTableViewCell.m
//  shopping
//
//  Created by chentao on 15/12/23.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "SettlementTableViewCell.h"

@implementation SettlementTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(OrderHeader*)orderHeader
{
    _lbTotalPrice.text = [NSString stringWithFormat:@"￥%.2f", orderHeader.totalPrice];
    _lbFirstOrderPlus.text = [NSString stringWithFormat:@"-￥%.2f", orderHeader.firstOrderDiscountPrice];
    _lbDeliveryPrice.text = [NSString stringWithFormat:@"+￥%.2f", orderHeader.deliveryPrice];
    _lbPayTotalPrice.text = [NSString stringWithFormat:@"￥%.2f", orderHeader.paidPrice];
    
    NSTimeInterval interval = [orderHeader.createdTime longLongValue]/1000;
    NSString *createTime = [DateTool getStringFromDate: [NSDate dateWithTimeIntervalSince1970:interval] format:@"yyyy-MM-dd HH:mm:ss"];
    _lbOrderTime.text = [NSString stringWithFormat:@"%@", createTime];
}

@end
