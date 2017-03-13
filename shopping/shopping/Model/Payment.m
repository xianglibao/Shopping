//
//  Payment.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "Payment.h"

@implementation Payment

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"orderNo":@"orderNo",
             @"paymentType":@"paymentType",
             @"totalMoney":@"totalMoney",
             @"status":@"status"};
}

@end
