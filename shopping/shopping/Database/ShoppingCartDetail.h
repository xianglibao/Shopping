//
//  ShoppingCartDetail.h
//  shopping
//
//  Created by chentao on 15/12/16.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartDetail : NSObject

@property (nonatomic, assign) long cid;
@property (nonatomic, assign) long goodId;
@property (nonatomic, retain) NSString *goodName;
@property (nonatomic, assign) double goodPrice;
@property (nonatomic, assign) long goodCount;
@property (nonatomic, retain) NSDate *createTime;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, retain) NSString *imageUrl;

@end
