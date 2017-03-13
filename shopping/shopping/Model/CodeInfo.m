//
//  CodeInfo.m
//  shopping
//
//  Created by chentao on 16/2/22.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "CodeInfo.h"

@implementation CodeInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"typeCode":@"typeCode",
             @"typeName":@"typeName",
             @"code":@"code",
             @"name":@"name",
             @"val":@"val",
             @"remark":@"remark"};
}

+ (NSArray *)toModelListByJsonArray:(NSArray *)data
{
    NSError *error;
    NSArray *resultlist = [MTLJSONAdapter modelsOfClass:CodeInfo.class fromJSONArray:data error:&error];
    
    return resultlist;
}

+ (CodeInfo *)toModel:(NSString *)str
{
    NSError *error;
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    CodeInfo *result = [MTLJSONAdapter modelOfClass:CodeInfo.class fromJSONDictionary:dic error:&error];
    
    return result;
}

@end
