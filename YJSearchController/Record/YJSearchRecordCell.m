//
//  YJSearchRecordCell.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchRecordCell.h"
#import <Masonry/Masonry.h>
#import <YJExtensions/YJExtensions.h>

@interface YJSearchRecordCell ()
@property (nonatomic,strong) UILabel *titleLab;
@end
@implementation YJSearchRecordCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(20);
            make.bottom.equalTo(self.contentView).offset(-3);
        }];
    }
    return self;
}
- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLab.text = titleStr;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont systemFontOfSize:15];
        _titleLab.textColor = [UIColor yj_colorWithHex:0x6B6B6B];
    }
    return _titleLab;
}
@end
