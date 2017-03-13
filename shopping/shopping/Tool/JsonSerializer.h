//
//  JsonSerializer.h
//  shopping
//
//  Created by chentao on 15/11/30.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonSerializer : NSObject

+(NSString *)toJsonByString:(NSString *)string;

//date转json
+(NSString *)toJsonByDate:(NSDate*)date;

// 从NsData转换为NSDictionary
+(id)toObjectFormData:(NSData*)nsData;

+(NSData*)String2Data:(NSString*)str;

+(NSString *)jsonStringWithArray:(NSArray *)array;

@end
