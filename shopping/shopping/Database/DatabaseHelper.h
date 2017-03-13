//
//  DatabaseHelper.h
//  shopping
//
//  Created by chentao on 15/12/16.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "ShoppingCartDao.h"

@interface DatabaseHelper : NSObject

+ (FMDatabase *)getInstance;
+ (void)deleteDatabase;
+ (BOOL)dropTable:(NSString *)tableName;

@end
