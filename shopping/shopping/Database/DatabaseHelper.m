//
//  DatabaseHelper.m
//  shopping
//
//  Created by chentao on 15/12/16.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "DatabaseHelper.h"

static NSString *const DATABASE_NAME = @"ShoppingDatabase";
static NSInteger DB_CURRENT_VERSION = 1;

#define KEY_DATABASE_VERSION @"DB_VERSION"

@implementation DatabaseHelper

+ (FMDatabase *)getInstance {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [documents stringByAppendingPathComponent:DATABASE_NAME];
    
    FMDatabase *instance = [FMDatabase databaseWithPath:dbPath];
    
    if (![self existTable:instance]) {
        [self createAllTable:instance];
    }
    
    [self updataDatabase:instance];
    
    return instance;
}

//创建表
+ (void)createAllTable:(FMDatabase *)db {
    NSLog(@"第一次使用数据库");
    
    [ShoppingCartDao createShoppingCartTable:db];
    
    //记录标记
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:DB_CURRENT_VERSION forKey:KEY_DATABASE_VERSION];
}

//版本更新
+ (void)updataDatabase:(FMDatabase *)db {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    if ([self getDataBaseVersion] < 2) {
//        if ([UpdataScript1_2 upDataScript:db]) {
//            [defaults setInteger:2 forKey:KEY_DATABASE_VERSION];
//        }
//    }
}

+ (BOOL)existTable:(FMDatabase *)db
{
    if (![db open])
    {
        NSLog(@"数据库未打开");
        return false;
    }
    
    FMResultSet *set = [db
                        executeQuery:
                        @"select count(*) as 'count' from sqlite_master where type='table' "];
    
    [set next];
    NSInteger count = [set intForColumn:@"count"];
    [db close];
    
    return count != 0;
}

+ (NSInteger)getDataBaseVersion
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger version = [defaults integerForKey:KEY_DATABASE_VERSION];
    return version;
}

+ (BOOL)dropTable:(NSString *)tableName
{
    FMDatabase *db = [[self class] getInstance];
    
    if (![db open])
    {
        NSLog(@"数据库未打开");
        return false;
    }
    
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    BOOL ret = [db executeUpdate:sqlstr];
    [db close];
    
    return ret;
}

+ (void)deleteDatabase
{
    BOOL success;
    NSError *error;
    
    FMDatabase *db = [[self class] getInstance];
    
    if (![db open])
    {
        NSLog(@"数据库未打开");
        return;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // delete the old db.
    if ([fileManager fileExistsAtPath:DATABASE_NAME])
    {
        [db close];
        success = [fileManager removeItemAtPath:DATABASE_NAME error:&error];
        if (!success)
        {
            NSAssert1(0, @"Failed to delete old database file with message '%@'.",
                      [error localizedDescription]);
        }
    }
}

@end
