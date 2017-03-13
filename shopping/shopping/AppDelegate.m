//
//  AppDelegate.m
//  shopping
//
//  Created by chentao on 15/11/12.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "MMDrawerController.h"
#import "LeftCategoryMenuViewController.h"
#import "MainViewController.h"

static OrderHeader *orderHeader;

@interface AppDelegate () <WXApiDelegate>

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initNavigationBar];
    
    [WXApi registerApp:@"wxa5e3ef223b01eb69"];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    MainViewController * centerVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"Main"];
    UINavigationController * centerNav = [[UINavigationController alloc] initWithRootViewController:centerVC];
    centerNav.navigationBar.translucent = NO;
    [centerNav setRestorationIdentifier:@"MainVCRestorationKey"];
    
    
    LeftCategoryMenuViewController * leftVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LeftMenu"];
    UINavigationController * leftNav = [[UINavigationController alloc] initWithRootViewController:leftVC];
    leftVC.mainNav = centerNav;
    leftNav.navigationBar.translucent = NO;
    [leftNav setRestorationIdentifier:@"LeftVCRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:centerNav
                             leftDrawerViewController:leftNav];
    
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:screen_width-18];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeCustom];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeCustom];
    
//    [self.drawerController
//     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//         MMDrawerControllerDrawerVisualStateBlock block;
//         block = [[MMExampleDrawerVisualStateManager sharedManager]
//                  drawerVisualStateBlockForDrawerSide:drawerSide];
//         if(block){
//             block(drawerController, drawerSide, percentVisible);
//         }
//     }];
    
    [self.drawerController
     setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
         BOOL shouldRecognizeTouch = NO;
         if ((drawerController.openSide == MMDrawerSideNone || drawerController.openSide == MMDrawerSideLeft) &&
            [gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
             UINavigationController *nav = (UINavigationController *)drawerController.centerViewController;
             
             if ([nav.topViewController isKindOfClass:[MainViewController class]]) {
                 shouldRecognizeTouch = YES;
             } else {
                 shouldRecognizeTouch = NO;
             }
         }
         return shouldRecognizeTouch;
     }];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.window setRootViewController:self.drawerController];
    [self.window makeKeyAndVisible];
    
    [NSThread sleepForTimeInterval:0.5];
    
    return YES;
}

- (void)initNavigationBar
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance]setBarTintColor:[ColorTool getNavColor]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName, nil]];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        __block NSString *payResult = nil;
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *resultString = resultDic[@"result"];
            NSArray *resultStrArray = [resultString componentsSeparatedByString:NSLocalizedString(@"&", nil)];
            
            for (NSString *str in resultStrArray) {
                NSString *newString = nil;
                newString = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                NSArray *strArray = [newString componentsSeparatedByString:NSLocalizedString(@"=", nil)];
                for (int i=0; i < strArray.count; i++) {
                    NSString *st = strArray[i];
                    if ([st isEqualToString:@"success"]) {
                        NSLog(@"%@", strArray[1]);
                        payResult = strArray[1];
                    }
                }
            }
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"] && [payResult isEqualToString:@"true"]) {//支付成功
                OrderHeader *orderHeader = [OrderHeader new];
                orderHeader.orderId = _orderHeader.orderId;
                orderHeader.paymentType = @"ALIPAY";
                orderHeader.lockVersion = _orderHeader.lockVersion;
                
                [OrderService submitClientPayResult:orderHeader onSuccess:^(OrderHeader *orderHeader) {
                    
                } onFail:^(NSString *error, NSInteger statusCode) {
                    
                }];
            } else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {//用户取消支付
                [AlertTool showAlert:@"用户中途取消"];
            } else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]) {//网络连接错误
                [AlertTool showAlert:@"网络连接错误"];
            } else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {//订单支付失败
                [AlertTool showAlert:@"订单支付失败"];
            } else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]) {//正在处理中
                [AlertTool showAlert:@"订单正在处理"];
            } else {
                [AlertTool showAlert:@"订单支付失败"];
            }
        }];
        return YES;
    }
    return [WXApi handleOpenURL:url delegate:_wxDelegate];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:_wxDelegate];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
