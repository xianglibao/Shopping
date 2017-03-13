//
//  MyProfileViewController.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController () <UITableViewDataSource, UITableViewDelegate, LoginDelegate, ServicePhoneDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSArray *sectionList;
@property (nonatomic, retain) NSArray *sectionImageList;

@end

@implementation MyProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_tableView reloadData];
}

- (void)initView
{
    self.title = @"我的信息";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
}

- (void)initData
{
    NSArray *section2 = @[@"我的订单", @"地址管理"];
    NSArray *toolImageList = @[@"myOrder", @"address"];
    
    NSArray *section3 = @[@"客服中心", @"意见反馈", @"关于"];//, @"检查更新"];
    NSArray *otherImageList = @[@"customerService", @"feedback", @"about"];//, @"checkUpdate"];
    
    _sectionList = @[@"", section2, section3];
    _sectionImageList = @[@"", toolImageList, otherImageList];
}

- (void)btnLoginClick:(id)sender
{
    [NavTool gotoLoginVC:self];
}

- (void)AfterLoginSuccess
{
    [_tableView reloadData];
}

- (void)servicePhoneCall:(CodeInfo *)codeInfo {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", codeInfo.val]]];
}

#pragma mark - tableView接口

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return [_sectionList[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *mycell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
    
    AppUser *appUser = [UserTool getUser];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycell];
        if (indexPath.section == 0 && appUser == nil) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(30, 15, screen_width-60, 30)];
            [btn setTitle:@"一键登录" forState:UIControlStateNormal];
            btn.layer.cornerRadius = 5;
            [btn setBackgroundColor:[UIColor orangeColor]];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.tag = 9999;
            [btn addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
        }
    }
    
    if (indexPath.section == 0) {
        UIButton *btn = [cell.contentView viewWithTag:9999];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        
        if (appUser != nil) {
            btn.hidden = YES;
            cell.textLabel.text = appUser.userName;
            cell.detailTextLabel.text = appUser.phoneNumber;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            btn.hidden = NO;
        }
        
        return cell;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIImage *icon = [[UIImage imageNamed:_sectionImageList[indexPath.section][indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    cell.imageView.tintColor = [ColorTool getNavColor];
    cell.imageView.image = icon;

    cell.textLabel.text = _sectionList[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [UIColor darkGrayColor];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {//查看个人信息
        if ([UserTool isLogin]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalInfo" bundle:nil];
            PersonalInfoViewController *vc = [sb instantiateViewControllerWithIdentifier:@"PersonalInfo"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {//订单管理
            if (![UserTool isLogin]) {
                [NavTool gotoLoginVC:self];
                return;
            }
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
            OrderListViewController *vc = [sb instantiateViewControllerWithIdentifier:@"OrderList"];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {//地址管理
            if (![UserTool isLogin]) {
                [NavTool gotoLoginVC:self];
                return;
            }
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Address" bundle:nil];
            AddressListViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AddressList"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {//客服中心
            ServicePhonePicker *picker = [[ServicePhonePicker alloc] initWithParentView:self.navigationController.view];
            picker.delegate = self;
            [picker show];
        } else if (indexPath.row == 1) {//意见反馈
            if (![UserTool isLogin]) {
                [NavTool gotoLoginVC:self];
                return;
            }
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Feedback" bundle:nil];
            FeedbackViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Feedback"];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {//关于
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"About" bundle:nil];
            AboutViewController *vc = [sb instantiateViewControllerWithIdentifier:@"About"];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 3) {//检查更新
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AppUpdate" bundle:nil];
            AppUpdateViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AppUpdate"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
