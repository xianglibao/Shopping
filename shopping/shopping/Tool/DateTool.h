//
//  DateTool.h
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTool : NSObject

+(NSString *)toString:(NSDate *)date;

+ (NSDate *)toDate:(NSString *)data;

+(NSDateFormatter *)getCommonFormattter;

+(NSString*)getCurrentDateFormatterString;

+(NSString *)getFormatterTrankResultString:(NSDate*)date;

+(NSString *)getFormatterString:(NSDate *)date;

+(NSDate *)getFormatterDate:(NSString *)str;

+(NSString*)getStringFromDate:(NSDate*)date format:(NSString*)formatStr;

+(NSDate*)getDateFromString:(NSString*)str format:(NSString*)formatStr;

@end
