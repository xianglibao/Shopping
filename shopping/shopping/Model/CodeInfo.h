//
//  CodeInfo.h
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

@interface CodeInfo : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSString *typeCode;
@property (nonatomic, retain) NSString *typeName;
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *val;
@property (nonatomic, retain) NSString *remark;

+ (NSArray *)toModelListByJsonArray:(NSArray *)data;

+ (CodeInfo *)toModel:(NSString *)str;

@end
