//
//  PersonalInfoViewController.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "PersonalInfoViewController.h"

@interface PersonalInfoViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate, EditUserDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) AppUser *appUser;

@end

@implementation PersonalInfoViewController

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
    _appUser = [UserTool getUser];
}

- (void)initView
{
    self.title = @"个人信息";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [ColorTool getTableViewSectionColor];
}

- (void)reloadUser
{
    _appUser = [UserTool getUser];
    
    [_tableView reloadData];
}

#pragma mark - tableView接口

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 20;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
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
        
        if (indexPath.section == 0) {
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-190, 5, 150, 30)];
            label.textAlignment = NSTextAlignmentRight;
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor darkGrayColor];
            label.tag = 100 + indexPath.row;
            [cell.contentView addSubview:label];
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    if (indexPath.section == 1) {
        cell.textLabel.text = @"退出登录";
        return cell;
    }
  
    UILabel *label = [cell.contentView viewWithTag:100 + indexPath.row];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"手机";
        label.text = _appUser.phoneNumber;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"昵称";
        if (_appUser.userName == nil || _appUser.userName.length == 0) {
            label.text = @"请编辑";
        } else {
            label.text = _appUser.userName;
        }
    } else {
        cell.textLabel.text = @"称谓";
        label.text = _appUser.gender;
    }
    
    [cell.contentView addSubview:label];

    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalInfo" bundle:nil];
            ChangePhoneNumberViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ChangePhoneNumber"];
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalInfo" bundle:nil];
            EditUserNameViewController *vc = [sb instantiateViewControllerWithIdentifier:@"EditUserName"];
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"先生", @"女士", nil];
            [sheet showInView:self.view];
        }
    } else {
        [AlertTool showAlert:@"确定退出登录?" listener:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [UserTool setUser:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex < 2) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:0];
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:index];
        UILabel *label = [cell.contentView viewWithTag:102];
        
        _appUser.gender = (buttonIndex == 0 ? @"先生" : @"女士");
        
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD show];
        [UserService update:_appUser onSuccess:^(AppUser *user) {
            [SVProgressHUD dismiss];
            
            label.text = user.gender;
            [UserTool setUser:user];
            [self reloadUser];
        } onFail:^(NSString *error, NSInteger statusCode) {
            [SVProgressHUD dismiss];
            
            [AlertTool showText:error view:self.view];
        }];
    }
}

@end
