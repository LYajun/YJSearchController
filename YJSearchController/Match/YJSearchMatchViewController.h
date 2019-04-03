//
//  YJSearchMatchViewController.h
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJSearchMatchViewController : YJSearchBaseViewController
/** 搜索关键字 */
@property (copy, nonatomic) NSString *searchStr;
/** 可搜索的相关内容 */
@property (nonatomic,strong) NSArray *searchMatchArray;
@property (copy, nonatomic) void (^resultBlock) (NSString *result);
@end

NS_ASSUME_NONNULL_END
