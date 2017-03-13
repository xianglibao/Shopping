//
//  HeaderCollectionReusableView.h
//  shopping
//
//  Created by chentao on 15/12/7.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryInfo.h"
#import "Protocol.h"

@interface HeaderCollectionReusableView : UICollectionReusableView

@property (nonatomic, retain) CategoryInfo *category;

@property (weak, nonatomic) IBOutlet UILabel *lbCategoryName;
@property (weak, nonatomic) IBOutlet UIButton *btnShowAll;

@property (nonatomic, retain) id<goodSectionHeaderDelegate> delegate;

- (IBAction)btnShowAllClick:(UIButton *)sender;

- (void)setData:(CategoryInfo*)categoryInfo;

@end
