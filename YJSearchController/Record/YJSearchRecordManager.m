//
//  YJSearchRecordManager.m
//  YJSearchControllerDemo
//
//  Created by 刘亚军 on 2019/4/2.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "YJSearchRecordManager.h"

@interface YJSearchRecordManager ()

@end
@implementation YJSearchRecordManager
+ (YJSearchRecordManager *)defaultManager{
    static YJSearchRecordManager * macro = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        macro = [[YJSearchRecordManager alloc]init];
    });
    return macro;
}
- (NSString *)searchRecordPlistPath{
    if (!_searchRecordPlistPath) {
        NSString *record = [NSString stringWithFormat:@"%@/Library/YJSearchRecord/",NSHomeDirectory()];
        _searchRecordPlistPath = [record stringByAppendingString:@"YJSearchRecord.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:record]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:record withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:_searchRecordPlistPath]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            // 在相应的路径创建plist文件
            [dic writeToFile:_searchRecordPlistPath atomically:YES];
        }
    }
    return _searchRecordPlistPath;
}
- (NSDictionary *)readSearchRecord{
    return [NSDictionary dictionaryWithContentsOfFile:self.searchRecordPlistPath];
}
- (void)writeSearchRecordWithRecordDic:(NSDictionary *)recordDic{
    [recordDic writeToFile:self.searchRecordPlistPath atomically:false];
}
- (void)deleteSearchRecord{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:self.searchRecordPlistPath error:nil];
}
- (void)insertSearchRecordWithRecord:(NSString *)record{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self readSearchRecord]];
    NSMutableArray *arr = [NSMutableArray array];
    if (dic[self.searchControllerName]) {
        [arr addObjectsFromArray:dic[self.searchControllerName]];
    }
    if ([arr containsObject:record]) {
        [arr removeObject:record];
    }
    [arr insertObject:record atIndex:0];
    if (arr.count > 20) {
        [arr removeLastObject];
    }
    [dic setObject:arr forKey:self.searchControllerName];
    [self writeSearchRecordWithRecordDic:dic];
}

@end
