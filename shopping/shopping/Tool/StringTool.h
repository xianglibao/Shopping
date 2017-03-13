//
//  Tools.h
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringTool : NSObject

+(NSString*) StringTrim:(NSString*) str;
+(BOOL)stringFuzzyMatch:(NSString*)src searchString:(NSString*)strSearch;
+(BOOL)isRealNumber:(NSString*)str;
+(BOOL)isLegalChar:(NSString*)str;
+(BOOL)isLegalPhoneNumber:(NSString*)str;
+(BOOL)isLegalMobilePhone:(NSString*)str;
+(BOOL)isLegalEmail:(NSString*)str;
+(BOOL)isPasswordNum:(NSString*)str;//6位纯数字
+(BOOL)isPriceMatch:(NSString *)str;//金额
+ (NSString *)removeRedundantZero:(NSString *)str;

@end