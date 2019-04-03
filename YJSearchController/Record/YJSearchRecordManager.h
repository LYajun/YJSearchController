//
//  YJSearchRecordManager.h
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJSearchRecordManager : NSObject

/** 搜索记录，暂存本地的路径*/
@property (nonatomic,strong) NSString *searchRecordPlistPath;

/** 启动搜索视图的控制器名 */
@property (copy, nonatomic) NSString *searchControllerName;

+ (YJSearchRecordManager *)defaultManager;

/** 读取记录 */
- (NSDictionary *)readSearchRecord;
/** 写入记录 */
- (void)writeSearchRecordWithRecordDic:(NSDictionary *) recordDic;
/** 删除记录 */
- (void)deleteSearchRecord;
/** 插入记录 */
- (void)insertSearchRecordWithRecord:(NSString *) record;
@end

NS_ASSUME_NONNULL_END
