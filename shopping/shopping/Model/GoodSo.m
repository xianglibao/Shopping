//
//  GoodSo.m
//  shopping
//
//  Created by chentao on 15/12/8.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "GoodSo.h"

@implementation GoodSo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"name":@"name"};
}

+ (NSDictionary*)toDictionary:(GoodSo*)goodSo {
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:goodSo error:&error];
    
    return dic;
}

@end
