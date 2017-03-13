//
//  HeaderCollectionReusableView.m
//  shopping
//
//  Created by chentao on 15/12/7.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "HeaderCollectionReusableView.h"

@implementation HeaderCollectionReusableView

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setData:(CategoryInfo*)categoryInfo
{
    _category = categoryInfo;
    
    _lbCategoryName.text = categoryInfo.name;
    [_btnShowAll setTitle:@"查看全部" forState:UIControlStateNormal];
    
    if (categoryInfo.isEnd) {
        _btnShowAll.hidden = YES;
    }
}

- (IBAction)btnShowAllClick:(UIButton *)sender
{
    [_delegate showAll:_category];
}

@end
