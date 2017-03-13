//
//  AddressSo.m
//  shopping
//
//  Created by chentao on 16/1/9.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "AddressSo.h"

@implementation AddressSo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"userId":@"userId",
             @"userName":@"userName"};
}

+ (NSDictionary*)toDictionary:(AddressSo*)addressSo {
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:addressSo error:&error];
    
    return dic;
}

@end
