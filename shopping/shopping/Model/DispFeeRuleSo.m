//
//  DispFeeRuleSo.m
//  shopping
//
//  Created by chentao on 15/12/8.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "DispFeeRuleSo.h"

@implementation DispFeeRuleSo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSDictionary*)toDictionary:(DispFeeRuleSo*)dispFeeRuleSo {
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:dispFeeRuleSo error:&error];
    
    return dic;
}

@end
