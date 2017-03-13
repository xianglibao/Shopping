//
//  ShoppingCartViewController.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "ShoppingCartViewController.h"

@interface ShoppingCartViewController () <UITableViewDataSource, UITableViewDelegate, ShoppingCartCellDelegate, shoppingCartDelegate, ChangeAddressDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPrice;
- (IBAction)btnPlaceOrderClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *btnPlaceOrder;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UIImageView *imgShoppingCart;
@property (weak, nonatomic) IBOutlet UIButton *btnGotoMainView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

- (IBAction)btnGotoMainViewClick:(UIButton *)sender;

@property (nonatomic, retain) NSMutableArray *shoppingCartDetailList;

@property (nonatomic, retain) Address *address;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (_shoppingCartDetailList.count == 0) {
        _emptyView.hidden = NO;
    } else {
        _emptyView.hidden = YES;
    }
    
    _lbTotalPrice.text = [NSString stringWithFormat:@"￥%.2f", [self getTotalPrice]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)initData
{
    AppUser *appUser = [UserTool getUser];
    AddressSo *so = [AddressSo new];
    so.userId = appUser.userId;
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [AddressService search:so onSuccess:^(NSArray *addressList) {
        [SVProgressHUD dismiss];
        [self setCurrentAddress:addressList];
        [_tableView reloadData];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        _address = nil;
    }];
    
    _shoppingCartDetailList = [NSMutableArray new];
    [_shoppingCartDetailList addObjectsFromArray:[ShoppingCartDao selectAll]];
}

- (void)setCurrentAddress:(NSArray*)addressList
{
    if (addressList == nil || addressList.count == 0) {
        _address = nil;
    } else {
        BOOL isExist = NO;
        NSNumber *addressId = [UserTool getCurrentAddressType:[UserTool getUser].userId];
        if (addressId == nil) {
            _address = addressList[0];
            [UserTool setCurrentAddress:_address.addressId key:[UserTool getUser].userId];
            return;
        }
        
        for (Address *address in addressList) {
            if ([address.addressId isEqualToNumber:addressId]) {
                isExist = YES;
                _address = address;
                break;
            }
        }
        if (!isExist) {
            _address = addressList[0];
            [UserTool setCurrentAddress:_address.addressId key:[UserTool getUser].userId];
        }
    }
}

- (void)initView
{
    self.title = @"购物车";
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    
    _toolView.backgroundColor = [ColorTool getTableViewSectionColor];
    _containerView.backgroundColor = [UIColor clearColor];
    
    _lbTotalPrice.text = [NSString stringWithFormat:@"￥%.2f", [self getTotalPrice]];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancel)];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    _emptyView.backgroundColor = [ColorTool getViewBackgroundColor];
    UIImage *image = [[UIImage imageNamed:@"shoppingCart_empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _imgShoppingCart.tintColor = [ColorTool getNavColor];
    _imgShoppingCart.image = image;
    _imgShoppingCart.contentMode = UIViewContentModeScaleAspectFit;
    _btnGotoMainView.backgroundColor = [ColorTool getBlueColor];
    
    
    UINib *addressNib = [UINib nibWithNibName:@"AddressListTableViewCell" bundle:nil];
    [_tableView registerNib:addressNib forCellReuseIdentifier:@"AddressListCell"];
    
    UINib *nib = [UINib nibWithNibName:@"ShoppingCartTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"ShoppingCartCell"];
}

- (double)getTotalPrice
{
    double totalPrice = 0;
    
    for (ShoppingCartDetail *detail in _shoppingCartDetailList) {
        if (detail.isSelected) {
            totalPrice += detail.goodCount * detail.goodPrice;
        }
    }
    
    return totalPrice;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([_delegate respondsToSelector:@selector(refreshShoppingCart)]) {
        [_delegate refreshShoppingCart];
    }
}

- (void)addClick:(ShoppingCartDetail*)shoppingCartDetail
{
    [ShoppingCartDao update:shoppingCartDetail];
    _lbTotalPrice.text = [NSString stringWithFormat:@"￥%.2f", [self getTotalPrice]];
}

- (void)cutClick:(ShoppingCartDetail*)shoppingCartDetail
{
    [ShoppingCartDao update:shoppingCartDetail];
    _lbTotalPrice.text = [NSString stringWithFormat:@"￥%.2f", [self getTotalPrice]];
}

- (void)selectClick:(ShoppingCartDetail*)shoppingCartDetail
{
    [ShoppingCartDao update:shoppingCartDetail];
    _lbTotalPrice.text = [NSString stringWithFormat:@"￥%.2f", [self getTotalPrice]];
}

- (void)goodImageClick:(ShoppingCartDetail *)shoppingCartDetail
{
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [GoodService getGoodById:shoppingCartDetail.goodId onSuccess:^(Good *good) {
        [SVProgressHUD dismiss];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GoodDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"GoodDetail"];
        vc.delegate = self;
        
        vc.good = good;
        
        [self presentViewController:vc animated:YES completion:nil];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

- (void)refreshShoppingCart
{
    [self initData];
    [_tableView reloadData];
}

- (void)changeAddress:(Address*)address
{
    [UserTool setCurrentAddress:address.addressId key:[UserTool getUser].userId];
    _address = address;
    [_tableView reloadData];
}

- (NSArray*)getBuyList
{
    NSMutableArray *result = [NSMutableArray new];
    
    for (ShoppingCartDetail *detail in _shoppingCartDetailList) {
        if (detail.isSelected) {
            [result addObject:detail];
        }
    }
    
    return result;
}

- (IBAction)btnPlaceOrderClick:(UIButton *)sender
{
    if (_address == nil) {
        [AlertTool showText:@"请先创建收货地址" view:self.view];
        return;
    }
    
    NSArray *list = [self getBuyList];
    
    if (list.count == 0) {
        [AlertTool showText:@"请选中需要购买的商品" view:self.view];
        return;
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
    PlaceOrderViewController *vc = [sb instantiateViewControllerWithIdentifier:@"PlaceOrder"];
    vc.shoppingCartDetailList = list;
    vc.address = _address;
    vc.vc = self;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnAddressClick:(UIButton*)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Address" bundle:nil];
    AddressListViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AddressList"];
    vc.delegate = self;
    vc.fromShoppingCart = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnGotoMainViewClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(refreshShoppingCart)]) {
        [_delegate refreshShoppingCart];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - tableView接口

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 15;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return _shoppingCartDetailList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 63;
    } else {
        return 70;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_address == nil) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 16.5, screen_width-60, 30)];
                label.text = @"创建收货地址";
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor orangeColor];
                label.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:label];
            }
            return cell;
        }
        
        AddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressListCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setData:_address];
        return cell;
    }
    
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell setData:_shoppingCartDetailList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Address" bundle:nil];
        AddressListViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AddressList"];
        vc.delegate = self;
        vc.fromShoppingCart = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
    [ShoppingCartDao delete:_shoppingCartDetailList[indexPath.row]];
    [_shoppingCartDetailList removeObjectAtIndex:indexPath.row];
    _lbTotalPrice.text = [NSString stringWithFormat:@"￥%.2f", [self getTotalPrice]];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
    
    if (_shoppingCartDetailList == nil || _shoppingCartDetailList.count == 0) {
        _emptyView.hidden = NO;
    }
}

@end
