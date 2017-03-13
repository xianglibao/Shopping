//
//  Payment.h
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

@interface Payment : MTLModel <MTLJSONSerializing>

//订单号
@property (nonatomic, retain) NSString *orderNo;

//支付类型
@property (nonatomic, assign) NSInteger paymentType;

//支付金额
@property (nonatomic, assign) double totalMoney;

//支付结果
@property (nonatomic, assign) NSInteger status;

@end
