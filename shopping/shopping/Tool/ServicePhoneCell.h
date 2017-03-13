//
//  ServicePhoneCell.h
//  shopping
//
//  Created by chentao on 16/2/22.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"
#import "CodeInfo.h"
#import "ColorTool.h"

@interface ServicePhoneCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setData:(CodeInfo *)codeInfo;

@end
