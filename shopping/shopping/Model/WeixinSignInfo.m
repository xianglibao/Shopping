//
//  WeixinSignInfo.m
//  shopping
//
//  Created by chentao on 16/1/27.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "WeixinSignInfo.h"

@implementation WeixinSignInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"package":@"package",
             @"appId":@"appid",
             @"sign":@"sign",
             @"partnerid":@"partnerid",
             @"prepayid":@"prepayid",
             @"noncestr":@"noncestr",
             @"timestamp":@"timestamp"};
}

+ (NSArray *)toModelListByJsonArray:(NSArray *)data
{
    NSError *error;
    NSArray *resultlist = [MTLJSONAdapter modelsOfClass:WeixinSignInfo.class fromJSONArray:data error:&error];
    
    return resultlist;
}

+ (WeixinSignInfo *)toModel:(NSString *)str
{
    NSError *error;
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    WeixinSignInfo *result = [MTLJSONAdapter modelOfClass:WeixinSignInfo.class fromJSONDictionary:dic error:&error];
    
    return result;
}

@end
