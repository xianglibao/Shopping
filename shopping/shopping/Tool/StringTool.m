//
//  Tools.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "StringTool.h"

@implementation StringTool

+ (NSString*) StringTrim:(NSString*) str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)stringFuzzyMatch:(NSString*)src searchString:(NSString*)strSearch {
    if (src == nil || strSearch == nil) {
        return NO;
    }
    
    if ([src rangeOfString:strSearch options:NSCaseInsensitiveSearch].location != NSNotFound) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isPriceMatch:(NSString *)str {
    NSString *regex = @"^\\d+(\\.[\\d]{1,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:str]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isRealNumber:(NSString*)str {
    NSString *regex = @"^[-+]?\\d+(\\.\\d+)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:str]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isPasswordNum:(NSString*)str {
    NSString *regex = @"^\\d{6}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:str]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isLegalPhoneNumber:(NSString*)str {
    NSString *regex = @"^(1\\d{10}|0\\d{2,3}[1-9]\\d{6,7}|[1-9]\\d{6,7}|400\\d{6,7})$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:str]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isLegalMobilePhone:(NSString*)str {
    NSString *regex = @"^1\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:str]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isLegalEmail:(NSString*)str {
    NSString *regex = @"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:str]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isLegalChar:(NSString*)str {
    for (int i = 0; i < [str length]; i++) {
        unichar c = [str characterAtIndex:i];
        if (c == 0x9 || c == 0xA || c == 0xD
            || (c >= 0x20 && c <= 0xD7FF)
            || (c >= 0xE000 && c <= 0xFFFD)) {
            continue;
        } else {
            return false;
        }
    }
    
    return true;
}

+ (NSString *)removeRedundantZero:(NSString *)str
{
    long long length = str.length;
    BOOL isRemoveMode = YES;
    NSInteger removeCount = 0;
    
    for (long long i = length - 1; i >= 0; i--) {
        unichar c = [str characterAtIndex:i];
        if (c == '0') {
            if (isRemoveMode) {
                removeCount ++;
            }
        } else if (c == '.') {
            if (isRemoveMode) {
                removeCount ++;
                isRemoveMode = NO;
            }
        } else {
            isRemoveMode = NO;
        }
    }
    
    NSString *result = [str substringToIndex:length - removeCount];
    
    return result;
}

@end
