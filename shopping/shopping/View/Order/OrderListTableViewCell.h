//
//  OrderListTableViewCell.h
//  shopping
//
//  Created by chentao on 15/12/1.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderHeader.h"
#import "DateTool.h"
#import "ColorTool.h"

@interface OrderListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbTotalCount;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderTime;
@property (weak, nonatomic) IBOutlet UILabel *lbPayType;

- (void)setData:(OrderHeader*)orderHeader;

@end
