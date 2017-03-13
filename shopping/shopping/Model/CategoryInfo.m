//
//  Category.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "CategoryInfo.h"

@implementation CategoryInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"categoryId":@"id",
             @"name":@"name",
             @"code":@"code",
             @"levelTypeId":@"levelTypeId",
             @"parentId":@"parentId",
             @"parentName":@"parentName",
             @"treePath":@"treePath",
             @"namePath":@"namePath",
             @"imagePath":@"imagePath",
             @"isEnd":@"isEnd",
             @"subCategoryList":@"subCategoryList",
             @"goodList":@"goodVoList"};
}

+ (NSValueTransformer *)subCategoryListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CategoryInfo.class];
}

+ (NSValueTransformer *)goodListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:Good.class];
}

+ (NSArray *)toModelListByJsonArray:(NSArray *)data {
    NSError *error;
    NSArray *resultlist = [MTLJSONAdapter modelsOfClass:CategoryInfo.class fromJSONArray:data error:&error];
    
    return resultlist;
}

@end
