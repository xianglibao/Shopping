//
//  ShoppingCartTableViewCell.m
//  shopping
//
//  Created by chentao on 15/12/9.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@interface ShoppingCartTableViewCell ()

@property (nonatomic, retain) UIImage *checkedImage;
@property (nonatomic, retain) UIImage *uncheckedImage;

@end

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib
{
    _imaCheckBox.tintColor = [ColorTool getNavColor];
    _checkedImage = [[UIImage imageNamed:@"checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _uncheckedImage = [[UIImage imageNamed:@"unchecked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    _imaGood.contentMode = UIViewContentModeScaleAspectFill;
    _imaGood.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setData:(ShoppingCartDetail*)shoppingCartDetail
{
    _shoppingCartDetail = shoppingCartDetail;
    
    _lbGoodName.text = shoppingCartDetail.goodName;
    _lbGoodPrice.text = [NSString stringWithFormat:@"￥%.2f", shoppingCartDetail.goodPrice];
    _lbNumber.text = [NSString stringWithFormat:@"%ld", shoppingCartDetail.goodCount];

    if (shoppingCartDetail.imageUrl.length > 0) {
        [_imaGood sd_setImageWithURL:[NSURL URLWithString:shoppingCartDetail.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    
    if (shoppingCartDetail.isSelected) {
        _imaCheckBox.image = _checkedImage;
    } else {
        _imaCheckBox.image = _uncheckedImage;
    }
}

- (IBAction)btnAddClick:(UIButton *)sender
{
    _shoppingCartDetail.goodCount++;
    _lbNumber.text = [NSString stringWithFormat:@"%ld", _shoppingCartDetail.goodCount];
    
    [_delegate addClick:_shoppingCartDetail];
}

- (IBAction)btnCutClick:(UIButton *)sender
{
    if (_shoppingCartDetail.goodCount == 1) {
        return;
    }
    
    _shoppingCartDetail.goodCount--;
    _lbNumber.text = [NSString stringWithFormat:@"%ld", _shoppingCartDetail.goodCount];
    
    [_delegate cutClick:_shoppingCartDetail];
}

- (IBAction)btnSelectClick:(UIButton *)sender
{
    if (_shoppingCartDetail.isSelected) {
        _shoppingCartDetail.isSelected = NO;
        _imaCheckBox.image = _uncheckedImage;
    } else {
        _shoppingCartDetail.isSelected = YES;
        _imaCheckBox.image = _checkedImage;
    }
    
    [_delegate selectClick:_shoppingCartDetail];
}

- (IBAction)btnGoodImageClick:(UIButton *)sender
{
    [_delegate goodImageClick:_shoppingCartDetail];
}

@end
