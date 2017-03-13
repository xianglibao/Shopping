//
//  NetConfig.h
//  shopping
//
//  Created by chentao on 15/12/14.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetConfig : NSObject

#pragma mark - 用户管理

+ (NSString *)getSignUpUrl;

+ (NSString *)getLoginUrl;

+ (NSString *)getSearchUserUrl;

+ (NSString *)getSendSignCodeUrl;

+ (NSString *)getUpdateUserUrl;

#pragma mark - 地址管理

+ (NSString *)getAddressCreateUrl;

+ (NSString *)getAddressUpdateUrl;

+ (NSString *)getAddressSearchUrl;

+ (NSString *)getAddressDeleteUrl;

#pragma mark - 商品展示

+ (NSString *)getFetchGoodListUrl;

+ (NSString *)getFetchAllCategoryUrl;

+ (NSString *)getSearchGoodUrl;

+ (NSString *)getFetchGoodByIdUrl;

#pragma mark - 订单管理

+ (NSString *)getFetchOrderListUrl;

+ (NSString *)getSearchOrderDetailUrl;

+ (NSString *)getCalcOrderFeeUrl;

+ (NSString *)getSubmitOrderUrl;

+ (NSString *)getSignForAlipay;

+ (NSString *)getSubmitPayResultUrl;

+ (NSString *)getCancelOrderUrl;

+ (NSString *)getSignForWeixinUrl;

+ (NSString *)getReceiveGoodUrl;

#pragma mark - 基础服务

+ (NSString *)getFeedBackUrl;

+ (NSString *)getServicePhoneUrl;

@end
