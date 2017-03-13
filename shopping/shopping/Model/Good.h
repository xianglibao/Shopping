//
//  Good.h
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

@interface Good : MTLModel <MTLJSONSerializing>

//商品Id
@property (nonatomic, retain) NSNumber *goodId;

//名称
@property (nonatomic, retain) NSString *name;

//详细描述
@property (nonatomic, retain) NSString *goodDescription;

//计费价格
@property (nonatomic, retain) NSNumber *price;

//显示价格
@property (nonatomic, retain) NSNumber *showPrice;

//运费重量
@property (nonatomic, retain) NSNumber *weight;

//每次最大销售数据
@property (nonatomic, retain) NSNumber *maxBuy;

//类别id
@property (nonatomic, retain) NSNumber *categoryId;

//类别name
@property (nonatomic, retain) NSString *categoryName;

//类别idPath
@property (nonatomic, retain) NSString *categoryIdTree;

//明细图片地址(大)
@property (nonatomic, retain) NSArray *imagePathBig;

//列表图片地址(中)
@property (nonatomic, retain) NSString *imagePathMiddle;

//购物车图片地址(小)
@property (nonatomic, retain) NSString *imagePathSmall;

//上架状态 （待操作，上架，下架）
@property (nonatomic, retain) NSNumber *status;

//库存
@property (nonatomic, retain) NSNumber *stockCount;

//热门类型 (无，爆款，海报，进口)
@property (nonatomic, retain) NSString *promotionType;

//累计销量
@property (nonatomic, retain) NSNumber *salesCount;

//折扣率
@property (nonatomic, retain) NSNumber *discount;

+ (NSArray *)toModelListByJsonArray:(NSArray *)data;

@end
