//
//  MainViewController.h
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodService.h"
#import "AlertTool.h"
#import "GoodCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "MyProfileViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "GoodDetailViewController.h"
#import "GoodSearchViewController.h"
#import "ShoppingCartDao.h"
#import "ShoppingCartModelTransformer.h"
#import "Canvas.h"
#import "ColorTool.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "NavTool.h"

@interface MainViewController : UIViewController

@property (nonatomic, retain) CategoryInfo *category;

@end
