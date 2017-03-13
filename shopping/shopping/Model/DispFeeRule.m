//
//  DispFeeRule.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "DispFeeRule.h"

@implementation DispFeeRule

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"startWeight":@"startWeight",
             @"endWeight":@"endWeight",
             @"minFee":@"minFee",
             @"unitPrice":@"unitPrice"};
}

@end
