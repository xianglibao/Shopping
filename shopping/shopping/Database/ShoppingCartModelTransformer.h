//
//  ShoppingCartModelTransformer.h
//  shopping
//
//  Created by chentao on 15/12/23.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Good.h"
#import "ShoppingCartDetail.h"

@interface ShoppingCartModelTransformer : NSObject

+ (ShoppingCartDetail*)toDbModel:(Good*)good;

+ (ShoppingCartDetail*)toDbModel:(Good*)good count:(long)count;

@end
