//
//  UserTool.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "UserTool.h"

#define STR_USER @"STR_USER"
#define SVCTYPE_KEY @"SERVICETYPE"
#define ACTIVETYPE_KEY @"ACTIVETYPE"
#define ACTIVEREAD_KEY @"ACTIVEREAD"

//static BOOL tokenError = false;

@implementation UserTool

+ (void)setUser:(AppUser *)user
{
    if (user == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:STR_USER];
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strObj = [AppUser toJson:user];
    [defaults setValue:strObj forKey:STR_USER];
    [defaults synchronize];
}

+ (AppUser *)getUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userstr = [defaults stringForKey:STR_USER];
    
    if (userstr == nil) {
        return nil;
    }
    
    AppUser* user = [AppUser toModel:userstr];
    
    return user;
}

+ (BOOL)isLogin
{
    AppUser *user = [self getUser];
    if (user == nil) {
        return NO;
    }
    return YES;
}

+ (void)setCurrentAddress:(NSNumber*)addressId key:(NSNumber*)userId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setValue:addressId forKey:[userId stringValue]];
}

+ (NSNumber*)getCurrentAddressType:(NSNumber*)userId;
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults valueForKey:[userId stringValue]];
}

//+(void)setisFirstActive
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSDate date] forKey:@"isFirst_KEY"];
//}
//
////当天第一次登录
//+(BOOL)getisFirstActive
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDate *lastDate=[defaults objectForKey:@"isFirst_KEY"];
//    if(lastDate==nil)
//    {
//        return YES;
//    }
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
//    NSDate *today = [cal dateFromComponents:components];
//    components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:lastDate];
//    NSDate *otherDate = [cal dateFromComponents:components];
//    
//    if(![today isEqualToDate:otherDate]) {
//        //do stuff
//        return YES;
//    }
//    //    [defaults setObject:[NSDate date] forKey:ACTIVEREAD_KEY];
//    return NO;
//}
//
//+(void)setisReadActive
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSDate date] forKey:ACTIVEREAD_KEY];
//}
//
////当天是否已读
//+(BOOL)getisReadActive
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDate *lastDate=[defaults objectForKey:ACTIVEREAD_KEY];
//    if(lastDate==nil)
//    {
//        return NO;
//    }
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
//    NSDate *today = [cal dateFromComponents:components];
//    components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:lastDate];
//    NSDate *otherDate = [cal dateFromComponents:components];
//    
//    if([today isEqualToDate:otherDate]) {
//        //do stuff
//        return YES;
//    }
//    //    [defaults setObject:[NSDate date] forKey:ACTIVEREAD_KEY];
//    return NO;
//}
//
//+(void)setAlipayAccountStatus:(NSNumber *)status
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:status forKey:@"AlipayAccountStatus_KEY"];
//}
//
//+(NSNumber*)getAlipayAccountStatus
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults objectForKey:@"AlipayAccountStatus_KEY"];
//    //    [defaults setObject:status forKey:@"AlipayAccountStatus_KEY"];
//    
//}
//
//+(void)setWalletId:(NSString *)userId
//{
//    if (userId==nil||userId.length==0) {
//        return;
//    }
//    NSString *walletIdKey=[self getUser].hsuserguid;
//    if (walletIdKey!=nil) {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:userId forKey:walletIdKey];
//    }
//}
//
//+(BOOL)getHasWalletId
//{
//    NSString *walletIdKey=[self getUser].hsuserguid;
//    if (walletIdKey==nil||walletIdKey.length==0) {
//        return NO;
//    }
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *value=[defaults objectForKey:walletIdKey];
//    if (value==nil||value.length==0) {
//        return NO;
//    }
//    return YES;
//}
//
//+(void)setSignerList:(NSMutableArray*)nameList
//{
//    NSString *signNameKey=[NSString stringWithFormat:@"%@SignNameKey",[self getUser].userCode];
//    
//    NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
//    
//    
//    if (nameList==nil||nameList.count==0) {
//        
//        [defaults removeObjectForKey:signNameKey];
//        return;
//    }
//    //    if ([self getUser]==nil) {
//    //        return;
//    //    }
//    [defaults setObject:nameList forKey:signNameKey];
//    [defaults synchronize];
//    
//}
//
//+(NSMutableArray*)getSignerList
//{
//    if ([self getUser]==nil) {
//        return nil;
//    }
//    NSString *signNameKey=[NSString stringWithFormat:@"%@SignNameKey",[self getUser].userCode];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *nameList=[defaults mutableArrayValueForKey:signNameKey];
//    return nameList;
//}
//
@end
