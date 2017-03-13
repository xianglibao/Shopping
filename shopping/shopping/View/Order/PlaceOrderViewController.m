//
//  PlaceOrderViewController.m
//  shopping
//
//  Created by chentao on 15/12/21.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "PlaceOrderViewController.h"

@interface PlaceOrderViewController () <UITableViewDataSource, UITableViewDelegate, DeliveryTimeDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalSum;
@property (weak, nonatomic) IBOutlet UIView *toolView;

@property (nonatomic, assign) double sendCost;
@property (nonatomic, retain) OrderHeader *orderHeader;

@property (nonatomic, retain) UITextField *txtRemark;
@property (nonatomic, retain) UILabel *lbDeliveryTime;
@property (nonatomic, retain) NSString *deliveryTime;

- (IBAction)btnConfirmOrderClick:(UIButton *)sender;

@end

@implementation PlaceOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"下单";
    
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initData
{
    AppUser *user = [UserTool getUser];
    
    OrderHeader *orderHeader = [OrderHeader new];
    orderHeader.orderDetailVoList = [NSMutableArray new];
    orderHeader.userId = user.userId;
    
    for (ShoppingCartDetail *item in _shoppingCartDetailList) {
        OrderDetail *orderDetail = [OrderDetail new];
        orderDetail.goodId = [NSNumber numberWithLong:item.goodId];
        orderDetail.amount = item.goodCount;
        
        [orderHeader.orderDetailVoList addObject:orderDetail];
    }
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [OrderService calcOrderFee:orderHeader onSuccess:^(OrderHeader *orderHeader) {
        [SVProgressHUD dismiss];
        _orderHeader = orderHeader;
        [_tableView reloadData];
        _lbTotalSum.text = [NSString stringWithFormat:@"￥%.2f", _orderHeader.paidPrice];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

- (void)initView
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    
    _toolView.backgroundColor = [ColorTool getTableViewSectionColor];
    
    UINib *addressCellNib = [UINib nibWithNibName:@"AddressListTableViewCell" bundle:nil];
    [_tableView registerNib:addressCellNib forCellReuseIdentifier:@"AddressListCell"];
    
    UINib *settlementCellNib = [UINib nibWithNibName:@"PlaceOrderSettlementTableViewCell" bundle:nil];
    [_tableView registerNib:settlementCellNib forCellReuseIdentifier:@"PlaceOrderSettlement"];
    
    UINib *goodDetailCellNib = [UINib nibWithNibName:@"PlaceOrderGoodDetailTableViewCell" bundle:nil];
    [_tableView registerNib:goodDetailCellNib forCellReuseIdentifier:@"PlaceOrderGoodDetail"];
}

- (long)getTotalAmount
{
    long result = 0;
    
    for (ShoppingCartDetail *item in _shoppingCartDetailList) {
        result += item.goodCount;
    }
    
    return result;
}

- (IBAction)btnConfirmOrderClick:(UIButton *)sender
{
    if ([_lbDeliveryTime.text isEqualToString:@"请选择"]) {
        [AlertTool showText:@"请先选择配送时间" view:self.view];
        return;
    }
    
    if (_orderHeader.paidPrice <= 0) {
        [AlertTool showText:@"支付金额必须大于0" view:self.view];
        return;
    }
    
    AppUser *appUser = [UserTool getUser];
    
    OrderHeader *orderHeader = [OrderHeader new];
    orderHeader.userId = appUser.userId;
    orderHeader.userName = _address.userName;
    orderHeader.phoneNumber = _address.phoneNumber;
    orderHeader.address = [NSString stringWithFormat:@"%@%@", _address.address, _address.houseNo];
    orderHeader.deliveryTime = _deliveryTime;
    orderHeader.paymentType = 0;
    orderHeader.remark = _txtRemark.text;
    orderHeader.totalAmount = [self getTotalAmount];
    
    orderHeader.orderDetailVoList = [NSMutableArray new];
    
    for (ShoppingCartDetail *item in _shoppingCartDetailList) {
        OrderDetail *orderDetail = [OrderDetail new];
        orderDetail.goodId = [NSNumber numberWithLong:item.goodId];
        orderDetail.amount = item.goodCount;
        
        [orderHeader.orderDetailVoList addObject:orderDetail];
    }
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [OrderService submitOrder:orderHeader onSuccess:^(OrderHeader *orderHeader) {
        [SVProgressHUD dismiss];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
        PayViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Pay"];
        vc.orderHeader = orderHeader;
        vc.vc = self;
        [self.navigationController pushViewController:vc animated:YES];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

- (void)deliveryTimeSelected:(DeliveryTimeInfo *)deliveryTime
{
    _lbDeliveryTime.textColor = [ColorTool getBlueColor];
    _lbDeliveryTime.text = [NSString stringWithFormat:@"%@ %@", deliveryTime.day, deliveryTime.time];
    
    if ([deliveryTime.day isEqualToString:@"今天"]) {
        _deliveryTime = [NSString stringWithFormat:@"%@ %@", [DateTool getStringFromDate:[NSDate date] format:@"yyyy-MM-dd"], deliveryTime.time];
    } else {
        _deliveryTime = [NSString stringWithFormat:@"%@ %@", [DateTool getStringFromDate:[[NSDate date] dateByAddingTimeInterval:24*60*60] format:@"yyyy-MM-dd"], deliveryTime.time];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - tableView接口

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 4) {
        return _shoppingCartDetailList.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 63;
    } else if (indexPath.section == 1) {
        return 90;
    } else if (indexPath.section == 2) {
        return 40;
    } else if (indexPath.section == 3) {
        return 40;
    }
    return 49;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"结算";
    } else if (section == 2) {
        return @"配送时间";
    } else if (section == 3) {
        return @"备注";
    } else if (section == 4) {
        return @"订单详情";
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 4) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [ColorTool getTableViewSectionColor];
        
        UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 7.5, 80, 20)];
        lbTitle.text = @"订单详情";
        lbTitle.textColor = [UIColor darkGrayColor];
        lbTitle.backgroundColor = [UIColor clearColor];
        lbTitle.font = [UIFont systemFontOfSize:12];
        
        UILabel *lbTotalWeight = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-216, 7.5, 200, 20)];
        lbTotalWeight.text = [NSString stringWithFormat:@"总重量: %.2f", _orderHeader.totalWeight];
        lbTotalWeight.textColor = [UIColor darkGrayColor];
        lbTotalWeight.backgroundColor = [UIColor clearColor];
        lbTotalWeight.font = [UIFont systemFontOfSize:12];
        lbTotalWeight.textAlignment = NSTextAlignmentRight;
        
        [view addSubview:lbTitle];
        [view addSubview:lbTotalWeight];
        
        return view;
    }
    
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    if (title == nil) {
        return nil;
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [ColorTool getTableViewSectionColor];
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 7.5, 200, 20)];
    lbTitle.text = title;
    lbTitle.textColor = [UIColor darkGrayColor];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:12];
    
    [view addSubview:lbTitle];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AddressListTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"AddressListCell"];
        [cell setData:_address];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        PlaceOrderSettlementTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"PlaceOrderSettlement"];
        [cell setData:_orderHeader];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"timeCell"];
            
            UIImage *image = [[UIImage imageNamed:@"clock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            cell.imageView.tintColor = [ColorTool getNavColor];
            cell.imageView.image = image;
            
            cell.textLabel.text = @"期望送达时间";
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            
            _lbDeliveryTime = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-186, 10, 150, 20)];
            _lbDeliveryTime.text = @"请选择";
            _lbDeliveryTime.textAlignment = NSTextAlignmentRight;
            _lbDeliveryTime.font = [UIFont systemFontOfSize:13];
            _lbDeliveryTime.textColor = [UIColor orangeColor];
            
            [cell.contentView addSubview:_lbDeliveryTime];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"remarkCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"remarkCell"];
            
            _txtRemark = [[UITextField alloc] initWithFrame:CGRectMake(16, 5, screen_width-16, 30)];
            _txtRemark.placeholder = @"可填写安全存放地址、请按门铃等配送相关要求";
            _txtRemark.tag = 100;
            _txtRemark.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:_txtRemark];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 4) {
        PlaceOrderGoodDetailTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"PlaceOrderGoodDetail"];
        [cell setData:_shoppingCartDetailList[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        DeliveryTimePicker *picker = [[DeliveryTimePicker alloc] initWithParentView:self.navigationController.view];
        picker.delegate = self;
        [picker show];
    }
}

@end
