//
//  ServicePhonePicker.m
//  shopping
//
//  Created by chentao on 16/2/22.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "ServicePhonePicker.h"

@interface ServicePhonePicker () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *codeInfoList;
@property (nonatomic, retain) UIView *parentView;
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation ServicePhonePicker

- (instancetype)initWithParentView:(UIView*)view
{
    self = [super init];
    
    if (self) {
        _parentView = view;
        [self initData];
        [self initView];
    }
    
    return self;
}

- (void)initData
{
    _codeInfoList = [NSMutableArray new];
    
    CodeSo *so = [CodeSo new];
    so.typeCode = @"CUSTOMER_PHONE";
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [BaseInfoService SearchCodeInfo:so onSuccess:^(NSArray *codeInfoList) {
        [SVProgressHUD dismiss];
        if (codeInfoList == nil || codeInfoList.count == 0) {
            [AlertTool showText:@"暂时没有客服" view:self];
            return;
        }
        [_codeInfoList addObjectsFromArray:codeInfoList];
        [_tableView reloadData];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self];
    }];
}

- (void)initView
{
    self.frame = CGRectMake(0, 0, screen_width, screen_height);
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(30, 200, screen_width-60, screen_height-400)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 10;
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width-60, 30)];
    lbTitle.text = @"请选择客服";
    lbTitle.textColor = [UIColor darkGrayColor];
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.font = [UIFont systemFontOfSize:13];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, screen_width-60, screen_height-400)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.layer.cornerRadius = 10;
    
    [contentView addSubview:lbTitle];
    [contentView addSubview:_tableView];
    
    [self addSubview:contentView];
}

- (void)show
{
    [_parentView addSubview:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

#pragma mark - tableView接口

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _codeInfoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"servicePhoneCell";
    ServicePhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil) {
        cell = [[ServicePhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    [cell setData:_codeInfoList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(servicePhoneCall:)]) {
        [_delegate servicePhoneCall:_codeInfoList[indexPath.row]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self removeFromSuperview];
}

@end
