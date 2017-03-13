//
//  ShoppingCartTableViewCell.h
//  shopping
//
//  Created by chentao on 15/12/9.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartDetail.h"
#import "ColorTool.h"
#import "Protocol.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShoppingCartTableViewCell : UITableViewCell

@property (nonatomic, retain) id<ShoppingCartCellDelegate> delegate;

@property (nonatomic, retain) ShoppingCartDetail *shoppingCartDetail;

@property (weak, nonatomic) IBOutlet UIImageView *imaGood;
@property (weak, nonatomic) IBOutlet UILabel *lbGoodName;
@property (weak, nonatomic) IBOutlet UILabel *lbGoodPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbNumber;
@property (weak, nonatomic) IBOutlet UIImageView *imaCheckBox;

- (IBAction)btnAddClick:(UIButton *)sender;
- (IBAction)btnCutClick:(UIButton *)sender;
- (IBAction)btnSelectClick:(UIButton *)sender;
- (IBAction)btnGoodImageClick:(UIButton *)sender;

- (void)setData:(ShoppingCartDetail*)shoppingCartDetail;

@end
