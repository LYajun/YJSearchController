# YJSearchController
搜索

<div align="left">
<img src="https://github.com/LYajun/YJSearchController/blob/master/Assets/Shot1.png" width ="375" height ="812" >
<img src="https://github.com/LYajun/YJSearchController/blob/master/Assets/Shot2.png" width ="375" height ="812" >
 </div>
 
## 使用方式

1、集成:

```
pod 'YJSearchController'
```

2、配置

```objective-c

/** 搜索按钮的Y坐标，默认100 */
@property (nonatomic, assign) float presentOffsetY;
/** 搜索关键字 */
@property (copy, nonatomic) NSString *searchStr;
/** 可搜索的相关内容 */
@property (nonatomic,strong) NSArray *searchMatchArray;
/** 启动搜索视图的控制器名 */
@property (copy, nonatomic) NSString *searchControllerName;

/** 搜索输入内容 */
@property (nonatomic,copy) void (^searchStrBlock) (NSString *searchStr);

```

3、使用

```objective-c

[YJSearchManager defaultManager].searchStr = @"还";
[YJSearchManager defaultManager].searchControllerName = NSStringFromClass(self.class);
[YJSearchManager defaultManager].searchMatchArray = @[@"searchMatc还是欧吉桑hArray",@"sea不错rc33hMatc还是欧吉桑hArray",@"searchMatc还是欧吉桑hArray",@"sea英语rch1Matc还是欧吉桑hArray"];
[YJSearchManager defaultManager].searchStrBlock = ^(NSString * _Nonnull searchStr) {
        NSLog(@"%@",searchStr);
    };
[[YJSearchManager defaultManager] presentSearchControllerBy:self];

```