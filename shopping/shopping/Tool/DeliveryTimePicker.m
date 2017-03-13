//
//  DeliveryTimePicker.m
//  shopping
//
//  Created by chentao on 16/1/18.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "DeliveryTimePicker.h"

@interface DeliveryTimePicker () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *timeList;
@property (nonatomic, retain) UIView *parentView;

@end

@implementation DeliveryTimePicker

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
    [self createDeliveryTimeList];
}

- (void)createDeliveryTimeList
{
    _timeList = [NSMutableArray new];
    
    int beginTime = 9;
    int endTime = 21;
    
    int CurrentHour = [DateTool getStringFromDate:[NSDate date] format:@"HH"].intValue;
    
    for (int i = CurrentHour+1; i<endTime; i++) {
        DeliveryTimeInfo *time = [DeliveryTimeInfo new];
        time.day = @"今天";
        time.time = [NSString stringWithFormat:@"%d:00-%d:00", i, i+1];
        [_timeList addObject:time];
    }
    
    for (int i = beginTime; i<endTime; i++) {
        DeliveryTimeInfo *time = [DeliveryTimeInfo new];
        time.day = @"明天";
        time.time = [NSString stringWithFormat:@"%d:00-%d:00", i, i+1];
        [_timeList addObject:time];
    }
}

- (void)initView
{
    self.frame = CGRectMake(0, 0, screen_width, screen_height);
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(30, 140, screen_width-60, screen_height-280)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 10;
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width-60, 30)];
    lbTitle.text = @"请选择配送时间";
    lbTitle.textColor = [UIColor darkGrayColor];
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.font = [UIFont systemFontOfSize:13];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, screen_width-60, screen_height-310)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.layer.cornerRadius = 10;
    
    [contentView addSubview:lbTitle];
    [contentView addSubview:tableView];
    
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
    return _timeList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"timeCell";
    DeliveryTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[DeliveryTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    [cell setData:_timeList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(deliveryTimeSelected:)]) {
        [_delegate deliveryTimeSelected:_timeList[indexPath.row]];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self removeFromSuperview];
}

@end
