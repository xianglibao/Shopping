//
//  NavTool.m
//  shopping
//
//  Created by chentao on 16/1/13.
//  Copyright © 2016年 gof. All rights reserved.
//

#import "NavTool.h"

@implementation NavTool

+ (void)gotoLoginVC:(UIViewController*)viewControl
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Login"];
    vc.delegate = (id<LoginDelegate>)viewControl;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [viewControl presentViewController:nav animated:YES completion:nil];
}

@end
