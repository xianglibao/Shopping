//
//  User.h
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

@interface AppUser : MTLModel <MTLJSONSerializing>

//用户id
@property (nonatomic, retain) NSNumber *userId;

@property (nonatomic, assign) NSInteger lockVersion;

//手机号码
@property (nonatomic, retain) NSString *phoneNumber;

//姓名
@property (nonatomic, retain) NSString *userName;

//称谓
@property (nonatomic, retain) NSString *gender;

//短信注册码
@property (nonatomic, retain) NSString *signCode;

//密码
@property (nonatomic, retain) NSString *password;

//服务端token
@property (nonatomic, retain) NSString *token;

//用户类型
@property (nonatomic, retain) NSString *type;

+ (NSString *)toJson:(AppUser*)user;
+ (NSDictionary*)toDictionary:(AppUser*)user;
+ (AppUser *)toModel:(NSString *)str;
+ (NSArray *)toModelListByJsonArray:(NSArray *)data;

@end
