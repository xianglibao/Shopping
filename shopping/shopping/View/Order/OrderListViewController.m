//
//  OrderListViewController.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "OrderListViewController.h"

@interface OrderListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UIImageView *imgOrder;
@property (weak, nonatomic) IBOutlet UIButton *btnGoShopping;

- (IBAction)btnGoShoppingClick:(UIButton *)sender;

@property (nonatomic, retain) NSMutableArray *orderHeaderList;

@end


@implementation OrderListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initData];
}

- (void)initView
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _emptyView.backgroundColor = [ColorTool getViewBackgroundColor];
    UIImage *image = [[UIImage imageNamed:@"order_empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _imgOrder.tintColor = [ColorTool getNavColor];
    _imgOrder.image = image;
    _imgOrder.contentMode = UIViewContentModeScaleAspectFit;
    _btnGoShopping.backgroundColor = [ColorTool getBlueColor];
    _emptyView.hidden = YES;

    
    UINib *cellNib = [UINib nibWithNibName:@"OrderListTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"OrderListCell"];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
        [_tableView.mj_header endRefreshing];
    }];
}

- (void)initData
{
    _orderHeaderList = [NSMutableArray new];
    
    [self requestData];
}

- (void)requestData
{
    AppUser *appUser = [UserTool getUser];
    OrderSo *so = [OrderSo new];
    so.userId = appUser.userId;
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [OrderService fetchOrderList:so onSuccess:^(NSArray *orderList) {
        [SVProgressHUD dismiss];
        if (orderList == nil || orderList.count == 0) {
            _emptyView.hidden = NO;
        } else {
            _emptyView.hidden = YES;
            [_orderHeaderList removeAllObjects];
            [_orderHeaderList addObjectsFromArray:[self sortOrderList:orderList]];
            [_tableView reloadData];
        }
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];

}

- (NSArray*)sortOrderList:(NSArray*)orderList
{
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdTime" ascending:NO];
    NSArray *sortDescriptors = @[firstDescriptor];
    NSArray *result = [orderList sortedArrayUsingDescriptors:sortDescriptors];
    
    return result;
}

- (IBAction)btnGoShoppingClick:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - tableView接口

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _orderHeaderList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _orderHeaderList.count - 1) {
        return 15;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell setData:_orderHeaderList[indexPath.section]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
    OrderDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"OrderDetail"];
    vc.orderHeader = _orderHeaderList[indexPath.section];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
