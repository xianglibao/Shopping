//
//  GoodService.h
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "JsonSerializer.h"
#import "ServiceHelper.h"
#import "AppUser.h"
#import "GoodSo.h"
#import "NetConfig.h"
#import "CategorySo.h"
#import "ServerResponse.h"
#import "CategoryInfo.h"

@interface GoodService : NSObject

+ (void)fetchGoodList:(CategorySo*)categorySo
            onSuccess:(void (^)(NSArray *categoryInfoList))onSuccess
               onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)FetchAllCategory:(CategorySo*)categorySo
               onSuccess:(void (^)(NSArray *categoryInfoList))onSuccess
                  onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)searchGood:(GoodSo*)goodSo
         onSuccess:(void (^)(NSArray *goodList))onSuccess
            onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

+ (void)getGoodById:(long)goodId
          onSuccess:(void (^)(Good *good))onSuccess
             onFail:(void (^)(NSString *error, NSInteger statusCode))onFail;

@end
