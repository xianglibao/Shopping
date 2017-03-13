//
//  WeixinSignInfo.h
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

@interface WeixinSignInfo : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSString *package;
@property (nonatomic, retain) NSString *appId;
@property (nonatomic, retain) NSString *sign;
@property (nonatomic, retain) NSString *partnerid;
@property (nonatomic, retain) NSString *prepayid;
@property (nonatomic, retain) NSString *noncestr;
@property (nonatomic, retain) NSString *timestamp;

+ (NSArray *)toModelListByJsonArray:(NSArray *)data;

+ (WeixinSignInfo *)toModel:(NSString *)str;

@end
