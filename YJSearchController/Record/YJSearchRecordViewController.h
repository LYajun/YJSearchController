//
//  YJSearchRecordViewController.h
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJSearchRecordViewController : YJSearchBaseViewController
@property (copy, nonatomic) void (^recordBlock) (NSString *record);
@end

NS_ASSUME_NONNULL_END
