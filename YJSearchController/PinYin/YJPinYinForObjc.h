//
//  YJPinYinForObjc.h
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJHanyuPinyinOutputFormat.h"
#import "YJPinyinHelper.h"

@interface YJPinYinForObjc : NSObject

+ (NSString*)chineseConvertToPinYin:(NSString*)chinese;//转换为拼音
+ (NSArray*)chineseArrayConvertToPinYinArray:(NSArray*)chineseArray;//中文数组转换为拼音数组
+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese;//转换为拼音首字母
@end
