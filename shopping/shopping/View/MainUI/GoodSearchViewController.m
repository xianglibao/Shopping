//
//  SearchViewController.m
//  shopping
//
//  Created by chentao on 15/12/1.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "GoodSearchViewController.h"

@interface GoodSearchViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, goodCellDelegate, shoppingCartDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) NSMutableArray *goodList;

@property (nonatomic, retain) UILabel *lbCount;
@property (nonatomic, retain) UIBarButtonItem *categoryBtn;

@property (nonatomic, retain) CSAnimationView *floatingView;

@end

@implementation GoodSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [_searchBar becomeFirstResponder];
}

- (void)initView
{
    self.title = @"商品查询";
    
    _searchBar.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [ColorTool getTableViewSectionColor];
    
    UINib *cellNib = [UINib nibWithNibName:@"GoodCollectionViewCell" bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"GoodCell"];
    
    [self createFloatingShoppingCart];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    _goodList = [NSMutableArray new];
    
    GoodSo *so = [GoodSo new];
    so.name = _searchBar.text;
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [GoodService searchGood:so onSuccess:^(NSArray *goodList) {
        [SVProgressHUD dismiss];
        if (goodList == nil || goodList.count == 0) {
            ;
        }
        [_goodList addObjectsFromArray:goodList];
        [_collectionView reloadData];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error view:self.view];
    }];
}

- (void)addToShoppingCart:(Good *)good
{
    ShoppingCartDetail *detail = [ShoppingCartModelTransformer toDbModel:good];
    
    if ([ShoppingCartDao addGood:detail]) {
        [_floatingView startCanvasAnimation];
        long totalCount = [_lbCount.text longLongValue];
        totalCount++;
        _lbCount.text = [NSString stringWithFormat:@"%ld", totalCount];
    } else {
        [AlertTool showText:@"添加到购物车失败"];
    }
}

#pragma mark - 创建浮动的购物车

- (void)createFloatingShoppingCart
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat floatingViewWidth = screenWidth / 4;
    CGFloat floatingViewHeight = floatingViewWidth / 2;
    CGFloat floatingViewXAxis = screenWidth - 10 - floatingViewWidth;
    CGFloat floatingViewYAxis = screenHeight - 120 - floatingViewHeight;
    
    _floatingView = [[CSAnimationView alloc] initWithFrame:CGRectMake(floatingViewXAxis, floatingViewYAxis, floatingViewWidth, floatingViewHeight)];
    
    //_floatingView.alpha = 0.8;
    _floatingView.duration = 0.5;
    _floatingView.delay = 0;
    _floatingView.type = CSAnimationTypeMorph;
    
    _floatingView.layer.cornerRadius = 15;
    _floatingView.backgroundColor = [ColorTool getBlueColor];
    _floatingView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterShoppingCart:)];
    [_floatingView addGestureRecognizer:tap];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(12, 6, floatingViewHeight-12, floatingViewHeight-12)];
    [btn setBackgroundImage:[UIImage imageNamed:@"shoppingCartWhite"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(enterShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
    
    _lbCount = [[UILabel alloc] initWithFrame:CGRectMake(floatingViewWidth/2, 0, floatingViewWidth/2, floatingViewHeight)];
    _lbCount.backgroundColor = [UIColor clearColor];
    _lbCount.text = @"0";
    _lbCount.textColor = [UIColor whiteColor];
    _lbCount.font = [UIFont systemFontOfSize:12];
    _lbCount.textAlignment = NSTextAlignmentCenter;
    
    [_floatingView addSubview:btn];
    [_floatingView addSubview:_lbCount];
    
    [self.view addSubview:_floatingView];
    
    _lbCount.text = [NSString stringWithFormat:@"%ld", [ShoppingCartDao getTotalCount]];
}

- (void)enterShoppingCart:(UITapGestureRecognizer*)gesture
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ShoppingCart" bundle:nil];
    ShoppingCartViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ShoppingCart"];
    vc.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)refreshShoppingCart
{
    _lbCount.text = [NSString stringWithFormat:@"%ld", [ShoppingCartDao getTotalCount]];
}

#pragma mark - collectionView接口
#pragma mark - 设置section的数量

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - 设置每个section中的cell数量

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _goodList.count;
}

#pragma mark - 设置每个cell的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - 设置每个cell的水平间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - 设置每个cell的垂直间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - 设置cell的尺寸

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((screen_width)/3, (screen_width)/3 + 69);
}

#pragma mark - 生成cell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodCell" forIndexPath:indexPath];
    
    cell.delegate = self;
    [cell setData:_goodList[indexPath.row]];
    
    return cell;
}

#pragma mark - cell点击事件

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GoodDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"GoodDetail"];
    vc.delegate = self;
    
    vc.good = _goodList[indexPath.row];
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
