//
//  Category.h
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "Good.h"

@interface CategoryInfo : MTLModel <MTLJSONSerializing>

//类别id
@property (nonatomic, retain) NSNumber *categoryId;

//名称
@property (nonatomic, retain) NSString *name;

//编码
@property (nonatomic, retain) NSString *code;

//级别
@property (nonatomic, retain) NSNumber *levelTypeId;

//父节点
@property (nonatomic, retain) NSNumber *parentId;

//父节点名称
@property (nonatomic, retain) NSString *parentName;

//层级
@property (nonatomic, retain) NSString *treePath;

//层级name
@property (nonatomic, retain) NSString *namePath;

//显示图片地址
@property (nonatomic, retain) NSString *imagePath;

//是否最后一级
@property (nonatomic, assign) BOOL isEnd;

//子菜单列表
@property (nonatomic, retain) NSMutableArray *subCategoryList;

//商品列表
@property (nonatomic, retain) NSMutableArray *goodList;

+ (NSArray *)toModelListByJsonArray:(NSArray *)data;

@end
