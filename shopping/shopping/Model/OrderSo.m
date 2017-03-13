//
//  OrderSo.m
//  shopping
//
//  Created by chentao on 15/12/8.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "OrderSo.h"

@implementation OrderSo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"userId":@"userId",
             @"status":@"status",
             @"orderNo":@"orderNo"};
}

+ (NSDictionary*)toDictionary:(OrderSo*)orderSo {
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:orderSo error:&error];
    
    return dic;
}

@end
