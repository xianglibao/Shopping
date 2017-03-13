//
//  Feedback.m
//  shopping
//
//  Created by chentao on 15/12/8.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "Feedback.h"

@implementation Feedback

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"userId":@"userId",
             @"userName":@"userName",
             @"phoneNumber":@"phoneNumber",
             @"content":@"content"};
}

+ (NSDictionary*)toDictionary:(Feedback*)feedback {
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:feedback error:&error];
    
    return dic;
}

+ (NSArray *)toModelListByJsonArray:(NSArray *)data
{
    NSError *error;
    NSArray *resultlist = [MTLJSONAdapter modelsOfClass:Feedback.class fromJSONArray:data error:&error];
    
    return resultlist;
}

@end
