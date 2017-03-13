//
//  Feedback.h
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

@interface Feedback : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSNumber *userId;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) NSString *content;

+ (NSDictionary*)toDictionary:(Feedback*)feedback;
+ (NSArray *)toModelListByJsonArray:(NSArray *)data;

@end
