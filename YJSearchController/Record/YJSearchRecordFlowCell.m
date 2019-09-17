//
//  YJSearchRecordFlowCell.m
//  YJSearchtionaryDemo
//
//  Created by 刘亚军 on 2018/9/28.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "YJSearchRecordFlowCell.h"

#import <Masonry/Masonry.h>
#import <YJExtensions/YJExtensions.h>

@interface YJSearchRecordFlowCell ()
@property (strong, nonatomic) UILabel *contentL;
@end
@implementation YJSearchRecordFlowCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configure];
        [self layoutUI];
    }
    return self;
}
- (void)layoutUI{
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.contentL];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self yj_clipLayerWithRadius:5 width:1 color:[UIColor yj_colorWithHex:0xffffff]];

}
- (void)configure{
    _isChoice = NO;
}
- (void)setText:(NSString *)text{
    _text = text;
    self.contentL.text = text;
}
- (void)setTextBgColor:(UIColor *)textBgColor{
    _textBgColor = textBgColor;
    self.contentL.backgroundColor = textBgColor;
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.contentL.textColor = textColor;
}
- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    [self yj_clipLayerWithRadius:5 width:1 color:borderColor];
}
- (void)setIsChoice:(BOOL)isChoice{
    _isChoice = isChoice;
    if (_isChoice) {
        [self yj_clipLayerWithRadius:5 width:1 color:[UIColor darkGrayColor]];
    }else{
        [self yj_clipLayerWithRadius:5 width:0 color:nil];
    }
}

- (UILabel *)contentL{
    if (!_contentL) {
        _contentL = [[UILabel alloc] init];
        _contentL.textAlignment = NSTextAlignmentCenter;
        _contentL.font = [UIFont systemFontOfSize:16];
        _contentL.numberOfLines = 0;
        _contentL.textColor = [UIColor yj_colorWithHex:0x333333];
        _contentL.backgroundColor = [UIColor yj_colorWithHex:0xF2F2F2];
    }
    return _contentL;
}
@end
