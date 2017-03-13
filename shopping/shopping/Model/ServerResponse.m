//
//  ServerResponse.m
//  shopping
//
//  Created by chentao on 15/12/16.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "ServerResponse.h"

@implementation ServerResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"success":@"success",
             @"msgCode":@"msgCode",
             @"msgContent":@"msgContent",
             @"voList":@"voList",
             @"length":@"length"};
}

+ (ServerResponse*)toModel:(NSData *)data {
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    ServerResponse *model = [MTLJSONAdapter modelOfClass:ServerResponse.class fromJSONDictionary:dic error:&error];
    return model;
}

@end
