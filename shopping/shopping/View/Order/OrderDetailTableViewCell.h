//
//  OrderDetailTableViewCell.h
//  shopping
//
//  Created by chentao on 15/12/9.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetail.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OrderDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imaGood;
@property (weak, nonatomic) IBOutlet UILabel *lbGoodName;
@property (weak, nonatomic) IBOutlet UILabel *lbGoodPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbGoodCount;

- (void)setData:(OrderDetail *)orderDetail;

@end
