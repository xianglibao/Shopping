//
//  ServicePhoneCell.m
//  shopping
//
//  Created by chentao on 16/2/22.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "ServicePhoneCell.h"

@interface ServicePhoneCell ()

@property (nonatomic, retain) UILabel *lbName;
@property (nonatomic, retain) UILabel *lbPhone;
@property (nonatomic, retain) UILabel *lbServiceTime;

@end

@implementation ServicePhoneCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _lbName = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 30)];
        _lbName.font = [UIFont systemFontOfSize:12];
        _lbName.textColor = [UIColor darkGrayColor];
        
        _lbPhone = [[UILabel alloc] initWithFrame:CGRectMake(16, 30, 100, 30)];
        _lbPhone.font = [UIFont systemFontOfSize:12];
        _lbPhone.textColor = [ColorTool getBlueColor];
        
        UILabel *lbtime = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-276, 0, 200, 30)];
        lbtime.font = [UIFont systemFontOfSize:12];
        lbtime.textAlignment = NSTextAlignmentRight;
        lbtime.textColor = [UIColor darkGrayColor];
        lbtime.text = @"在线时间";
        
        _lbServiceTime = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-276, 30, 200, 30)];
        _lbServiceTime.font = [UIFont systemFontOfSize:12];
        _lbServiceTime.textAlignment = NSTextAlignmentRight;
        _lbServiceTime.textColor = [UIColor orangeColor];
        
        [self addSubview:_lbName];
        [self addSubview:_lbPhone];
        [self addSubview:lbtime];
        [self addSubview:_lbServiceTime];
    }
    return self;
}

- (void)setData:(CodeInfo *)codeInfo
{
    _lbName.text = codeInfo.name;
    _lbPhone.text = codeInfo.val;
    _lbServiceTime.text = codeInfo.remark;
}

@end
