//
//  ServerResponse.h
//  shopping
//
//  Created by chentao on 15/12/16.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@interface ServerResponse : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) BOOL success;
@property (nonatomic, retain) NSString *msgCode;
@property (nonatomic, retain) NSString *msgContent;
@property (nonatomic, retain) id voList;
@property (nonatomic, assign) long length;

+ (ServerResponse*)toModel:(NSData *)data;

@end
