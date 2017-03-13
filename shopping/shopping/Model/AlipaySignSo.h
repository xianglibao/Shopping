//
//  AlipaySignSo.h
//  shopping
//
//  Created by chentao on 16/1/10.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@interface AlipaySignSo : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSNumber *userId;
@property (nonatomic, retain) NSString *orderNo;

@property (nonatomic, retain) NSString *udf1;

+ (NSDictionary*)toDictionary:(AlipaySignSo*)alipaySignSo;

@end
