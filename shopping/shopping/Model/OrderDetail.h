//
//  OrderDetail.h
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@interface OrderDetail : MTLModel <MTLJSONSerializing>

//订单号
@property (nonatomic, retain) NSString *orderNo;

//货物id
@property (nonatomic, retain) NSNumber *goodId;

//货物名称
@property (nonatomic, retain) NSString *goodName;

//数量
@property (nonatomic, assign) double amount;

//单价
@property (nonatomic, assign) double price;

//金额
@property (nonatomic, assign) double totalPrice;

@property (nonatomic, retain) NSArray *imagePathBig;

@end
