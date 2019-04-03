//
//  YJSearchRecordFooterView.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchRecordFooterView.h"
#import <Masonry/Masonry.h>
#import <YJExtensions/YJExtensions.h>

@interface YJSearchRecordFooterView ()

@end
@implementation YJSearchRecordFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor yj_colorWithHex:0x999999];
        label.text = @"清除历史记录";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearAction)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}
- (void)clearAction{
    if (self.clearRecordBlock) {
        self.clearRecordBlock();
    }
}
@end
