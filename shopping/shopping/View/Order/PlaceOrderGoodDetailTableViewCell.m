//
//  PlaceOrderGoodDetailTableViewCell.m
//  shopping
//
//  Created by chentao on 16/1/4.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "PlaceOrderGoodDetailTableViewCell.h"

@implementation PlaceOrderGoodDetailTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(ShoppingCartDetail*)shoppingCartDetail
{
    _lbGoodName.text = shoppingCartDetail.goodName;
    _lbGoodPrice.text = [NSString stringWithFormat:@"￥%.2f", shoppingCartDetail.goodPrice];
    _lbGoodCount.text = [NSString stringWithFormat:@"x %ld", shoppingCartDetail.goodCount];
}

@end
