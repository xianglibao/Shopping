//
//  FeedbackViewController.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FeedbackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"反馈";
    
    UIBarButtonItem *btnCommit = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"commit"] style:UIBarButtonItemStyleBordered target:self action:@selector(submit)];
    
    self.navigationItem.rightBarButtonItem = btnCommit;
}

- (void)submit
{
    AppUser *appUser = [UserTool getUser];
    
    Feedback *feedback = [Feedback new];
    feedback.userId = appUser.userId;
    feedback.userName = appUser.userName;
    feedback.phoneNumber = appUser.phoneNumber;
    feedback.content = _textView.text;
    
    [BaseInfoService createFeedback:feedback onSuccess:^(Feedback *feedback) {
        [AlertTool showAlertWithConfirm:@"反馈成功,感谢您的宝贵意见" listener:self];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [AlertTool showText:error view:self.view];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_textView resignFirstResponder];
    [self performSelector:@selector(pop) withObject:nil afterDelay:0.5];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
