//
//  CodeSo.h
//  shopping
//
//  Created by chentao on 16/2/22.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@interface CodeSo : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSString *typeCode;
@property (nonatomic, retain) NSString *code;

+ (NSDictionary*)toDictionary:(CodeSo*)codeSo;

@end
