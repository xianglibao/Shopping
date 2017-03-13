//
//  OrderSo.h
//  shopping
//
//  Created by chentao on 15/12/8.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@interface OrderSo : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSNumber *userId;
@property (nonatomic, retain) NSNumber *status;
@property (nonatomic, retain) NSString *orderNo;

+ (NSDictionary*)toDictionary:(OrderSo*)orderSo;

@end
