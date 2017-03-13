//
//  PayViewController.m
//  shopping
//
//  Created by chentao on 15/12/21.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, WXApiDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) UIImage *checkedImage;
@property (nonatomic, retain) UIImage *uncheckedImage;

@property (nonatomic, retain) UIButton *btnAlipay;
@property (nonatomic, retain) UIButton *btnWeixin;

@property (nonatomic, assign) BOOL isAlipay;

- (IBAction)btnPayClick:(UIButton *)sender;

@end

@implementation PayViewController

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
    _isAlipay = YES;
}

- (void)initView
{
    self.title = @"支付";
    
    _checkedImage = [[UIImage imageNamed:@"checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _uncheckedImage = [[UIImage imageNamed:@"unchecked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    self.navigationItem.leftBarButtonItem = btn;
}

- (void)back
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"要取消订单吗" delegate:self cancelButtonTitle:nil otherButtonTitles:@"不要", @"要", nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 5555) {
        if (_fromOrderDetail) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [ShoppingCartDao deleteAll];
            [_vc dismissViewControllerAnimated:YES completion:nil];
        }
        return;
    }
    
    if (buttonIndex == 1) {
        OrderHeader *orderHeader = [OrderHeader new];
        orderHeader.orderId = _orderHeader.orderId;
        orderHeader.lockVersion = _orderHeader.lockVersion;
        
        [OrderService cancelOrder:orderHeader onSuccess:^(OrderHeader *orderHeader) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } onFail:^(NSString *error, NSInteger statusCode) {
            [AlertTool showText:@"取消订单失败" view:self.view];
        }];
    }
}

- (IBAction)btnPayClick:(UIButton *)sender
{
    if (_isAlipay) {
        [self payWithAlipay];
    } else {
        [self payWithWeixin];
    }
}

//支付宝支付
- (void)payWithAlipay
{
    AppUser *appUser = [UserTool getUser];
    
    AlipaySignSo *so = [AlipaySignSo new];
    so.userId = appUser.userId;
    so.orderNo =_orderHeader.orderNo;
    
    __block NSString *payResult = nil;
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [OrderService signForAlipay:so onSuccess:^(NSString *signString) {
        [SVProgressHUD dismiss];

        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        delegate.orderHeader = _orderHeader;
        [[AlipaySDK defaultService] payOrder:signString fromScheme:@"gof.shopping.scheme" callback:^(NSDictionary *resultDic) {
            NSString *resultString = resultDic[@"result"];
            NSArray *resultStrArray = [resultString componentsSeparatedByString:NSLocalizedString(@"&", nil)];
            
            for (NSString *str in resultStrArray) {
                NSString *newString = nil;
                newString = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                NSArray *strArray = [newString componentsSeparatedByString:NSLocalizedString(@"=", nil)];
                for (int i = 0; i < strArray.count; i++) {
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
                
                [AlertTool showAlertWithConfirm:@"订单支付成功" tag:5555 listener:self];
            } else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {//用户取消支付

            } else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]) {//网络连接错误
                [AlertTool showText:@"网络连接错误" view:self.view];
            } else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {//订单支付失败
                [AlertTool showText:@"订单支付失败" view:self.view];
            } else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]) {//正在处理中
                [AlertTool showText:@"订单正在处理" view:self.view];
            } else {
                [AlertTool showText:@"订单支付失败" view:self.view];
            }
        }];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

//微信支付
- (void)payWithWeixin
{
    if (![WXApi isWXAppInstalled]) {
        [AlertTool showText:@"请先安装微信" view:self.view];
        return;
    }
    
    if (![WXApi isWXAppSupportApi]) {
        [AlertTool showText:@"微信版本太低,请更新微信" view:self.view];
        return;
    }
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    delegate.wxDelegate = self;
    
    AppUser *appUser = [UserTool getUser];
    
    WeixinSignSo *so = [WeixinSignSo new];
    so.userId = appUser.userId;
    so.orderNo = _orderHeader.orderNo;
    so.lockVersion = _orderHeader.lockVersion;
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [OrderService signForWxpay:so onSuccess:^(WeixinSignInfo *signInfo) {
        [SVProgressHUD dismiss];
        PayReq *request = [PayReq new];
        
        request.partnerId = signInfo.partnerid;
        request.prepayId = signInfo.prepayid;
        request.package = signInfo.package;
        request.nonceStr = signInfo.noncestr;
        request.timeStamp = [signInfo.timestamp intValue];
        request.sign = signInfo.sign;
        
        [WXApi sendReq:request];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

- (void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp*)resp;
        
        switch (response.errCode) {
            case WXSuccess:
                [AlertTool showAlertWithConfirm:@"订单支付成功" tag:5555 listener:self];
                break;
            case WXErrCodeUserCancel:
                break;
            default:
                NSLog(@"支付失败,retcode=%d", resp.errCode);
                [AlertTool showText:@"支付失败" view:self.view];
                break;
        }
    }
}

#pragma mark - tableView接口

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    } else {
        return 55;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"支付方式";
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    if (title == nil) {
        return nil;
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [ColorTool getTableViewSectionColor];
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, 200, 20)];
    lbTitle.text = title;
    lbTitle.textColor = [UIColor darkGrayColor];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:12];
    
    [view addSubview:lbTitle];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"totalPriceCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"totalPriceCell"];
            UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake((screen_width-100)/2, 12, 100, 30)];
            lbTitle.textAlignment = NSTextAlignmentCenter;
            lbTitle.font = [UIFont systemFontOfSize:13];
            lbTitle.textColor = [UIColor darkGrayColor];
            lbTitle.tag = 1000;
            
            UILabel *lbPrice = [[UILabel alloc] initWithFrame:CGRectMake((screen_width-100)/2, 40, 100, 30)];
            lbPrice.textAlignment = NSTextAlignmentCenter;
            lbPrice.font = [UIFont boldSystemFontOfSize:18];
            lbPrice.textColor = [UIColor orangeColor];
            lbPrice.tag = 1001;
            
            [cell.contentView addSubview:lbTitle];
            [cell.contentView addSubview:lbPrice];
        }
        
        UILabel *lbTitle = [cell.contentView viewWithTag:1000];
        UILabel *lbPrice = [cell.contentView viewWithTag:1001];
        lbTitle.text = @"总价格";
        lbPrice.text = [NSString stringWithFormat:@"￥%.2f", _orderHeader.paidPrice];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"payCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.row == 0) {
                _btnAlipay = [[UIButton alloc] initWithFrame:CGRectMake(screen_width-41, 17.5, 20, 20)];
                _btnAlipay.tintColor = [ColorTool getNavColor];
                [_btnAlipay addTarget:self action:@selector(btnAlipayClick:) forControlEvents:UIControlEventTouchUpInside];
                [_btnAlipay setBackgroundImage:_checkedImage forState:UIControlStateNormal];
                [cell.contentView addSubview:_btnAlipay];
            } else {
                _btnWeixin = [[UIButton alloc] initWithFrame:CGRectMake(screen_width-41, 17.5, 20, 20)];
                _btnWeixin.tintColor = [ColorTool getNavColor];
                [_btnWeixin addTarget:self action:@selector(btnWeixinClick:) forControlEvents:UIControlEventTouchUpInside];
                [_btnWeixin setBackgroundImage:_uncheckedImage forState:UIControlStateNormal];
                [cell.contentView addSubview:_btnWeixin];
            }
        }
        
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"alipay"];
            cell.textLabel.text = @"支付宝支付";
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.text = @"最便捷,最安全!";
            cell.detailTextLabel.textColor = [UIColor darkGrayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        } else {
            cell.imageView.image = [UIImage imageNamed:@"weixin"];
            cell.textLabel.text = @"微信支付";
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.text = @"在微信中绑定银行卡的用户可以使用";
            cell.detailTextLabel.textColor = [UIColor darkGrayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        }
        
        return cell;
    }
    
    return [UITableViewCell new];
}

- (void)btnAlipayClick:(UIButton*)sender
{
    _isAlipay = YES;
    [sender setBackgroundImage:_checkedImage forState:UIControlStateNormal];
    [_btnWeixin setBackgroundImage:_uncheckedImage forState:UIControlStateNormal];
}

- (void)btnWeixinClick:(UIButton*)sender
{
    _isAlipay = NO;
    [sender setBackgroundImage:_checkedImage forState:UIControlStateNormal];
    [_btnAlipay setBackgroundImage:_uncheckedImage forState:UIControlStateNormal];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        _isAlipay = YES;
        [_btnAlipay setBackgroundImage:_checkedImage forState:UIControlStateNormal];
        [_btnWeixin setBackgroundImage:_uncheckedImage forState:UIControlStateNormal];
    } else {
        _isAlipay = NO;
        [_btnWeixin setBackgroundImage:_checkedImage forState:UIControlStateNormal];
        [_btnAlipay setBackgroundImage:_uncheckedImage forState:UIControlStateNormal];
    }
}

@end
