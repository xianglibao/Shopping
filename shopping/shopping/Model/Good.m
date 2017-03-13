//
//  Good.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "Good.h"

@implementation Good

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"goodId":@"id",
             @"name":@"name",
             @"goodDescription":@"description",
             @"price":@"price",
             @"showPrice":@"showedPrice",
             @"weight":@"weight",
             @"maxBuy":@"maxBuy",
             @"categoryId":@"categoryId",
             @"categoryName":@"categoryName",
             @"categoryIdTree":@"categoryIdTree",
             @"imagePathBig":@"imagePathBig",
             @"imagePathMiddle":@"imagePathMiddle",
             @"imagePathSmall":@"imagePathSmall",
             @"status":@"status",
             @"stockCount":@"stockCount",
             @"promotionType":@"promotionType",
             @"salesCount":@"salesCount",
             @"discount":@"discount"};
}

+ (NSArray *)toModelListByJsonArray:(NSArray *)data
{
    NSError *error;
    NSArray *resultlist = [MTLJSONAdapter modelsOfClass:Good.class fromJSONArray:data error:&error];
    
    return resultlist;
}

@end
