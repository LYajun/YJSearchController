//
//  ViewController.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "ViewController.h"
#import "YJSearchManager.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)search:(UIButton *)sender {
    [YJSearchManager defaultManager].searchStr = @"还";
    [YJSearchManager defaultManager].searchControllerName = NSStringFromClass(self.class);
    [YJSearchManager defaultManager].searchMatchArray = @[@"searchMatc还是欧吉桑hArray",@"sea不错rc33hMatc还是欧吉桑hArray",@"searchMatc还是欧吉桑hArray",@"sea英语rch1Matc还是欧吉桑hArray",@"searc6hMatc还是欧吉桑hArray",@"searc5hMatc还是欧吉桑hArray",@"searc45hMatc华为还是欧吉桑hArray",@"search语文Ma55532dd99tc还是欧吉桑hArray",@"searc243241hMatc还是欧吉桑hArray",@"search中银Matc还是欧吉桑hArray"];
    [YJSearchManager defaultManager].searchStrBlock = ^(NSString * _Nonnull searchStr) {
        NSLog(@"%@",searchStr);
    };
    [[YJSearchManager defaultManager] presentSearchControllerBy:self];
}

@end
