//
//  YJSearchBar.m
//  
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "YJSearchBar.h"

#import <YJExtensions/YJExtensions.h>
#import "YJSearchManager.h"

@interface YJSearchBar ()
/** 搜索内容 */
@property (nonatomic,copy) NSString *searchString;
@property (nonatomic, strong) UIToolbar *customAccessoryView;
@end

@implementation YJSearchBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}
- (void)config{
    self.inputAccessoryView = self.customAccessoryView;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage yj_imageNamed:@"icon_search" atBundle:[YJSearchManager defaultManager].searchBundle]];
    imageView.contentMode = UIViewContentModeCenter;
    CGRect frame = imageView.frame;
    frame.size.width = imageView.frame.size.width + 20;
    imageView.frame = frame;
    self.backgroundColor = [UIColor whiteColor];
    self.tintColor = [UIColor lightGrayColor];
    self.placeholder = [YJSearchManager defaultManager].searchPlaceholder;
    self.font = [UIFont systemFontOfSize:14];
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = YES;
    self.leftView = imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.returnKeyType = UIReturnKeySearch;

}
- (void)clearAction{
    self.text = @"";
}
- (void)done{
    [self resignFirstResponder];
}
- (UIToolbar *)customAccessoryView{
    if (!_customAccessoryView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,width,40}];
        _customAccessoryView.barTintColor = [UIColor whiteColor];
        UIBarButtonItem *clear = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(clearAction)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"收起" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
        [_customAccessoryView setItems:@[clear,space,finish]];
        
    }
    return _customAccessoryView;
}

@end
