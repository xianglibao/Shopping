//
//  Order.h
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
#import "OrderDetail.h"
#import "DateTool.h"

@interface OrderHeader : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSNumber *orderId;

//订单创建时间
@property (nonatomic, retain) NSNumber *createdTime;

//
@property (nonatomic, retain) NSNumber *lockVersion;

//订单号
@property (nonatomic, retain) NSString *orderNo;

//用户Id
@property (nonatomic, retain) NSNumber *userId;

//收货人
@property (nonatomic, retain) NSString *userName;

//收货人手机
@property (nonatomic, retain) NSString *phoneNumber;

//收货地址
@property (nonatomic, retain) NSString *address;

//配送时间
@property (nonatomic, retain) NSString *deliveryTime;

//支付方式
@property (nonatomic, retain) NSString *paymentType;

//备注说明
@property (nonatomic, retain) NSString *remark;

//总数量
@property (nonatomic, assign) double totalAmount;

//商品总价格
@property (nonatomic, assign) double totalPrice;

//总重量
@property (nonatomic, assign) double totalWeight;

//配送费用`
@property (nonatomic, assign) double deliveryPrice;

//首单减免金额
@property (nonatomic, assign) double firstOrderDiscountPrice;

//支付总金额
@property (nonatomic, assign) double paidPrice;

//订单状态
@property (nonatomic, retain) NSString *status;

//订单明细
@property (nonatomic, retain) NSMutableArray *orderDetailVoList;

+ (NSArray *)toModelListByJsonArray:(NSArray *)data;

+ (NSDictionary*)toDictionary:(OrderHeader*)orderHeader;

@end
