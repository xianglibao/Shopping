//
//  WeixinSignSo.m
//  shopping
//
//  Created by chentao on 16/1/27.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "WeixinSignSo.h"

@implementation WeixinSignSo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"userId":@"userId",
             @"orderNo":@"orderNo",
             @"lockVersion":@"lockVersion"};
}

+ (NSDictionary*)toDictionary:(WeixinSignSo*)weixinSignSo
{
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:weixinSignSo error:&error];
    
    return dic;
}

@end
