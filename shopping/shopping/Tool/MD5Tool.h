//
//  MD5Tool.h
//  shopping
//
//  Created by chentao on 16/1/9.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface MD5Tool : NSObject

+ (NSString *)md5:(NSString *)str;

@end
