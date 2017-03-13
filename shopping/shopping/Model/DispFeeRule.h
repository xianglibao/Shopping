//
//  DispFeeRule.h
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

@interface DispFeeRule : MTLModel <MTLJSONSerializing>

//起始重量
@property (nonatomic, assign) double startWeight;

//结束重量
@property (nonatomic, assign) double endWeight;

//最小费用
@property (nonatomic, assign) double minFee;

//单位重量
@property (nonatomic, assign) double unitPrice;

@end
