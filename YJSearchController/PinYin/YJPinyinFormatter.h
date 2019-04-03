//
//  
//
//  Created by kimziv on 13-9-14.
//

#import <Foundation/Foundation.h>


#ifndef _YJPinyinFormatter_H_
#define _YJPinyinFormatter_H_

@class YJHanyuPinyinOutputFormat;

@interface YJPinyinFormatter : NSObject {
}

+ (NSString *)formatHanyuPinyinWithNSString:(NSString *)pinyinStr
                withHanyuPinyinOutputFormat:(YJHanyuPinyinOutputFormat *)outputFormat;
+ (NSString *)convertToneNumber2ToneMarkWithNSString:(NSString *)pinyinStr;
- (id)init;
@end

#endif // _YJPinyinFormatter_H_
