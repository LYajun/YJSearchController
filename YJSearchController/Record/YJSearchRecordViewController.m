//
//  YJSearchRecordViewController.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchRecordViewController.h"
#import "YJSearchRecordManager.h"
//#import "YJSearchRecordCell.h"
//#import "YJSearchRecordFooterView.h"

#import <Masonry/Masonry.h>
#import <YJExtensions/YJExtensions.h>
#import "YJSearchRecordFlowLayout.h"
#import "YJSearchRecordFlowCell.h"

@interface YJSearchRecordViewController ()<YJSearchRecordFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (strong,nonatomic) NSArray *recordArr;
@property (nonatomic,strong) UIButton *clearBtn;
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
    titleLab.text = @"搜索历史";
    titleLab.textColor = [UIColor lightGrayColor];
    titleLab.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView.mas_left).offset(10);
    }];
    
    [headerView addSubview:self.clearBtn];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).offset(-10);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(64);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [self.collectionView reloadData];
}
- (void)updateEmpty{
    if (!self.recordArr || self.recordArr.count == 0) {
        [self setViewNoDataShow:YES];
    }else{
         [self setViewNoDataShow:NO];
    }
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.recordArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YJSearchRecordFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YJSearchRecordFlowCell class]) forIndexPath:indexPath];
    cell.text = self.recordArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *record = self.recordArr[indexPath.row];
    self.recordBlock(record);
}
#pragma mark - YJSearchRecordFlowLayoutDelegate
- (CGFloat)lg_layout:(YJSearchRecordFlowLayout *)layout widthForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.recordArr[indexPath.row];
    CGSize stringSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    return stringSize.width+16;
}

#pragma mark - Property Init
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        YJSearchRecordFlowLayout *layout = [[YJSearchRecordFlowLayout alloc] init];
        layout.itemHeight = 35;
        layout.topInset = 1;
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[YJSearchRecordFlowCell class] forCellWithReuseIdentifier:NSStringFromClass([YJSearchRecordFlowCell class])];
    }
    return _collectionView;
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
- (UIButton *)clearBtn{
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setTitle:@"清空历史" forState:UIControlStateNormal];
        _clearBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_clearBtn setTitleColor:[UIColor yj_colorWithHex:0x009AFC] forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}
@end
