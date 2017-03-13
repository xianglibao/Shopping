//
//  UserSo.m
//  shopping
//
//  Created by chentao on 15/12/8.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "UserSo.h"

@implementation UserSo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSDictionary*)toDictionary:(UserSo*)userSo {
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:userSo error:&error];
    
    return dic;
}

@end
