//
//  AddressListTableViewCell.m
//  shopping
//
//  Created by chentao on 15/11/30.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "AddressListTableViewCell.h"

@implementation AddressListTableViewCell

- (void)awakeFromNib
{
    UIImage *image = [[UIImage imageNamed:@"location"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _imaLocation.tintColor = [UIColor colorWithRed:83.0/255.0 green:160.0/255.0 blue:73.0/255.0 alpha:1.0];
    _imaLocation.image = image;
}

- (void)setData:(Address*)address
{
    _userName.text = address.userName;
    _phoneNumber.text = address.phoneNumber;
    _address.text = [NSString stringWithFormat:@"%@%@", address.address, address.houseNo];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
