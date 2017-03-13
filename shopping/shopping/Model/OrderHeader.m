//
//  Order.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "OrderHeader.h"

@implementation OrderHeader

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"orderId":@"id",
             @"createdTime":@"createdTime",
             @"lockVersion":@"lockVersion",
             @"orderNo":@"orderNo",
             @"userId":@"userId",
             @"userName":@"userName",
             @"phoneNumber":@"phoneNumber",
             @"address":@"address",
             @"deliveryTime":@"deliveryTime",
             @"paymentType":@"paymentType",
             @"remark":@"remark",
             @"totalAmount":@"totalAmount",
             @"totalPrice":@"totalPrice",
             @"totalWeight":@"totalWeight",
             @"deliveryPrice":@"deliveryPrice",
             @"firstOrderDiscountPrice":@"firstOrderDiscountPrice",
             @"paidPrice":@"paidPrice",
             @"status":@"status",
             @"orderDetailVoList":@"orderDetailVoList"};
}

+ (NSValueTransformer *)orderDetailVoListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:OrderDetail.class];
}

+ (NSArray *)toModelListByJsonArray:(NSArray *)data
{
    NSError *error;
    NSArray *resultlist = [MTLJSONAdapter modelsOfClass:OrderHeader.class fromJSONArray:data error:&error];
    
    return resultlist;
}

+ (NSDictionary*)toDictionary:(OrderHeader*)orderHeader
{
    NSError *error = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:orderHeader error:&error];
    
    return dic;
}

@end
