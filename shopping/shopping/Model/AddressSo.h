//
//  AddressSo.h
//  shopping
//
//  Created by chentao on 16/1/9.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@interface AddressSo : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSNumber *userId;
@property (nonatomic, retain) NSString *userName;

+ (NSDictionary*)toDictionary:(AddressSo*)addressSo;

@end
