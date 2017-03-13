//
//  OrderDetailViewController.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *orderDetailList;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initData
{
    _orderDetailList = [NSMutableArray new];
    AppUser *user = [UserTool getUser];
    
    OrderSo *so = [OrderSo new];
    so.orderNo = _orderHeader.orderNo;
    so.userId = user.userId;
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [OrderService searchOrderDetail:so onSuccess:^(NSArray *orderList) {
        [SVProgressHUD dismiss];
        _orderHeader = (OrderHeader*)orderList[0];
        [_orderDetailList addObjectsFromArray:_orderHeader.orderDetailVoList];
        [_tableView reloadData];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

- (void)initView
{
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    
    UINib *nib = [UINib nibWithNibName:@"OrderDetailTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"OrderDetailCell"];
    
    UINib *settleNib = [UINib nibWithNibName:@"SettlementTableViewCell" bundle:nil];
    [_tableView registerNib:settleNib forCellReuseIdentifier:@"Settlement"];
    
    if ([_orderHeader.status isEqualToString:@"UN_PAID"]) {
        UIBarButtonItem *payBtn = [[UIBarButtonItem alloc] initWithTitle:@"支付" style:UIBarButtonItemStyleBordered target:self action:@selector(payOrder)];
        
        self.navigationItem.rightBarButtonItem = payBtn;
    } else if ([_orderHeader.status isEqualToString:@"PAID_SUCCESS"]
               || [_orderHeader.status isEqualToString:@"PAID_FINISHED"]) {
        UIBarButtonItem *confirmReceiveBtn = [[UIBarButtonItem alloc] initWithTitle:@"确认收货" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmReceive)];
        
        self.navigationItem.rightBarButtonItem = confirmReceiveBtn;
    }
}

- (void)confirmReceive
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"要确认收货吗" delegate:self cancelButtonTitle:nil otherButtonTitles:@"不要", @"要", nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [alertView show];
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD show];
        [OrderService receiveGood:_orderHeader onSuccess:^(OrderHeader *orderHeader) {
            [SVProgressHUD dismiss];
            self.navigationItem.rightBarButtonItem = nil;
            [AlertTool showText:@"完成收货" view:self.view];
        } onFail:^(NSString *error, NSInteger statusCode) {
            [SVProgressHUD dismiss];
            [AlertTool showText:error view:self.view];
        }];
    }
}

- (void)payOrder
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
    PayViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Pay"];
    vc.orderHeader = _orderHeader;
    vc.fromOrderDetail = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableView接口

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"商品";
    } else {
        return @"结算";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    if (title == nil) {
        return nil;
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, 200, 20)];
    lbTitle.text = title;
    lbTitle.textColor = [UIColor darkGrayColor];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:12];
    
    [view addSubview:lbTitle];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _orderDetailList.count;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    } else {
        return 128;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setData:_orderDetailList[indexPath.row]];
        
        return cell;
    } else {
        SettlementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Settlement"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setData:_orderHeader];
        
        return cell;
    }
    
    return [UITableViewCell new];
}

@end
