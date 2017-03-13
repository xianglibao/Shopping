//
//  ShoppingCartDao.h
//  shopping
//
//  Created by chentao on 15/12/16.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingCartDetail.h"
#import "DatabaseHelper.h"
#import "Good.h"

@interface ShoppingCartDao : NSObject

+ (BOOL)createShoppingCartTable:(FMDatabase *)db;

+ (BOOL)insertList:(NSArray *)list;

+ (ShoppingCartDetail *)selectByID:(NSInteger)cid;

+ (BOOL)delete:(ShoppingCartDetail *)model;

+ (BOOL)deleteAll;

+ (NSArray*)selectAll;

+ (BOOL)addGood:(ShoppingCartDetail*)detail;

+ (long)getTotalCount;

+ (BOOL)update:(ShoppingCartDetail*)model;

@end
