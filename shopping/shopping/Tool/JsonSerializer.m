//
//  JsonSerializer.m
//  shopping
//
//  Created by chentao on 15/11/30.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "JsonSerializer.h"

@implementation JsonSerializer

+ (NSString *)jsonStringWithArray:(NSArray *)array {
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    
    for (NSString *valueObj in array) {
        NSString *value = [self toJsonByString:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@", value]];
        }
    }
    
    [reString appendFormat:@"%@", [values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    
    return reString;
}

// 从NsData转换为id
+ (id)toObjectFormData:(NSData*)nsData {
    return [NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingAllowFragments error:nil];
}

// 显示NsData的内容（通常用于调试）
+ (NSString*)Data2String:(NSData*)data {
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

+ (NSData*)String2Data:(NSString*)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

+ (NSString*)toJsonByString:(NSString*)string {
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]];
}

+ (NSString*)toJsonByDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *time = [formatter stringFromDate:date];
    
    return [self toJsonByString:time];
}

@end
