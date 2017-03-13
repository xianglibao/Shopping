//
//  AddressSearchViewController.m
//  shopping
//
//  Created by chentao on 15/11/24.
//  Copyright © 2015年 gof. All rights reserved.
//

#import "AddressSearchViewController.h"

@interface AddressSearchViewController () <AMapSearchDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) AMapSearchAPI *search;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *searchTips;
@property (nonatomic, retain) NSMutableArray *searchResult;
@property (nonatomic, retain) NSMutableArray *resultAddress;
@property (nonatomic, assign) BOOL isTipMode;

- (IBAction)btnSearchClick:(UIButton *)sender;

@end

@implementation AddressSearchViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_searchBar becomeFirstResponder];
}

- (void)initData
{
    _searchTips = [NSMutableArray new];
    _searchResult = [NSMutableArray new];
    _resultAddress = [NSMutableArray new];
}

- (void)initView
{
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [ColorTool getTableViewSectionColor];
    
    _searchBar.delegate = self;
    
    [AMapSearchServices sharedServices].apiKey = @"2a071a12656100d0da7a9835f37109e5";
    
    _search = [AMapSearchAPI new];
    _search.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    tipsRequest.keywords = searchText;
    tipsRequest.city = @"杭州";
    
    [_search AMapInputTipsSearch: tipsRequest];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    AMapPOIKeywordsSearchRequest *poiRequest = [[AMapPOIKeywordsSearchRequest alloc] init];
    poiRequest.keywords = _searchBar.text;
    poiRequest.city = @"杭州";
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [_search AMapPOIKeywordsSearch: poiRequest];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    _isTipMode = YES;
    return YES;
}

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request
                     response:(AMapInputTipsSearchResponse *)response
{
    if (response.tips.count == 0) {
        return;
    }
    
    [_searchTips removeAllObjects];
    
    for (AMapTip *tip in response.tips) {
        [_searchTips addObject:tip.name];
    }
    
    [_tableView reloadData];
}

- (IBAction)btnSearchClick:(UIButton *)sender
{
    [_searchBar resignFirstResponder];
    
    AMapPOIKeywordsSearchRequest *poiRequest = [[AMapPOIKeywordsSearchRequest alloc] init];
    poiRequest.keywords = _searchBar.text;
    poiRequest.city = @"杭州";
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    [_search AMapPOIKeywordsSearch: poiRequest];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [SVProgressHUD dismiss];
    _isTipMode = NO;
    
    if (response.count == 0) {
        return;
    }
    
    [_searchResult removeAllObjects];
    [_resultAddress removeAllObjects];
    for (AMapPOI *p in response.pois) {
        [_searchResult addObject:p.name];
        [_resultAddress addObject:p.address];
    }
    
    [_tableView reloadData];
}

#pragma mark - tableView接口

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isTipMode) {
        return _searchTips.count;
    } else {
        return _searchResult.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tipCell"];
    }
    
    if (_isTipMode) {
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = _searchTips[indexPath.row];
        cell.detailTextLabel.text = nil;
    } else {
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.text = _searchResult[indexPath.row];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.text = _resultAddress[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isTipMode) {
        [_searchBar resignFirstResponder];
        
        AMapPOIKeywordsSearchRequest *poiRequest = [[AMapPOIKeywordsSearchRequest alloc] init];
        poiRequest.keywords = _searchTips[indexPath.row];
        poiRequest.city = @"杭州";
        
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD show];
        [_search AMapPOIKeywordsSearch: poiRequest];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
        if ([_delegate respondsToSelector:@selector(addressSelected:)]) {
            [_delegate addressSelected:_searchResult[indexPath.row]];
        }
    }
}

@end
