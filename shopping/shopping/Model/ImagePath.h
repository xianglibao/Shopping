//
//  ImagePath.h
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

@interface ImagePath : MTLModel <MTLJSONSerializing>

//表类型
@property (nonatomic, assign) NSInteger type;

//关联id
@property (nonatomic, assign) long long boId;

//地址
@property (nonatomic, retain) NSString *imagePath;

@end
