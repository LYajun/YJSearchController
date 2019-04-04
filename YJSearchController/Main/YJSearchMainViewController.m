//
//  YJSearchMainViewController.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchMainViewController.h"
#import "YJSearchRecordViewController.h"
#import "YJSearchMatchViewController.h"

#import "YJSearchManager.h"
#import "YJSearchBar.h"
#import "YJSearchRecordManager.h"

#import <YJExtensions/YJExtensions.h>
#import <Masonry/Masonry.h>
#import <LGAlertHUD/LGAlertHUD.h>

@interface YJSearchMainViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) YJSearchBar *searchBar;
@property (nonatomic,strong) YJSearchRecordViewController *recordVC;
@property (nonatomic,strong) YJSearchMatchViewController *matchVC;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *searchBtn;
@end

@implementation YJSearchMainViewController
- (void)loadView{
    [super loadView];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    [self layoutUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.searchBar.text = [YJSearchManager defaultManager].searchStr;
    if ([YJSearchManager defaultManager].searchStr.length > 0) {
        self.matchVC.searchStr = [YJSearchManager defaultManager].searchStr;
        [self.scrollView layoutIfNeeded];
        self.scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
    }else{
        self.scrollView.contentOffset = CGPointZero;
    }
    [self.searchBar becomeFirstResponder];
}
- (void)layoutUI{
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIView *scrollContentView = [UIView new];
    [self.scrollView addSubview:scrollContentView];
    [scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.height.equalTo(self.scrollView);
        make.width.mas_equalTo(screenWidth * 2);
    }];
   
    [scrollContentView addSubview:self.recordVC.view];
    [self.recordVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerY.left.equalTo(scrollContentView);
        make.width.mas_equalTo(screenWidth);
    }];
    
    [scrollContentView addSubview:self.matchVC.view];
    [self.matchVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerY.equalTo(scrollContentView);
        make.left.equalTo(scrollContentView).offset(screenWidth);
        make.width.mas_equalTo(screenWidth);
    }];
}

- (void)searchBtnAction:(UIButton *) btn{
    if (self.searchBar.text.length > 0) {
        if ([YJSearchManager defaultManager].searchStrBlock) {
            [YJSearchManager defaultManager].searchStrBlock(self.searchBar.text);
        }
        [[YJSearchRecordManager defaultManager] insertSearchRecordWithRecord:self.searchBar.text];
        [self navBar_leftItemPressed];
    }else{
        [LGAlert showInfoWithStatus:@"输入不能为空"];
    }
}

#pragma mark UITextField Delegate
- (void)textFieldDidChange:(UITextField *) textField{
    UITextRange *selectedRange = [textField markedTextRange];
    NSString *newText = [textField textInRange:selectedRange];
    if (newText.length <= 0) {
        if (textField.text.length > 0) {
            self.matchVC.searchStr = textField.text;
            self.scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
        }else{
            self.scrollView.contentOffset = CGPointZero;
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length > 0) {
        [self searchBtnAction:nil];
        [textField resignFirstResponder];
    }else{
        [LGAlert showInfoWithStatus:@"输入不能为空"];
    }
    return NO;
}

#pragma mark - Getter
- (UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame =  CGRectMake(0, 0, 36, 28);
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}
- (YJSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[YJSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width-90, 26)];
        _searchBar.delegate = self;
        [_searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchBar;
}
- (YJSearchRecordViewController *)recordVC{
    if (!_recordVC) {
        _recordVC = [[YJSearchRecordViewController alloc] init];
        __weak typeof(self) weakSelf = self;
        _recordVC.recordBlock = ^(NSString *record){
            if ([YJSearchManager defaultManager].searchStrBlock) {
                [YJSearchManager defaultManager].searchStrBlock(record);
            }
            [weakSelf navBar_leftItemPressed];
        };
    }
    return _recordVC;
}
- (YJSearchMatchViewController *)matchVC{
    if (!_matchVC) {
        _matchVC = [[YJSearchMatchViewController alloc] init];
        _matchVC.searchMatchArray = [YJSearchManager defaultManager].searchMatchArray;
        __weak typeof(self) weakSelf = self;
        _matchVC.resultBlock = ^(NSString *result){
            if ([YJSearchManager defaultManager].searchStrBlock) {
                [YJSearchManager defaultManager].searchStrBlock(result);
            }
            [weakSelf navBar_leftItemPressed];
        };
    }
    return _matchVC;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}
@end
