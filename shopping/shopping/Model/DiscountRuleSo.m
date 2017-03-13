//
//  DiscountRuleSo.m
//  shopping
//
//  Created by chentao on 15/12/8.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "DiscountRuleSo.h"

@implementation DiscountRuleSo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSDictionary*)toDictionary:(DiscountRuleSo*)discountRuleSo {
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:discountRuleSo error:&error];
    
    return dic;
}

@end
