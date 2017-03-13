//
//  User.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "AppUser.h"

@implementation AppUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"userId":@"id",
             @"lockVersion":@"lockVersion",
             @"phoneNumber":@"phoneNumber",
             @"userName":@"userName",
             @"gender":@"gender",
             @"signCode":@"signCode",
             @"password":@"password",
             @"token":@"token",
             @"type":@"type"};
}

+ (NSString *)toJson:(AppUser *)user
{
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:user error:&error];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithBytes:[data bytes] length:data.length encoding:NSUTF8StringEncoding];
    
    return json;
}

+ (AppUser *)toModel:(NSString *)str
{
    NSError *error;
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    AppUser *result = [MTLJSONAdapter modelOfClass:AppUser.class fromJSONDictionary:dic error:&error];
    
    return result;
}

+ (NSArray *)toModelListByJsonArray:(NSArray *)data
{
    NSError *error;
    NSArray *resultlist = [MTLJSONAdapter modelsOfClass:AppUser.class fromJSONArray:data error:&error];
    
    return resultlist;
}

+ (NSDictionary*)toDictionary:(AppUser*)user {
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:user error:&error];
    
    return dic;
}

@end
