//
//  YJSearchRecordViewController.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchRecordViewController.h"
#import "YJSearchRecordManager.h"
#import "YJSearchRecordCell.h"
#import "YJSearchRecordFooterView.h"

#import <Masonry/Masonry.h>
#import <YJExtensions/YJExtensions.h>

@interface YJSearchRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *recordArr;

@end

@implementation YJSearchRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self layoutUI];
}
- (void)layoutUI{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    [headerView layoutIfNeeded];
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"历史记录";
    titleLab.textColor = [UIColor lightGrayColor];
    titleLab.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView.mas_left).offset(10);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self updateEmpty];
}

- (void)clearBtnAction{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[YJSearchRecordManager defaultManager] readSearchRecord]];
    [dic removeObjectForKey:[YJSearchRecordManager defaultManager].searchControllerName];
    [[YJSearchRecordManager defaultManager] writeSearchRecordWithRecordDic:dic];
    [self updateEmpty];
    [self.tableView reloadData];
}
- (void)updateEmpty{
    if (!self.recordArr || self.recordArr.count == 0) {
        [self setViewNoDataShow:YES];
    }else{
         [self setViewNoDataShow:NO];
    }
}
#pragma mark UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recordArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    YJSearchRecordFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([YJSearchRecordFooterView class])];
    __weak typeof(self) weakSelf = self;
    footerView.clearRecordBlock = ^{
        [weakSelf clearBtnAction];
    };
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJSearchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YJSearchRecordCell class])];
    cell.isShowSeparator = YES;
    if (indexPath.row == self.recordArr.count-1) {
        cell.separatorOffset = 0;
        cell.sepColor = [UIColor yj_colorWithHex:0xD7D7D7];
    }else{
        cell.separatorOffset = 10;
        cell.sepColor = [UIColor yj_colorWithHex:0xF0F0F0];
    }
    cell.titleStr = self.recordArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *record = self.recordArr[indexPath.row];
    self.recordBlock(record);
}
#pragma mark Property Init
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YJSearchRecordCell class] forCellReuseIdentifier:NSStringFromClass([YJSearchRecordCell class])];
        [_tableView registerClass:[YJSearchRecordFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([YJSearchRecordFooterView class])];
    }
    return _tableView;
}
- (NSArray *)recordArr{
    NSDictionary *dic = [[YJSearchRecordManager defaultManager] readSearchRecord];
    if (dic[[YJSearchRecordManager defaultManager].searchControllerName]) {
        _recordArr = dic[[YJSearchRecordManager defaultManager].searchControllerName];
    }else{
        _recordArr = nil;
    }
    return _recordArr;
}
@end
