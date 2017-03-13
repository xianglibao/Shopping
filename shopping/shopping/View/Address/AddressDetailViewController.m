//
//  AddressDetailViewController.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "AddressDetailViewController.h"

@interface AddressDetailViewController () <UITableViewDataSource, UITableViewDelegate, SearchAddressDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) UITextField *txtUserName;
@property (nonatomic, retain) UITextField *txtPhone;
@property (nonatomic, retain) UITextField *txtAddress;
@property (nonatomic, retain) UITextField *txtHouseNo;

@end

@implementation AddressDetailViewController

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

- (void)initData
{
    
}

- (void)initView
{
    if (_address != nil) {
        self.title = @"地址编辑";
    } else {
        self.title = @"地址新增";
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [ColorTool getTableViewSectionColor];
    
    UIBarButtonItem *btnCommit = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
    
    self.navigationItem.rightBarButtonItem = btnCommit;
}

- (void)confirm
{
    if (![StringTool isLegalPhoneNumber:_txtPhone.text]) {
        [AlertTool showText:@"请输入有效的电话号码" view:self.view];
        return;
    }
    
    AppUser *appUser = [UserTool getUser];
    
    if (_address == nil) {
        Address *address = [Address new];
        
        address.userId = appUser.userId;
        address.userName = _txtUserName.text;
        address.phoneNumber = _txtPhone.text;
        address.address = _txtAddress.text;
        address.houseNo = _txtHouseNo.text;
        
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD show];
        [AddressService create:address onSuccess:^(Address *address) {
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
            if ([_delegate respondsToSelector:@selector(AddressReload)]) {
                [_delegate AddressReload];
            }
        } onFail:^(NSString *error, NSInteger statusCode) {
            [SVProgressHUD dismiss];
            [AlertTool showText:error view:self.view];
        }];
    } else {
        _address.userName = _txtUserName.text;
        _address.phoneNumber = _txtPhone.text;
        _address.address = _txtAddress.text;
        _address.houseNo = _txtHouseNo.text;
        
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD show];
        [AddressService update:_address onSuccess:^(Address *address) {
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
            if ([_delegate respondsToSelector:@selector(AddressReload)]) {
                [_delegate AddressReload];
            }
        } onFail:^(NSString *error, NSInteger statusCode) {
            [SVProgressHUD dismiss];
            [AlertTool showText:error view:self.view];
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)addressSelected:(NSString *)address
{
    _txtAddress.text = address;
}

#pragma mark - tableView接口

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *mycell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycell];
        
        if (indexPath.row == 0) {
            _txtUserName = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, screen_width-120, 30)];
            cell.textLabel.text = @"收货人";
            _txtUserName.textAlignment = NSTextAlignmentLeft;
            _txtUserName.font = [UIFont systemFontOfSize:12];
            _txtUserName.textColor = [UIColor darkGrayColor];
            _txtUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:_txtUserName];
        } else if (indexPath.row == 1) {
            _txtPhone = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, screen_width-120, 30)];
            cell.textLabel.text = @"手机";
            _txtPhone.textAlignment = NSTextAlignmentLeft;
            _txtPhone.font = [UIFont systemFontOfSize:12];
            _txtPhone.textColor = [UIColor darkGrayColor];
            _txtPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
            _txtPhone.keyboardType = UIKeyboardTypeNumberPad;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:_txtPhone];
        } else if (indexPath.row == 2) {
            _txtAddress = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, screen_width-120, 30)];
            cell.textLabel.text = @"地址";
            _txtAddress.textAlignment = NSTextAlignmentLeft;
            _txtAddress.font = [UIFont systemFontOfSize:12];
            _txtAddress.textColor = [UIColor darkGrayColor];
            _txtAddress.placeholder = @"请选择小区、写字楼";
            _txtAddress.enabled = NO;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.contentView addSubview:_txtAddress];
        } else {
            _txtHouseNo = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, screen_width-120, 30)];
            cell.textLabel.text = @"门牌号";
            _txtHouseNo.textAlignment = NSTextAlignmentLeft;
            _txtHouseNo.font = [UIFont systemFontOfSize:12];
            _txtHouseNo.textColor = [UIColor darkGrayColor];
            _txtHouseNo.clearButtonMode = UITextFieldViewModeWhileEditing;
            _txtHouseNo.placeholder = @"请填写具体单元、楼层、门牌号等";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:_txtHouseNo];
        }
    }
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    if (indexPath.row == 0) {
        _txtUserName.text = _address.userName;
    } else if (indexPath.row == 1) {
        _txtPhone.text = _address.phoneNumber;
    } else if (indexPath.row == 2) {
        _txtAddress.text = _address.address;
    } else {
        _txtHouseNo.text = _address.houseNo;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Address" bundle:nil];
        AddressSearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"addressSearch"];
        vc.delegate = self;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
