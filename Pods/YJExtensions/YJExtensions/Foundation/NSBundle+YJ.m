//
//  NSBundle+YJ.m
//  YJExtensionsDemo
//
//  Created by 刘亚军 on 2019/3/14.
//  Copyright © 2019 刘亚军. All rights reserved.
//

#import "NSBundle+YJ.h"
#import "NSUserDefaults+YJ.h"

@implementation NSBundle (YJ)

+ (instancetype)yj_bundle{
    static NSBundle *bundle = nil;
    if (!bundle) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        Class bundleClass = NSClassFromString([NSUserDefaults yj_stringForKey:@"YJBundleClass"]);
        NSString *bundleName = [NSUserDefaults yj_stringForKey:@"YJBundleName"];
        bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:bundleClass] pathForResource:bundleName ofType:@"bundle"]];
    }
    return bundle;
}

+ (NSString *)yj_bundlePathWithName:(NSString *)name{
    return [[[NSBundle yj_bundle] resourcePath] stringByAppendingPathComponent:name];
}
@end
