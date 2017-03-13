//
//  ShoppingCartDao.m
//  shopping
//
//  Created by chentao on 15/12/16.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "ShoppingCartDao.h"

@implementation ShoppingCartDao

+ (BOOL)createShoppingCartTable:(FMDatabase *)db
{
    if (![db open]) {
        NSLog(@"数据库未打开");
        return false;
    }
    
    NSString *strSql = @"create table if not exists "
    "ShoppingCartTable("
    "cid integer primary key AUTOINCREMENT, "
    "goodId integer, "
    "goodName text, "
    "goodPrice real, "
    "goodCount integer, "
    "isSelected BOOL, "
    "imageUrl text, "
    "createTime date)";
    
    BOOL ret = [db executeUpdate:strSql];
    [db close];
    
    return ret;
}

+ (ShoppingCartDetail *)toShoppingCartDetail:(FMResultSet *)set
{
    ShoppingCartDetail *model = [ShoppingCartDetail new];
    
    model.cid = [set longForColumn:@"cid"];
    model.goodId = [set longForColumn:@"goodId"];
    model.goodName = [set stringForColumn:@"goodName"];
    model.goodPrice = [set doubleForColumn:@"goodPrice"];
    model.goodCount = [set longForColumn:@"goodCount"];
    model.isSelected = [set boolForColumn:@"isSelected"];
    model.createTime = [set dateForColumn:@"createTime"];
    model.imageUrl = [set stringForColumn:@"imageUrl"];
    
    return model;
}

+ (BOOL)insertList:(NSArray *)list
{
    if (list == nil) {
        return NO;
    }
    
    FMDatabase *db = [DatabaseHelper getInstance];
    if (![db open]) {
        NSLog(@"未打开");
        return NO;
    }
    
    [db beginTransaction];
    BOOL commit = NO;
    
    for (ShoppingCartDetail *model in list) {
        commit = [self insertShoppingCartTable:db shoppingCart:model];
        if (!commit) {
            break;
        }
    }
    
    if (commit) {
        [db commit];
    } else {
        [db rollback];
    }
    
    [db close];
    return commit;
}

+ (BOOL)insertShoppingCartTable:(FMDatabase *)db shoppingCart:(ShoppingCartDetail *)model
{
    model.isSelected = YES;
    
    BOOL ret = [db executeUpdate:@"INSERT INTO ShoppingCartTable (goodId, goodName, goodPrice, goodCount, isSelected, createTime, imageUrl) VALUES (?,?,?,?,?,?,?) ;", [NSNumber numberWithInteger:model.goodId], model.goodName, [NSNumber numberWithDouble:model.goodPrice], [NSNumber numberWithLong:model.goodCount], [NSNumber numberWithBool:model.isSelected], model.createTime, model.imageUrl];
    
    return ret;
}

+ (BOOL)addGood:(ShoppingCartDetail*)detail
{
    FMDatabase *db = [DatabaseHelper getInstance];
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    BOOL result = NO;
    
    FMResultSet *set = [db executeQuery:@"select * from ShoppingCartTable where goodId=? limit 1",
     [NSNumber numberWithLong:detail.goodId]];
    
    if ([set next]) {
        ShoppingCartDetail *model = [self toShoppingCartDetail:set];
        if (model != nil) {
            model.goodCount += detail.goodCount;
            result = [self update:db model:model];
            [db close];
            return result;
        }
    }
    
    result = [self insertShoppingCartTable:db shoppingCart:detail];
    
    [db close];
    return result;
}

+ (long)getTotalCount
{
    FMDatabase *db = [DatabaseHelper getInstance];
    
    if (![db open])
    {
        NSLog(@"更改数据数据库未打开");
        return false;
    }
    
    FMResultSet *rs = [db executeQuery:@"select sum(goodCount) as totalCount from ShoppingCartTable"];
    
    if ([rs next]) {
        long lastestIndex = [rs longForColumn:@"totalCount"];
        [db close];
        return lastestIndex;
    }
    
    [db close];
    return 0;
}

+ (BOOL)update:(FMDatabase*)db model:(ShoppingCartDetail*)model
{
    BOOL ret = [db executeUpdate:@"UPDATE ShoppingCartTable SET goodId=?, goodName=?, goodPrice=?, goodCount=?, isSelected=?, imageUrl=? WHERE cid=?", [NSNumber numberWithLong:model.goodId], model.goodName, [NSNumber numberWithDouble:model.goodPrice], [NSNumber numberWithLong:model.goodCount], [NSNumber numberWithBool:model.isSelected], model.imageUrl, [NSNumber numberWithLong:model.cid]];
    
    return ret;
}

+ (BOOL)update:(ShoppingCartDetail*)model
{
    FMDatabase *db = [DatabaseHelper getInstance];
    
    if (![db open]) {
        NSLog(@"更改数据数据库未打开");
        return false;
    }
    
    BOOL ret = [db executeUpdate:@"UPDATE ShoppingCartTable SET goodId=?, goodName=?, goodPrice=?, goodCount=?, isSelected=?, imageUrl=? WHERE cid=?", [NSNumber numberWithLong:model.goodId], model.goodName, [NSNumber numberWithDouble:model.goodPrice], [NSNumber numberWithLong:model.goodCount], [NSNumber numberWithBool:model.isSelected], model.imageUrl, [NSNumber numberWithLong:model.cid]];
    
    [db close];
    return ret;
}

+ (ShoppingCartDetail *)selectByID:(NSInteger)cid
{
    FMDatabase *db = [DatabaseHelper getInstance];
    
    if (![db open]) {
        return nil;
    }
    
    FMResultSet *set =
    [db executeQuery:@"select * from ShoppingCartTable where cid=? limit 1",
     [NSNumber numberWithInteger:cid]];
    
    if ([set next]) {
        ShoppingCartDetail *result = [self toShoppingCartDetail:set];
        [db close];
        return result;
    }
    
    [db close];
    return nil;
}

+ (NSArray*)selectAll
{
    FMDatabase *db = [DatabaseHelper getInstance];
    
    if (![db open]) {
        NSLog(@"未打开");
        return 0;
    }
    
    FMResultSet *rs =
    [db executeQuery:@"select * from ShoppingCartTable order by createTime asc"];
    
    NSMutableArray *result = [self toList:rs];
    
    [db close];
    return result;
}

+ (BOOL)delete:(ShoppingCartDetail *)model
{
    FMDatabase *db = [DatabaseHelper getInstance];
    
    if (![db open]) {
        NSLog(@"删除数据数据库未打开");
        return false;
    }
    
    BOOL ret = [db executeUpdate:@"DELETE FROM ShoppingCartTable WHERE cid = ?;",
                [NSNumber numberWithInteger:model.cid]];
    
    [db close];
    return ret;
}

+ (BOOL)deleteAll
{
    FMDatabase *db = [DatabaseHelper getInstance];
    if (![db open]) {
        NSLog(@"删除数据数据库未打开");
        return false;
    }
    
    BOOL ret = [db executeUpdate:@"DELETE FROM ShoppingCartTable"];
    
    [db close];
    return ret;
}

+ (NSMutableArray *)selectByDictionary:(NSDictionary *)condition_map
{
    FMDatabase *db = [DatabaseHelper getInstance];
    
    if (![db open]) {
        return nil;
    }
    
    NSString *query = [self selectQuery:condition_map];
    NSArray *values = [self selectArray:condition_map];
    
    FMResultSet *set = [db executeQuery:query withArgumentsInArray:values];
    NSMutableArray *array = [self toList:set];
    [db close];
    
    return array;
}

+ (NSMutableArray *)toList:(FMResultSet *)set
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:100];
    
    while ([set next]) {
        [array addObject:[self toShoppingCartDetail:set]];
    }
    
    return array;
}

+ (NSString *)selectQuery:(NSDictionary *)where
{
    NSMutableString *query =
    [NSMutableString stringWithFormat:@"select * from ArriveTable"];
    NSMutableString *wherekey = [NSMutableString stringWithCapacity:0];
    NSDictionary *dicWhere = where;
    
    if (dicWhere != nil && dicWhere.count > 0) {
        NSArray *keys = dicWhere.allKeys;
        
        for (NSString *key in keys) {
            if (wherekey.length > 0) {
                [wherekey appendFormat:@" and %@=?", key];
            } else {
                [wherekey appendFormat:@"%@=?", key];
            }
        }
        
        [query appendFormat:@" where %@", wherekey];
    }
    return query;
}

+ (NSArray *)selectArray:(NSDictionary *)where
{
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:0];
    NSDictionary *dicWhere = where;
    
    if (dicWhere != nil && dicWhere.count > 0) {
        NSArray *keys = dicWhere.allKeys;
        for (NSString *key in keys) {
            NSString *value = [dicWhere objectForKey:key];
            [values addObject:value];
        }
    }
    
    return values;
}

@end
