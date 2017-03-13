//
//  OrderListTableViewCell.m
//  shopping
//
//  Created by chentao on 15/12/1.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "OrderListTableViewCell.h"

@implementation OrderListTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setData:(OrderHeader*)orderHeader
{
    _lbOrderTime.text = [NSString stringWithFormat:@"%@", [DateTool getStringFromDate:[NSDate dateWithTimeIntervalSince1970:[orderHeader.createdTime longLongValue]/1000] format:@"yyyy年MM月dd日 HH:mm:ss"]];
    if (orderHeader.paymentType != nil) {
        if ([orderHeader.paymentType isEqualToString:@"ALIPAY"]) {
            _lbPayType.text = @"支付宝支付";
        } else if ([orderHeader.paymentType isEqualToString:@"WEIXIN"]) {
            _lbPayType.text = @"微信支付";
        } else {
            _lbPayType.text = nil;
        }
    } else {
        _lbPayType.text = nil;
    }
    
    _lbTotalCount.text = [NSString stringWithFormat:@"共 %.0f 件商品", orderHeader.totalAmount];
    _lbTotalMoney.text = [NSString stringWithFormat:@"￥%.2f", orderHeader.paidPrice];
    
    
    if ([orderHeader.status isEqualToString:@"PAID"]) {
        [self setLabelColor:[ColorTool getNavColor]];
        _lbOrderStatus.text = @"已支付";
    } else if ([orderHeader.status isEqualToString:@"PAID_SUCCESS"]
               || [orderHeader.status isEqualToString:@"PAID_FINISHED"]) {
        [self setLabelColor:[ColorTool getNavColor]];
        _lbOrderStatus.text = @"正在配送中";
    }else if ([orderHeader.status isEqualToString:@"UN_PAID"]) {
        [self setLabelColor:[ColorTool getBlueColor]];
        _lbOrderStatus.text = @"待支付";
    } else if ([orderHeader.status isEqualToString:@"CANCEL"]) {
        [self setLabelColor:[UIColor lightGrayColor]];
        _lbOrderStatus.text = @"已取消";
    } else if ([orderHeader.status isEqualToString:@"ACCEPTED"]) {
        [self setLabelColor:[ColorTool getNavColor]];
        _lbOrderStatus.text = @"已收货";
    }
}

- (void)setLabelColor:(UIColor *)color
{
    _lbOrderStatus.textColor = color;
    _lbOrderTime.textColor = color;
    _lbTotalCount.textColor = color;
    _lbTotalMoney.textColor = color;
    _lbPayType.textColor = color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
