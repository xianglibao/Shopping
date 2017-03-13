//
//  AlipaySignSo.m
//  shopping
//
//  Created by chentao on 16/1/10.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "AlipaySignSo.h"

@implementation AlipaySignSo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"userId":@"userId",
             @"orderNo":@"orderNo",
             @"udf1":@"udf1"};
}

+ (NSDictionary*)toDictionary:(AlipaySignSo*)alipaySignSo {
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:alipaySignSo error:&error];
    
    return dic;
}

@end
