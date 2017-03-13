//
//  OrderDetail.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "OrderDetail.h"

@implementation OrderDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"orderNo":@"orderNo",
             @"goodId":@"goodId",
             @"goodName":@"goodName",
             @"amount":@"amount",
             @"price":@"price",
             @"totalPrice":@"totalPrice",
             @"imagePathBig":@"imagePathBig"};
}

@end
