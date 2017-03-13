//
//  GoodSo.h
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

@interface GoodSo : MTLModel <MTLJSONSerializing>

//名称
@property (nonatomic, retain) NSString *name;

+ (NSDictionary*)toDictionary:(GoodSo*)goodSo;

@end
