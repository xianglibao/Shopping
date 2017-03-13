//
//  WeixinSignSo.h
//  shopping
//
//  Created by chentao on 16/1/27.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@interface WeixinSignSo : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSNumber *userId;
@property (nonatomic, retain) NSString *orderNo;
@property (nonatomic, retain) NSNumber *lockVersion;

+ (NSDictionary*)toDictionary:(WeixinSignSo*)weixinSignSo;

@end
