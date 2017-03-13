//
//  OrderDetailTableViewCell.m
//  shopping
//
//  Created by chentao on 15/12/9.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

@implementation OrderDetailTableViewCell

- (void)awakeFromNib
{
    _imaGood.contentMode = UIViewContentModeScaleAspectFill;
    _imaGood.clipsToBounds = YES;
}

- (void)setData:(OrderDetail *)orderDetail
{
    if (orderDetail.imagePathBig != nil && orderDetail.imagePathBig.count > 0) {
        [_imaGood sd_setImageWithURL:[NSURL URLWithString:orderDetail.imagePathBig[0]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }

    _lbGoodName.text = orderDetail.goodName;
    _lbGoodCount.text = [NSString stringWithFormat:@"%.0f份", orderDetail.amount];
    _lbGoodPrice.text = [NSString stringWithFormat:@"￥%.2f", orderDetail.price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
