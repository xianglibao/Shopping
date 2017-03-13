//
//  ChangePhoneNumberViewController.m
//  shopping
//
//  Created by chentao on 15/12/28.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "ChangePhoneNumberViewController.h"

@interface ChangePhoneNumberViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtSignCode;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *btnSendSignCode;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

- (IBAction)btnSendSignCodeClick:(UIButton *)sender;
- (IBAction)btnConfirmClick:(UIButton *)sender;

@end

@implementation ChangePhoneNumberViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    self.title = @"修改手机号";
    
    _txtPhone.keyboardType = UIKeyboardTypePhonePad;
    _txtSignCode.keyboardType = UIKeyboardTypeNumberPad;
    
    _btnSendSignCode.backgroundColor = [ColorTool getGreenTextColor];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(exit)];
    
    self.navigationItem.leftBarButtonItem = btn;
}

- (void)exit
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSendSignCodeClick:(UIButton *)sender
{
    if (![StringTool isLegalMobilePhone:_txtPhone.text]) {
        [AlertTool showText:@"请输入有效的手机号码" view:self.view];
        return;
    }
    
    AppUser *user = [AppUser new];
    user.phoneNumber = _txtPhone.text;
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [UserService sendSignCode:user onSuccess:^(BOOL success) {
        [SVProgressHUD dismiss];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:@"获取验证码失败" view:self.view];
    }];
    
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_btnSendSignCode setTitle:@"发送验证码" forState:UIControlStateNormal];
                _btnSendSignCode.enabled = YES;
                _btnSendSignCode.backgroundColor = [ColorTool getGreenTextColor];
            });
        } else {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_btnSendSignCode setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _btnSendSignCode.enabled = NO;
                _btnSendSignCode.backgroundColor = [UIColor lightGrayColor];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)btnConfirmClick:(UIButton *)sender
{
    if (![StringTool isLegalMobilePhone:_txtPhone.text]) {
        [AlertTool showText:@"请输入有效的手机号码" view:self.view];
        return;
    }
    
    if (_txtSignCode.text == nil || _txtSignCode.text.length == 0) {
        [AlertTool showText:@"请输入验证码" view:self.view];
        return;
    }
    
    AppUser *user = [AppUser new];
    user.phoneNumber = _txtPhone.text;
    user.signCode = [MD5Tool md5:[NSString stringWithFormat:@"%@%@", _txtSignCode.text, _txtPhone.text]];
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [UserService update:user onSuccess:^(AppUser *user) {
        [SVProgressHUD dismiss];
        [UserTool setUser:user];
        [self.navigationController popViewControllerAnimated:YES];
        
        if ([_delegate respondsToSelector:@selector(reloadUser)]) {
            [_delegate reloadUser];
        }
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

@end
