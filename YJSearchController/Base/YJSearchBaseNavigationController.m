//
//  YJSearchBaseNavigationController.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchBaseNavigationController.h"
#import <YJExtensions/YJExtensions.h>
#import "YJSearchManager.h"

@interface YJSearchBaseNavigationController ()

@end

@implementation YJSearchBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customInit];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)customInit{
    self.navigationBar.translucent = NO;
    NSString *imageName = @"lg_navBar_bg";
    if ([self.view yj_isIPhoneX]) {
        imageName = @"lg_navBar_bg_x";
    }
    [self.navigationBar setBackgroundImage:[UIImage yj_imageNamed:imageName atBundle:[YJSearchManager defaultManager].searchBundle]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.tintColor = [UIColor whiteColor];
    NSDictionary *titleAttr = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
    self.navigationBar.titleTextAttributes = titleAttr;
}


@end
