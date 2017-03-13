//
//  PlaceOrderGoodDetailTableViewCell.h
//  shopping
//
//  Created by chentao on 16/1/4.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetail.h"
#import "ShoppingCartDetail.h"

@interface PlaceOrderGoodDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbGoodName;
@property (weak, nonatomic) IBOutlet UILabel *lbGoodPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbGoodCount;

- (void)setData:(ShoppingCartDetail*)shoppingCartDetail;

@end
