//
//  YJPinYinForObjc.m
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import "YJPinYinForObjc.h"

@implementation YJPinYinForObjc

+ (NSString*)chineseConvertToPinYin:(NSString*)chinese {
    NSString *sourceText = chinese;
    YJHanyuPinyinOutputFormat *outputFormat = [[YJHanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *outputPinyin = [YJPinyinHelper toHanyuPinyinStringWithNSString:sourceText withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    return outputPinyin;
    
}
+ (NSArray *)chineseArrayConvertToPinYinArray:(NSArray *)chineseArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *sourceText in chineseArray) {
        YJHanyuPinyinOutputFormat *outputFormat = [[YJHanyuPinyinOutputFormat alloc] init];
        [outputFormat setToneType:ToneTypeWithoutTone];
        [outputFormat setVCharType:VCharTypeWithV];
        [outputFormat setCaseType:CaseTypeLowercase];
        NSString *outputPinyin = [YJPinyinHelper toHanyuPinyinStringWithNSString:sourceText withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
        [array addObject:outputPinyin];
    }
    return array;
}
+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese {
    YJHanyuPinyinOutputFormat *outputFormat = [[YJHanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSMutableString *outputPinyin = [[NSMutableString alloc] init];
    for (int i=0;i <chinese.length;i++) {
        NSString *mainPinyinStrOfChar = [YJPinyinHelper getFirstHanyuPinyinStringWithChar:[chinese characterAtIndex:i] withHanyuPinyinOutputFormat:outputFormat];
        if (nil!=mainPinyinStrOfChar) {
            [outputPinyin appendString:[mainPinyinStrOfChar substringToIndex:1]];
        } else {
            break;
        }
    }
    return outputPinyin;
}
@end
