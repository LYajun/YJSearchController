//
//  YJSearchManager.h
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YJSearchManager : NSObject
/** 搜索按钮的Y坐标，默认100 */
@property (nonatomic, assign) float presentOffsetY;
/** 搜索关键字 */
@property (copy, nonatomic) NSString *searchStr;
/** 可搜索的相关内容 */
@property (nonatomic,strong) NSArray *searchMatchArray;
/** 启动搜索视图的控制器名 */
@property (copy, nonatomic) NSString *searchControllerName;
/** 搜索提示语 */
@property (nonatomic,copy) NSString *searchPlaceholder;
/** 搜索输入内容 */
@property (nonatomic,copy) void (^searchStrBlock) (NSString *searchStr);

+ (YJSearchManager *)defaultManager;

- (NSBundle *)searchBundle;

- (void)presentSearchControllerBy:(UIViewController *)controller;
@end

NS_ASSUME_NONNULL_END
