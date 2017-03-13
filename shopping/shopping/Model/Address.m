//
//  Address.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "Address.h"

@implementation Address

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"userId":@"userId",
             @"addressId":@"id",
             @"lockVersion":@"lockVersion",
             @"userName":@"userName",
             @"phoneNumber":@"phoneNumber",
             @"address":@"address",
             @"houseNo":@"houseNo"};
}

+ (NSString*)toJson:(Address*)user
{
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:user error:&error];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithBytes:[data bytes] length:data.length encoding:NSUTF8StringEncoding];
    
    return json;
}

+ (NSDictionary*)toDictionary:(Address*)address
{
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:address error:&error];
    
    return dic;
}

+ (NSArray *)toModelListByJsonArray:(NSArray *)data
{
    NSError *error;
    NSArray *resultlist = [MTLJSONAdapter modelsOfClass:Address.class fromJSONArray:data error:&error];

    return resultlist;
}

//
//+ (NSArray *)toModelList:(NSData *)data {
//    NSError *error;
//    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    NSArray *resultlist = [MTLJSONAdapter modelsOfClass:MenuInfo.class fromJSONArray:array error:&error];
//
//    return resultlist;
//}

@end
