//
//  
//
//  Created by kimziv on 13-9-14.
//

#import <Foundation/Foundation.h>

#ifndef _YJChineseToPinyinResource_H_
#define _YJChineseToPinyinResource_H_

@class NSArray;
@class NSMutableDictionary;

@interface YJChineseToPinyinResource : NSObject {
    NSString* _directory;
    NSDictionary *_unicodeToHanyuPinyinTable;
}
//@property(nonatomic, strong)NSDictionary *unicodeToHanyuPinyinTable;

- (id)init;
- (void)initializeResource;
- (NSArray *)getHanyuPinyinStringArrayWithChar:(unichar)ch;
- (BOOL)isValidRecordWithNSString:(NSString *)record;
- (NSString *)getHanyuPinyinRecordFromCharWithChar:(unichar)ch;
+ (YJChineseToPinyinResource *)getInstance;

@end



#endif // _YJChineseToPinyinResource_H_
