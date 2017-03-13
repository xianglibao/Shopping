//
//  GoodDetailViewController.h
//  shopping
//
//  Created by chentao on 15/12/7.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Good.h"
#import "ShoppingCartDao.h"
#import "ShoppingCartViewController.h"
#import "AlertTool.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ShoppingCartDao.h"
#import "ShoppingCartModelTransformer.h"
#import "ColorTool.h"
#import "Protocol.h"
#import "SDCycleScrollView.h"
#import "NavTool.h"

@interface GoodDetailViewController : UIViewController

@property (nonatomic, retain) Good *good;

@property (nonatomic, retain) id<shoppingCartDelegate> delegate;

@end
