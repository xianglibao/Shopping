//
//  AddressListViewController.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "AddressListViewController.h"
#import "Address.h"
#import "AddressListTableViewCell.h"
#import "AddressDetailViewController.h"

@interface AddressListViewController () <UITableViewDataSource, UITableViewDelegate, AddressDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *addressList;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateAddress;
- (IBAction)btnCreateAddressClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgAddress;

@end

@implementation AddressListViewController

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

- (void)initView
{
    self.title = @"地址管理";
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    
    _emptyView.backgroundColor = [ColorTool getViewBackgroundColor];
    UIImage *image = [[UIImage imageNamed:@"location_empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _imgAddress.tintColor = [ColorTool getNavColor];
    _imgAddress.image = image;
    _imgAddress.contentMode = UIViewContentModeScaleAspectFit;
    _btnCreateAddress.backgroundColor = [ColorTool getBlueColor];
    _emptyView.hidden = YES;
    
    UINib *cellNib = [UINib nibWithNibName:@"AddressListTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"AddressListCell"];
    
    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAddress)];
    
    self.navigationItem.rightBarButtonItem = btnAdd;
}

- (void)addAddress
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Address" bundle:nil];
    AddressDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AddressDetail"];
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initData
{
    _addressList = [NSMutableArray new];
    
    AppUser *appUser = [UserTool getUser];
    AddressSo *so = [AddressSo new];
    so.userId = appUser.userId;
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [AddressService search:so onSuccess:^(NSArray *addressList) {
        [SVProgressHUD dismiss];
        if (addressList == nil || addressList.count == 0) {
            _emptyView.hidden = NO;
        } else {
            _emptyView.hidden = YES;
            [_addressList removeAllObjects];
            [_addressList addObjectsFromArray:addressList];
            [_tableView reloadData];
        }
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

- (void)deleteAddress:(NSIndexPath*)indexPath
{
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [AddressService delete:_addressList[indexPath.section] onSuccess:^(BOOL success) {
        [SVProgressHUD dismiss];
        if (success) {
            [_addressList removeObjectAtIndex:indexPath.section];
            [_tableView deleteSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            
            if (_addressList == nil || _addressList.count == 0) {
                _emptyView.hidden = NO;
            }
        }
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

- (void)AddressReload
{
    [self initData];
}

- (IBAction)btnCreateAddressClick:(UIButton *)sender
{
    [self addAddress];
}

#pragma mark - tableView接口

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _addressList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _addressList.count - 1) {
        return 10;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AddressListCell"];
    
    if (!_fromShoppingCart) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell setData:_addressList[indexPath.section]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_fromShoppingCart) {
        [self.navigationController popViewControllerAnimated:YES];
        if ([_delegate respondsToSelector:@selector(changeAddress:)]) {
            [_delegate changeAddress:_addressList[indexPath.section]];
        }
        return;
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Address" bundle:nil];
    AddressDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AddressDetail"];

    vc.delegate = self;
    vc.address = _addressList[indexPath.section];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deleteAddress:indexPath];
}

@end
