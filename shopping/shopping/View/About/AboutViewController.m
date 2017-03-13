//
//  AboutViewController.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UITextView *tvAbout;
@property (weak, nonatomic) IBOutlet UILabel *lbAppName;
@property (weak, nonatomic) IBOutlet UILabel *lbCopyright;

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView
{
    self.title = @"关于";
    
    _backView.backgroundColor = [ColorTool getTableViewSectionColor];
    
    _imgIcon.image = [UIImage imageNamed:@"rongmeimei"];
    _imgIcon.layer.cornerRadius = 10;
    
    _lbAppName.text = @"蓉妹妹购物 1.0";
    _lbAppName.textColor = [ColorTool getNavColor];
    _lbAppName.font = [UIFont systemFontOfSize:16];
    
    _lbCopyright.font = [UIFont systemFontOfSize:11];
    _lbCopyright.text = @"Copyright© 2016-2026山西德运大通商贸有限公司版权所有";
    
    _tvAbout.font = [UIFont systemFontOfSize:13];
    _tvAbout.editable = NO;
    _tvAbout.textColor = [UIColor darkGrayColor];
    
    CodeSo *so = [CodeSo new];
    so.typeCode = @"HOME_PAGE";
    
    [BaseInfoService SearchCodeInfo:so onSuccess:^(NSArray *codeInfoList) {
        if (codeInfoList != nil && codeInfoList.count > 0) {
            CodeInfo *codeInfo = codeInfoList[0];
            _tvAbout.text = codeInfo.remark;
        }
    } onFail:^(NSString *error, NSInteger statusCode) {
        [AlertTool showText:error view:self.view];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
