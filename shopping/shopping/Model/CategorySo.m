//
//  CategorySo.m
//  shopping
//
//  Created by chentao on 15/12/21.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "CategorySo.h"

@implementation CategorySo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"parentId":@"parentId"};
}

+ (NSDictionary*)toDictionary:(CategorySo*)categorySo {
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:categorySo error:&error];
    
    return dic;
}

@end
