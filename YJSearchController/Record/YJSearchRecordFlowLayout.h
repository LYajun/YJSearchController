//
//  YJSearchRecordFlowLayout.h
//  YJSearchtionaryDemo
//
//  Created by 刘亚军 on 2018/9/28.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJSearchRecordFlowLayout;

@protocol YJSearchRecordFlowLayoutDelegate <NSObject>

- (CGFloat)lg_layout:(YJSearchRecordFlowLayout *)layout widthForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (CGFloat)lg_layout:(YJSearchRecordFlowLayout *)layout heightForHeaderAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface YJSearchRecordFlowLayout : UICollectionViewLayout
@property (nonatomic,assign) id<YJSearchRecordFlowLayoutDelegate> delegate;
/** 高度 */
@property (nonatomic,assign)  CGFloat itemHeight;
/** 顶部间距 */
@property (nonatomic) CGFloat topInset;
/** 尾部间距 */
@property (nonatomic) CGFloat bottomInset;
/** 分区头视图是否悬浮 */
@property (nonatomic) BOOL stickyHeader;
@end
