//
//  CodeSo.m
//  shopping
//
//  Created by chentao on 16/2/22.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "CodeSo.h"

@implementation CodeSo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"typeCode":@"typeCode",
             @"code":@"code"};
}

+ (NSDictionary*)toDictionary:(CodeSo*)codeSo
{
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:codeSo error:&error];
    
    return dic;
}

@end
