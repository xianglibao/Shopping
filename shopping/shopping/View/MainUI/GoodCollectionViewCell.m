//
//  GoodCollectionViewCell.m
//  shopping
//
//  Created by chentao on 15/12/7.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "GoodCollectionViewCell.h"

@implementation GoodCollectionViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[ColorTool getTableViewSectionColor] CGColor];
    self.layer.borderWidth = 0.3;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    
    UIImage *image = [[UIImage imageNamed:@"add_shoppingCart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _imaShoppingCart.tintColor = [ColorTool getNavColor];
    _imaShoppingCart.contentMode = UIViewContentModeScaleAspectFill;
    _imaShoppingCart.image = image;
}

- (void)setData:(Good*)good
{
    _good = good;
    
    if (good.imagePathBig != nil && good.imagePathBig.count > 0) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:good.imagePathBig[0]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    
    _lbGoodName.text = good.name;
    
    //热销
    if ([_good.promotionType isEqualToString:@"HOT"]) {
        _lbHot.hidden = NO;
        _lbHot.layer.cornerRadius = 10;
        _lbHot.backgroundColor = RGB(246, 52, 41);
        _lbHot.textColor = [UIColor whiteColor];
        _lbHot.text = @"热销";
    } else {
        _lbHot.hidden = YES;
    }
    
    //折扣
    if (_good.discount == nil || [_good.discount doubleValue] == 1) {
        _lbDiscount.hidden = YES;
        _lbOldPrice.hidden = YES;
        _lineView.hidden = YES;
        _lbGoodPrice.text = [NSString stringWithFormat:@"￥%.2f", [good.price doubleValue]];
    } else {
        _lbDiscount.hidden = NO;
        _lbOldPrice.hidden = NO;
        _lineView.hidden = NO;
        _lbDiscount.backgroundColor = RGB(246, 52, 41);
        _lbDiscount.textColor = [UIColor whiteColor];
        _lbDiscount.layer.cornerRadius = 10;
        
        NSString *str = [StringTool removeRedundantZero:[NSString stringWithFormat:@"%.3f", [good.discount doubleValue] * 10]];

        _lbDiscount.text = [NSString stringWithFormat:@"%@折", str];
        //_lbDiscount.text = [StringTool removeRedundantZero:@"90.00012034"];
        _lbOldPrice.text = [NSString stringWithFormat:@"￥%.2f", [good.showPrice doubleValue]];
        _lbGoodPrice.text = [NSString stringWithFormat:@"￥%.2f", [good.price doubleValue]];
    }
}

- (IBAction)btnBuyClick:(UIButton *)sender
{
    [_delegate addToShoppingCart:_good];
}

@end
