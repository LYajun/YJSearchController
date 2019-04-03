//
//  YJSearchRecordFooterView.h
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJSearchRecordFooterView : UITableViewHeaderFooterView
@property (nonatomic,copy) void (^clearRecordBlock) (void);
@end

NS_ASSUME_NONNULL_END
