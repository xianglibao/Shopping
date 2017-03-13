//
//  ShoppingCartModelTransformer.m
//  shopping
//
//  Created by chentao on 15/12/23.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "ShoppingCartModelTransformer.h"

@implementation ShoppingCartModelTransformer

+ (ShoppingCartDetail*)toDbModel:(Good*)good
{
    return [self toDbModel:good count:0];
}

+ (ShoppingCartDetail*)toDbModel:(Good*)good count:(long)count
{
    ShoppingCartDetail *detail = [ShoppingCartDetail new];
    
    detail.goodId = [good.goodId longValue];
    detail.goodName = good.name;
    detail.goodPrice = [good.price doubleValue];
    detail.createTime = [NSDate date];
    if (good.imagePathBig != nil && good.imagePathBig.count > 0) {
        detail.imageUrl = good.imagePathBig[0];
    } else {
        detail.imageUrl = @"";
    }
    
    if (count == 0) {
        detail.goodCount = 1;
    } else {
        detail.goodCount = count;
    }
    
    return detail;
}

@end
