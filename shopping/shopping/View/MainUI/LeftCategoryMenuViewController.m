//
//  LeftCategoryMenuViewController.m
//  shopping
//
//  Created by chentao on 15/12/8.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "LeftCategoryMenuViewController.h"

@interface LeftCategoryMenuViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, retain) NSMutableArray *categoryInfoList;
@property (nonatomic, assign) NSInteger rootCategoryIndex;

@end

@implementation LeftCategoryMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"商品分类";
    
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initData
{
    _rootCategoryIndex = 0;
    _categoryInfoList = [NSMutableArray new];
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [GoodService FetchAllCategory:[CategorySo new] onSuccess:^(NSArray *categoryInfoList) {
        [SVProgressHUD dismiss];
        [_categoryInfoList addObjectsFromArray:categoryInfoList];
        [_tableView reloadData];
        [self setSelectedCellStyle:[NSIndexPath indexPathForRow:0 inSection:0]];
        [_collectionView reloadData];
    } onFail:^(NSString *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
        [AlertTool showText:error];
    }];
}

- (void)initView
{
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CategoryCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
}

- (void)cancel
{
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

- (void)setSelectedCellStyle:(NSIndexPath *)indexPath
{
    for (int i = 0; i<_categoryInfoList.count; i++) {
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (i == indexPath.row) {
            cell.textLabel.textColor = [ColorTool getGreenTextColor];
        } else {
            cell.textLabel.textColor = [UIColor darkGrayColor];
        }
    }
}

#pragma mark - tableView接口

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _categoryInfoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CategoryInfo *category = (CategoryInfo*)(_categoryInfoList[indexPath.row]);

    cell.textLabel.text = category.name;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _rootCategoryIndex = indexPath.row;
    [self setSelectedCellStyle:indexPath];
    [_collectionView reloadData];
}

#pragma mark - collectionView接口

#pragma mark - 设置sectionHeader数量

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (_categoryInfoList == nil || _categoryInfoList.count == 0) {
        return 0;
    }
    CategoryInfo *category = _categoryInfoList[_rootCategoryIndex];
    
    return category.subCategoryList.count;
}

#pragma mark - 设置每个section中的cell数量

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CategoryInfo *category = _categoryInfoList[_rootCategoryIndex];
    CategoryInfo *level2category = category.subCategoryList[section];
    
    return level2category.subCategoryList.count;
}

#pragma mark - 设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - 设置每个item水平间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - 设置每个item垂直间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - 设置每个sectionHeader的尺寸

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(screen_width, 30);
}

#pragma mark - 生成sectionHeader

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    headerView.btnShowAll.hidden = YES;
    headerView.backgroundColor = [UIColor clearColor];
    
    CategoryInfo *category = _categoryInfoList[_rootCategoryIndex];
    CategoryInfo *level2category = category.subCategoryList[indexPath.section];
    
    [headerView setData:level2category];
    
    return headerView;
}

#pragma mark - 设置每个cell的尺寸

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((screen_width-90-18)/3, (screen_width-90-18)/3 + 30);
}

#pragma mark - 生成每个cell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    CategoryInfo *category = _categoryInfoList[_rootCategoryIndex];
    CategoryInfo *level2category = category.subCategoryList[indexPath.section];
    CategoryInfo *level3category = level2category.subCategoryList[indexPath.row];
    
    [cell setData:level3category];
    
    return cell;
}

#pragma mark - 点击item方法进入商品展示页面

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
    
    CategoryInfo *category = _categoryInfoList[_rootCategoryIndex];
    CategoryInfo *level2category = category.subCategoryList[indexPath.section];
    CategoryInfo *level3category = level2category.subCategoryList[indexPath.row];
    
    vc.category = level3category;
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    [_mainNav pushViewController:vc animated:YES];
}

@end
