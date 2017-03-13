//
//  DateTool.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "DateTool.h"

#define FORMAT_COMMON @"yyyy-MM-dd'T'HH:mm:ssZZZZZ"
#define FORMAT @"yyyy/MM/dd HH:mm:ss"

@implementation DateTool

static NSArray *formatPatterns;

+ (NSArray *)getPatterns {
    if (formatPatterns == nil) {
        formatPatterns= [NSArray arrayWithObjects:
                         @"yyyy-MM-dd'T'HH:mm:ss.SSS",
                         @"yyyy-MM-dd'T'HH:mm:ss",
                         @"yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                         @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
                         @"yyyy/MM/dd HH:mm:ss",
                         nil];
    }
    return formatPatterns;
}

+ (NSDate *)toDate:(NSString *)data {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    for (NSString *pattern in [DateTool getPatterns]) {
        @try {
            formatter.dateFormat = pattern;
            NSDate *result = [formatter dateFromString:data];
            if(result !=nil)
                return result;
        }
        @catch (NSException *exception) {
            //do nothing, run next
        }
        @finally {
            
        }
    }
    return nil;
}

+ (NSString *)toString:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    
    return [formatter stringFromDate:date];
}

+ (NSDateFormatter *)getCommonFormattter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:FORMAT_COMMON];
    
    return formatter;
}

+ (NSDateFormatter*)getFormatter:(NSString*)strFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:strFormat];
    
    return formatter;
}

+ (NSString*)getCurrentDateFormatterString {
    NSDate *today = [NSDate date];
    NSString *scantime = [[self getCommonFormattter] stringFromDate:today];
    
    return scantime;
}

+ (NSString *)getFormatterTrankResultString:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:FORMAT];
    NSString *strtime = [formatter stringFromDate:date];
    
    return strtime;
}

+ (NSString *)getFormatterString:(NSDate *)date {
    NSString *scantime = [self.getCommonFormattter stringFromDate:date];
    
    return scantime;
}

+ (NSString*)getStringFromDate:(NSDate*)date format:(NSString*)formatStr {
    NSString *scantime = [[self getFormatter:formatStr] stringFromDate:date];
    
    return scantime;
}

+ (NSDate*)getDateFromString:(NSString*)str format:(NSString*)formatStr {
    NSDate *scantime = [[self getFormatter:formatStr] dateFromString:str];
    
    return scantime;
}

+ (NSDate *)getFormatterDate:(NSString *)str {
    NSDate *date = [self.getCommonFormattter dateFromString:str];
    
    return date;
}

@end
