//
//  Address.h
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

@interface Address : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSNumber *userId;

//地址Id
@property (nonatomic, retain) NSNumber *addressId;

//乐观锁
@property (nonatomic, retain) NSNumber *lockVersion;

//收货人，默认登陆用户
@property (nonatomic, retain) NSString *userName;

//手机号，默认登陆用户
@property (nonatomic, retain) NSString *phoneNumber;

//地址
@property (nonatomic, retain) NSString *address;

//门牌号
@property (nonatomic, retain) NSString *houseNo;

+ (NSDictionary*)toDictionary:(Address*)address;

+ (NSArray *)toModelListByJsonArray:(NSArray *)data;

@end
