//
//  GoodDetailViewController.m
//  shopping
//
//  Created by chentao on 15/12/7.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "GoodDetailViewController.h"

@interface GoodDetailViewController () <UIScrollViewDelegate, shoppingCartDelegate, SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *bannerScroll;
@property (weak, nonatomic) IBOutlet UILabel *lbGoodName;
@property (weak, nonatomic) IBOutlet UILabel *lbCurrentPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbSales;

@property (weak, nonatomic) IBOutlet UILabel *lbNumber;
@property (weak, nonatomic) IBOutlet UIButton *shoppingCartNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnShoppingCart;
@property (weak, nonatomic) IBOutlet UITextView *tvDescription;
@property (weak, nonatomic) IBOutlet UILabel *lbOldPrice;
@property (weak, nonatomic) IBOutlet UIView *lineView;

- (IBAction)btnCutClick:(UIButton *)sender;
- (IBAction)btnAddClick:(UIButton *)sender;
- (IBAction)btnAddToShoppingCartClick:(UIButton *)sender;
- (IBAction)btnShoppingCartClick:(UIButton *)sender;
- (IBAction)btnBackClick:(UIButton *)sender;
- (IBAction)btnShoppingCartNumberClick:(UIButton *)sender;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end

@implementation GoodDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    [self setupBannerView];
    
    UIImage *imageCart = [[UIImage imageNamed:@"shoppingCart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _btnShoppingCart.tintColor = [ColorTool getBlueColor];
    [_btnShoppingCart setBackgroundImage:imageCart forState:UIControlStateNormal];
   
    UIImage *image = [UIImage imageNamed:@"goodDetailBack"];
    [_btnBack setBackgroundImage:image forState:UIControlStateNormal];
    
    [_shoppingCartNumber setTitle: [NSString stringWithFormat:@"%ld", [ShoppingCartDao getTotalCount]]
                         forState:UIControlStateNormal];
    
    _lbGoodName.text = _good.name;
    _lbCurrentPrice.text = [NSString stringWithFormat:@"￥%.2f", [_good.price doubleValue]];
    _lbSales.text = [NSString stringWithFormat:@"销量 %ld", [_good.salesCount longValue]];
    _tvDescription.editable = NO;
    _tvDescription.text = _good.goodDescription;
    
    if (_good.discount == nil || [_good.discount doubleValue] == 1 ) {
        _lbOldPrice.hidden = YES;
        _lineView.hidden = YES;
    } else {
        _lbOldPrice.hidden = NO;
        _lineView.hidden = NO;
        _lbOldPrice.text = [NSString stringWithFormat:@"￥%.2f", [_good.showPrice doubleValue]];
    }
    
    _lbNumber.text = @"1";
}

- (void)setupBannerView
{
    if (_good.imagePathBig.count == 0) {
        return;
    }
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screenWidth, screenWidth) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.autoScroll = NO;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.currentPageDotColor = [UIColor blackColor];
    [_bannerScroll addSubview:cycleScrollView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = _good.imagePathBig;
    });
}

- (IBAction)btnAddClick:(UIButton *)sender
{
    NSInteger number = [_lbNumber.text integerValue];
    number++;
    _lbNumber.text = [NSString stringWithFormat:@"%ld", (long)number];
}

- (IBAction)btnCutClick:(UIButton *)sender
{
    NSInteger number = [_lbNumber.text integerValue];
    if (number == 1) {
        return;
    }
    number--;
    _lbNumber.text = [NSString stringWithFormat:@"%ld", (long)number];
}

- (void)refreshShoppingCart
{
    [_shoppingCartNumber setTitle:[NSString stringWithFormat:@"%ld", [ShoppingCartDao getTotalCount]] forState:UIControlStateNormal];
}

- (IBAction)btnAddToShoppingCartClick:(UIButton *)sender
{
    if (![UserTool isLogin]) {
        [NavTool gotoLoginVC:self];
        return;
    }
    
    ShoppingCartDetail *detail = [ShoppingCartModelTransformer toDbModel:_good count:[_lbNumber.text longLongValue]];
    
    if ([ShoppingCartDao addGood:detail]) {
        long count = [_shoppingCartNumber.titleLabel.text longLongValue];
        count += [_lbNumber.text longLongValue];
        [_shoppingCartNumber setTitle:[NSString stringWithFormat:@"%ld", count] forState:UIControlStateNormal];
    } else {
        [AlertTool showAlert:@"添加到购物车失败"];
    }
}

- (IBAction)btnShoppingCartClick:(UIButton *)sender
{
    if (![UserTool isLogin]) {
        [NavTool gotoLoginVC:self];
        return;
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ShoppingCart" bundle:nil];
    ShoppingCartViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ShoppingCart"];
    vc.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)btnBackClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([_delegate respondsToSelector:@selector(refreshShoppingCart)]) {
        [_delegate refreshShoppingCart];
    }
}

- (IBAction)btnShoppingCartNumberClick:(UIButton *)sender
{
    [self btnShoppingCartClick:sender];
}

@end
