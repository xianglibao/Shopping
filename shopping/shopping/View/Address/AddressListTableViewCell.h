//
//  AddressListTableViewCell.h
//  shopping
//
//  Created by chentao on 15/11/30.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"

@interface AddressListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIImageView *imaLocation;

- (void)setData:(Address*)address;

@end
