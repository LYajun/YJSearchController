//
//  YJSearchManager.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchManager.h"
#import "YJPresentSearchAnimation.h"
#import "YJSearchMainViewController.h"
#import "YJSearchBaseNavigationController.h"
#import "YJSearchRecordManager.h"
#import <YJExtensions/YJExtensions.h>

@interface YJSearchManager ()<UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) NSBundle *sBundle;
@end
@implementation YJSearchManager
+ (YJSearchManager *)defaultManager{
    static YJSearchManager * macro = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        macro = [[YJSearchManager alloc]init];
        macro.sBundle = [NSBundle yj_bundleWithCustomClass:YJSearchMainViewController.class bundleName:@"YJSearchController"];
    });
    return macro;
}
- (void)setSearchControllerName:(NSString *)searchControllerName{
    _searchControllerName = searchControllerName;
    [YJSearchRecordManager defaultManager].searchControllerName = searchControllerName;
}
- (float)presentOffsety{
    if (_presentOffsetY == 0) {
        return 100;
    }
    return _presentOffsetY;
}
- (NSBundle *)searchBundle{
    return _sBundle;
}
- (NSString *)searchPlaceholder{
    if (!_searchPlaceholder || _searchPlaceholder.length == 0) {
        return @"请输入关键字搜索...";
    }
    return _searchPlaceholder;
}
- (void)presentSearchControllerBy:(UIViewController *)controller{
    YJSearchMainViewController *sMain = [[YJSearchMainViewController alloc] init];
    YJSearchBaseNavigationController *sNaviBar = [[YJSearchBaseNavigationController alloc] initWithRootViewController:sMain];
    sNaviBar.transitioningDelegate = self;
    [controller presentViewController:sNaviBar animated:YES completion:nil];
}
#pragma mark UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    YJPresentSearchAnimation *leftPresentAnimation = [[YJPresentSearchAnimation alloc] init];
    leftPresentAnimation.presentOffsetY = self.presentOffsetY;
    return leftPresentAnimation;
}
@end
