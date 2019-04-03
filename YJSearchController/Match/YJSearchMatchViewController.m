//
//  YJSearchMatchViewController.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchMatchViewController.h"
#import "YJChineseInclude.h"
#import "YJPinYinForObjc.h"
#import "YJSearchRecordCell.h"
#import "YJSearchRecordManager.h"
#import <Masonry/Masonry.h>
#import <YJExtensions/YJExtensions.h>

@interface YJSearchMatchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *resultArr;

@end

@implementation YJSearchMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self iniUI];
}
- (void)iniUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)setSearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
    NSMutableArray *searchDataArr = [NSMutableArray array];
    if (searchStr && searchStr.length > 0  &&
        self.searchMatchArray && self.searchMatchArray.count > 0) {
        if (![YJChineseInclude isIncludeChineseInString:searchStr]) {
            for (int i=0; i<self.searchMatchArray.count; i++) {
                if ([YJChineseInclude isIncludeChineseInString:self.searchMatchArray[i]]) {
                    NSString *tempPinYinStr = [YJPinYinForObjc chineseConvertToPinYin:self.searchMatchArray[i]];
                    NSRange titleResult=[tempPinYinStr rangeOfString:searchStr options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0) {
                        if (![searchDataArr containsObject:self.searchMatchArray[i]]) {
                            [searchDataArr addObject:self.searchMatchArray[i]];
                        }
                    }else{
                        NSString *tempPinYinHeadStr = [YJPinYinForObjc chineseConvertToPinYinHead:self.searchMatchArray[i]];
                        NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:searchStr options:NSCaseInsensitiveSearch];
                        if (titleHeadResult.length>0) {
                            if (![searchDataArr containsObject:self.searchMatchArray[i]]) {
                                [searchDataArr addObject:self.searchMatchArray[i]];
                            }
                        }
                    }
                }else {
                    NSRange titleResult=[self.searchMatchArray[i] rangeOfString:searchStr options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0) {
                        if (![searchDataArr containsObject:self.searchMatchArray[i]]) {
                            [searchDataArr addObject:self.searchMatchArray[i]];
                        }
                    }
                }
            }
        }else{
            for (NSString *tempStr in self.searchMatchArray) {
                NSRange titleResult=[tempStr rangeOfString:searchStr options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    if (![searchDataArr containsObject:tempStr]) {
                        [searchDataArr addObject:tempStr];
                    }
                }
            }
            
        }
    }
    
    self.resultArr = searchDataArr;
    [self.tableView reloadData];
}

#pragma mark UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJSearchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YJSearchRecordCell class])];
    if (self.resultArr && self.resultArr.count > 0) {
        cell.isShowSeparator = YES;
    }
    cell.titleStr = self.resultArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *result = self.resultArr[indexPath.row];
    [[YJSearchRecordManager defaultManager] insertSearchRecordWithRecord:result];
    self.resultBlock(result);
}
#pragma mark Property Init
- (NSArray *)resultArr{
    if (!self.searchStr || self.searchStr.length == 0) {
        _resultArr = self.searchMatchArray;
    }
    return _resultArr;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        [_tableView registerClass:[YJSearchRecordCell class] forCellReuseIdentifier:NSStringFromClass([YJSearchRecordCell class])];
    }
    return _tableView;
}

@end
