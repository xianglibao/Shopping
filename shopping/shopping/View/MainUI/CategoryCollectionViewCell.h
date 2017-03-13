//
//  CategoryCollectionViewCell.h
//  shopping
//
//  Created by chentao on 15/12/8.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CategoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lbCategoryName;

- (void)setData:(CategoryInfo*)categoryInfo;

@end
