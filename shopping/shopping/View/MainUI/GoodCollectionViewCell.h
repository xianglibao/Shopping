//
//  GoodCollectionViewCell.h
//  shopping
//
//  Created by chentao on 15/12/7.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Good.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Protocol.h"
#import "ColorTool.h"
#import "StringTool.h"

@interface GoodCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) Good *good;
@property (nonatomic, retain) id<goodCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *lbGoodName;
@property (weak, nonatomic) IBOutlet UILabel *lbGoodPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imaShoppingCart;
@property (weak, nonatomic) IBOutlet UIImageView *imageHot;
@property (weak, nonatomic) IBOutlet UILabel *lbDiscount;
@property (weak, nonatomic) IBOutlet UILabel *lbOldPrice;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *lbHot;

- (IBAction)btnBuyClick:(UIButton *)sender;
- (void)setData:(Good*)good;

@end
