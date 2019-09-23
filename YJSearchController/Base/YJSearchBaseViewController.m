//
//  YJSearchBaseViewController.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchBaseViewController.h"
#import <Masonry/Masonry.h>
#import <YJExtensions/YJExtensions.h>
#import "YJSearchManager.h"

@interface YJSearchBaseViewController ()
/** 没有数据 */
@property (strong, nonatomic) UIView *viewNoData;
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation YJSearchBaseViewController
- (instancetype)init{
    if (self = [super init]) {
        [self configure];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self initUI];
}

- (void)dealloc{
    NSLog(@"%@ --dealloc",NSStringFromClass(self.class));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)configure {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
}
- (void)navBar_leftItemPressed{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)setViewNoDataShow:(BOOL)show{
     [self setShowOnBackgroundView:self.viewNoData show:show];
}
- (void)setShowOnBackgroundView:(UIView *)aView show:(BOOL)show {
    if (!aView) {
        return;
    }
    if (show) {
        if (aView.superview) {
            [aView removeFromSuperview];
        }
        [self.view addSubview:aView];
        [self.view bringSubviewToFront:aView];
        [aView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    else {
        [aView removeFromSuperview];
    }
}
#pragma mark Getter
- (UIView *)viewNoData {
    if (!_viewNoData) {
        _viewNoData = [[UIView alloc]init];
        _viewNoData.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage yj_imageNamed:@"statusView_empty" atBundle:[YJSearchManager defaultManager].searchBundle]];
        [_viewNoData addSubview:img];
        __weak typeof(self) weakSelf = self;
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.viewNoData);
            make.centerY.equalTo(weakSelf.viewNoData).offset(-40);
        }];
        UILabel *lab = [[UILabel alloc] init];
        lab.tag = 11;
        lab.font = [UIFont systemFontOfSize:14];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor yj_colorWithHex:0x989898];
        lab.text = @"暂无搜索历史";
        [_viewNoData addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.viewNoData);
            make.top.equalTo(img.mas_bottom).offset(-30);
        }];
    }
    return _viewNoData;
}
- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(0, 0, 28, 28);
        [_backBtn setImageEdgeInsets: UIEdgeInsetsMake(0, -15, 0, 0)];
        [_backBtn setImage:[UIImage yj_imageNamed:@"navibar_back" atBundle:[YJSearchManager defaultManager].searchBundle] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(navBar_leftItemPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
@end
