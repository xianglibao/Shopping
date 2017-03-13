//
//  NetConfig.m
//  shopping
//
//  Created by chentao on 15/12/14.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "NetConfig.h"

@implementation NetConfig

+ (NSString*)SvcBaseUrl
{
    return @"http://121.40.211.32/spmk-war/rest/app/";
}

#pragma mark - 用户管理

+ (NSString *)getSignUpUrl
{
    NSString *url = @"user/sign_up";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getLoginUrl
{
    NSString *url = @"user/login";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getSearchUserUrl
{
    NSString *url = @"user/get_by_id";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getSendSignCodeUrl {
    NSString *url = @"user/send_sign_code";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getUpdateUserUrl {
    NSString *url = @"user/update";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

#pragma mark - 地址管理

+ (NSString *)getAddressCreateUrl
{
    NSString *url = @"address/create";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getAddressUpdateUrl
{
    NSString *url = @"address/update";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getAddressSearchUrl
{
    NSString *url = @"address/search_by_so";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getAddressDeleteUrl {
    NSString *url = @"address/delete";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

#pragma mark - 商品展示

+ (NSString *)getFetchGoodListUrl
{
    NSString *url = @"good/show_category_of_good_list";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getFetchAllCategoryUrl
{
    NSString *url = @"good/show_all_category_list";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getSearchGoodUrl {
    NSString *url = @"good/search_by_so";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getFetchGoodByIdUrl
{
    NSString *url = @"good/get_by_id";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

#pragma mark - 订单管理

+ (NSString *)getFetchOrderListUrl
{
    NSString *url = @"order/search";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getSearchOrderDetailUrl
{
    NSString *url = @"order/search_order_detail";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getCalcOrderFeeUrl
{
    NSString *url = @"order/calc_fee";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getSubmitOrderUrl
{
    NSString *url = @"order/submit";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getSignForAlipay
{
    NSString *url = @"payment/sign_for_alipay";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getSubmitPayResultUrl
{
    NSString *url = @"payment/update_payment_type";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getCancelOrderUrl
{
    NSString *url = @"payment/withdraw_order";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getSignForWeixinUrl
{
    NSString *url = @"payment/sign_for_wxpay";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getReceiveGoodUrl
{
    NSString *url = @"payment/accept_order";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

#pragma mark - 基础服务

+ (NSString *)getFeedBackUrl
{
    NSString *url = @"feedback/create";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

+ (NSString *)getServicePhoneUrl
{
    NSString *url = @"code_info/search_by_so";
    return [NSString stringWithFormat:@"%@%@", [self SvcBaseUrl], url];
}

@end
