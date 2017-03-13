//
//  CategoryCollectionViewCell.m
//  shopping
//
//  Created by chentao on 15/12/8.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell

- (void)awakeFromNib
{
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setData:(CategoryInfo*)categoryInfo
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:categoryInfo.imagePath] placeholderImage:[UIImage imageNamed:@"aa.png"]];
    
    _lbCategoryName.text = categoryInfo.name;
}

@end
