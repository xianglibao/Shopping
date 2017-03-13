//
//  EditUserNameViewController.m
//  shopping
//
//  Created by chentao on 15/12/28.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "EditUserNameViewController.h"

@interface EditUserNameViewController ()

@property (weak, nonatomic) IBOutlet UITextView *txtUserName;

@end

@implementation EditUserNameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView
{
    self.title = @"修改昵称";
    
    UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(save)];
    
    self.navigationItem.rightBarButtonItem = btnSave;
    
    [_txtUserName becomeFirstResponder];
}

- (void)save
{
    if (_txtUserName.text == nil || _txtUserName.text.length == 0) {
        [AlertTool showText:@"请填写昵称" view:self.view];
        return;
    }
    
    AppUser *appUser = [UserTool getUser];
    appUser.userName = _txtUserName.text;
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [UserService update:appUser onSuccess:^(AppUser *user) {
        [SVProgressHUD dismiss];
        [UserTool setUser:user];
        [self.navigationController popViewControllerAnimated:YES];
        [_delegate reloadUser];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

@end
