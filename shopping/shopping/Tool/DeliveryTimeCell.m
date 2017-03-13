//
//  DeliveryTimeCell.m
//  shopping
//
//  Created by chentao on 16/1/18.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "DeliveryTimeCell.h"

@interface DeliveryTimeCell ()

@property (nonatomic, retain) UILabel *lbDay;
@property (nonatomic, retain) UILabel *lbTime;

@end

@implementation DeliveryTimeCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _lbDay = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, 100, 30)];
        _lbDay.font = [UIFont systemFontOfSize:13];
        _lbDay.textColor = [UIColor darkGrayColor];
        
        _lbTime = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-276, 5, 200, 30)];
        _lbTime.font = [UIFont systemFontOfSize:13];
        _lbTime.textAlignment = NSTextAlignmentRight;
        _lbTime.textColor = [UIColor darkGrayColor];
        
        [self addSubview:_lbDay];
        [self addSubview:_lbTime];
    }
    return self;
}

- (void)setData:(DeliveryTimeInfo *)deliveryTime
{
    _lbDay.text = deliveryTime.day;
    if ([_lbDay.text isEqualToString:@"今天"]) {
        _lbDay.textColor = [ColorTool getGreenTextColor];
    } else {
        _lbDay.textColor = [ColorTool getBlueColor];
    }
    _lbTime.text = deliveryTime.time;
}

@end
