//
//  MainViewController.m
//  shopping
//
//  Created by chentao on 15/11/27.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, goodSectionHeaderDelegate, goodCellDelegate, shoppingCartDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectView;

@property (nonatomic, retain) NSMutableArray *categoryInfoList;

@property (nonatomic, retain) UILabel *lbCount;
@property (nonatomic, retain) UIBarButtonItem *categoryBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIButton *btnCategory;
@property (weak, nonatomic) IBOutlet UILabel *lbCategoryTitle;

@property (nonatomic, retain) CSAnimationView *floatingView;

- (IBAction)btnGoToCategoryClick:(UIButton *)sender;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _categoryInfoList = [NSMutableArray new];
    
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (_category == nil) {
        self.navigationItem.leftBarButtonItem = _categoryBtn;
        _titleViewHeightConstraint.constant = 0;
        _lbCategoryTitle.hidden = YES;
        _btnCategory.hidden = YES;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        _lbCategoryTitle.text = _category.name;
    }
    
    [self refreshShoppingCart];
}

- (void)initView
{
    self.title = @"商品列表";
    
    _categoryBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_category"] style:UIBarButtonItemStyleBordered target:self action:@selector(showCategory)];
    self.navigationItem.leftBarButtonItem = _categoryBtn;
    
    UIBarButtonItem *profileBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_person"] style:UIBarButtonItemStyleBordered target:self action:@selector(enterMyProfile)];
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_search"] style:UIBarButtonItemStyleBordered target:self action:@selector(searchGood)];
    
    self.navigationItem.rightBarButtonItems = @[profileBtn, searchBtn];
    
    UIImage *icon = [[UIImage imageNamed:@"nav_blackCategory"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _btnCategory.tintColor = [ColorTool getNavColor];
    [_btnCategory setBackgroundImage:icon forState:UIControlStateNormal];
    
    _collectView.dataSource = self;
    _collectView.delegate = self;
    _collectView.backgroundColor = [ColorTool getTableViewSectionColor];
    
    UINib *cellNib = [UINib nibWithNibName:@"GoodCollectionViewCell" bundle:nil];
    UINib *headerNib = [UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil];
    [_collectView registerNib:cellNib forCellWithReuseIdentifier:@"GoodCell"];
    [_collectView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
    [self createFloatingShoppingCart];
    
    _collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initData];
        [_collectView.mj_header endRefreshing];
    }];
}

- (void)initData
{
    CategorySo *so = [CategorySo new];
    if (_category != nil) {
        so.parentId = _category.categoryId;
    }
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [GoodService fetchGoodList:so onSuccess:^(NSArray *categoryInfoList) {
        [SVProgressHUD dismiss];
        [_categoryInfoList removeAllObjects];
        [_categoryInfoList addObjectsFromArray:categoryInfoList];
        [_collectView reloadData];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error];
    }];
}

- (void)enterMyProfile
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MyProfile" bundle:nil];
    MyProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MyProfile"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showCategory
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)btnGoToCategoryClick:(UIButton *)sender
{
    [self showCategory];
}

- (void)searchGood
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GoodSearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"GoodSearch"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showAll:(CategoryInfo *)category
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
    
    vc.category = category;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addToShoppingCart:(Good *)good
{
    if (![UserTool isLogin]) {
        [NavTool gotoLoginVC:self];
        return;
    }
    
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
    if (![UserTool isLogin]) {
        [NavTool gotoLoginVC:self];
        return;
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ShoppingCart" bundle:nil];
    ShoppingCartViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ShoppingCart"];
    vc.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    
    //[self.navigationController setViewControllers:@[vc]];
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
    return _categoryInfoList.count;
}

#pragma mark - 设置每个section中的cell数量

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CategoryInfo *category = (CategoryInfo*)_categoryInfoList[section];
    return category.goodList.count;
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

#pragma mark - 设置sectionHeader的尺寸

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    if (_category.levelTypeId.longValue == 3) {
        return CGSizeMake(0, 0);
    }
    
    return CGSizeMake(screenWidth, 36);
}

#pragma mark - 生成sectionHeader

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];

    CategoryInfo *categoryInfo = (CategoryInfo*)(_categoryInfoList[indexPath.section]);
    
    [headerView setData:categoryInfo];
    headerView.delegate = self;
    
    return headerView;
}

#pragma mark - 设置cell的尺寸

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

    return CGSizeMake((screenWidth)/3, (screenWidth)/3 + 69);
}

#pragma mark - 生成cell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodCollectionViewCell *cell = [_collectView dequeueReusableCellWithReuseIdentifier:@"GoodCell" forIndexPath:indexPath];
    
    CategoryInfo *categoryInfo = _categoryInfoList[indexPath.section];
    Good *good = categoryInfo.goodList[indexPath.row];
    
    cell.delegate = self;
    [cell setData:good];
    
    return cell;
}

#pragma mark - cell点击事件

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GoodDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"GoodDetail"];
    vc.delegate = self;
    
    CategoryInfo *categoryInfo = _categoryInfoList[indexPath.section];
    Good *good = categoryInfo.goodList[indexPath.row];
    
    vc.good = good;
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end