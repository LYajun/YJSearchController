//
//
//
//  Created by kimziv on 13-9-14.
//

#include "YJChineseToPinyinResource.h"
#include "YJHanyuPinyinOutputFormat.h"
#include "YJPinyinFormatter.h"
#include "YJPinyinHelper.h"

#define HANYU_PINYIN @"Hanyu"
#define WADEGILES_PINYIN @"Wade"
#define MPS2_PINYIN @"MPSII"
#define YALE_PINYIN @"Yale"
#define TONGYONG_PINYIN @"Tongyong"
#define GWOYEU_ROMATZYH @"Gwoyeu"

@implementation YJPinyinHelper

+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch {
    return [YJPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
}

+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch
                  withHanyuPinyinOutputFormat:(YJHanyuPinyinOutputFormat *)outputFormat {
    return [YJPinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withHanyuPinyinOutputFormat:outputFormat];
}

+ (NSArray *)getFormattedHanyuPinyinStringArrayWithChar:(unichar)ch
                            withHanyuPinyinOutputFormat:(YJHanyuPinyinOutputFormat *)outputFormat {
    NSMutableArray *pinyinStrArray =[NSMutableArray arrayWithArray:[YJPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch]];
    if (nil != pinyinStrArray) {
        for (int i = 0; i < (int) [pinyinStrArray count]; i++) {
            [pinyinStrArray replaceObjectAtIndex:i withObject:[YJPinyinFormatter formatHanyuPinyinWithNSString:
                                                               [pinyinStrArray objectAtIndex:i]withHanyuPinyinOutputFormat:outputFormat]];
        }
        return pinyinStrArray;
    }
    else return nil;
}

+ (NSArray *)getUnformattedHanyuPinyinStringArrayWithChar:(unichar)ch {
    return [[YJChineseToPinyinResource getInstance] getHanyuPinyinStringArrayWithChar:ch];
}

+ (NSArray *)toTongyongPinyinStringArrayWithChar:(unichar)ch {
    return [YJPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: TONGYONG_PINYIN];
}

+ (NSArray *)toWadeGilesPinyinStringArrayWithChar:(unichar)ch {
    return [YJPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: WADEGILES_PINYIN];
}

+ (NSArray *)toMPS2PinyinStringArrayWithChar:(unichar)ch {
    return [YJPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: MPS2_PINYIN];
}

+ (NSArray *)toYalePinyinStringArrayWithChar:(unichar)ch {
    return [YJPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: YALE_PINYIN];
}

+ (NSArray *)convertToTargetPinyinStringArrayWithChar:(unichar)ch
                           withPinyinRomanizationType:(NSString *)targetPinyinSystem {
    NSArray *hanyuPinyinStringArray = [YJPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
    if (nil != hanyuPinyinStringArray) {
        NSMutableArray *targetPinyinStringArray = [NSMutableArray arrayWithCapacity:hanyuPinyinStringArray.count];
        for (int i = 0; i < (int) [hanyuPinyinStringArray count]; i++) {
            
        }
        return targetPinyinStringArray;
    }
    else return nil;
}

+ (NSArray *)toGwoyeuRomatzyhStringArrayWithChar:(unichar)ch {
    return [YJPinyinHelper convertToGwoyeuRomatzyhStringArrayWithChar:ch];
}

+ (NSArray *)convertToGwoyeuRomatzyhStringArrayWithChar:(unichar)ch {
    NSArray *hanyuPinyinStringArray = [YJPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
    if (nil != hanyuPinyinStringArray) {
        NSMutableArray *targetPinyinStringArray =[NSMutableArray arrayWithCapacity:hanyuPinyinStringArray.count];
        for (int i = 0; i < (int) [hanyuPinyinStringArray count]; i++) {
        }
        return targetPinyinStringArray;
    }
    else return nil;
}

+ (NSString *)toHanyuPinyinStringWithNSString:(NSString *)str
                  withHanyuPinyinOutputFormat:(YJHanyuPinyinOutputFormat *)outputFormat
                                 withNSString:(NSString *)seperater {
    NSMutableString *resultPinyinStrBuf = [[NSMutableString alloc] init];
    for (int i = 0; i <  str.length; i++) {
        NSString *mainPinyinStrOfChar = [YJPinyinHelper getFirstHanyuPinyinStringWithChar:[str characterAtIndex:i] withHanyuPinyinOutputFormat:outputFormat];
        if (nil != mainPinyinStrOfChar) {
            [resultPinyinStrBuf appendString:mainPinyinStrOfChar];
            if (i != [str length] - 1) {
                [resultPinyinStrBuf appendString:seperater];
            }
        }
        else {
            [resultPinyinStrBuf appendFormat:@"%C",[str characterAtIndex:i]];
        }
    }
    return resultPinyinStrBuf;
}

+ (NSString *)getFirstHanyuPinyinStringWithChar:(unichar)ch
                    withHanyuPinyinOutputFormat:(YJHanyuPinyinOutputFormat *)outputFormat {
    NSArray *pinyinStrArray = [YJPinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withHanyuPinyinOutputFormat:outputFormat];
    if ((nil != pinyinStrArray) && ((int) [pinyinStrArray count] > 0)) {
        return [pinyinStrArray objectAtIndex:0];
    }
    else {
        return nil;
    }
}

- (id)init {
    return [super init];
}

@end
