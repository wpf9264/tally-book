# 通过 UIdatePicker 了解 Runtime

参考：

- [利用Runtime修改UIdatePicker的字体颜色_坤小的专栏-CSDN博客](https://blog.csdn.net/u013263917/article/details/48158949)

## 背景

- 在开发时，发现我的 UIDatePicker 背景色和字体颜色都是白色，导致无法正常使用，因此期望修改组件的颜色。
- （可能是M1的bug，在更新Xcode版本后消失了。）

## API

先介绍几个api：

```objective-c
/** 简单说就是返回一个数组的指针，指向class本身的propert列表（不包含基类），outCount需要自行手动释放。 */
OBJC_EXPORT objc_property_t _Nonnull * _Nullable
class_copyPropertyList(Class _Nullable cls, unsigned int * _Nullable outCount)
  
/** 获取当前property的名字 */
OBJC_EXPORT const char * _Nonnull
property_getName(objc_property_t _Nonnull property) 

/** 获取当前property的特性信息 */
OBJC_EXPORT const char * _Nullable
property_getAttributes(objc_property_t _Nonnull property) 

/** 返回一个数组的指针，指向class实例的method列表（不包含基类），outCount需要自行手动释放。 */
OBJC_EXPORT Method _Nonnull * _Nullable
class_copyMethodList(Class _Nullable cls, unsigned int * _Nullable outCount) 
```

下面是api的测试及输出：

```objective-c

unsigned int propertyCount;
objc_property_t *propertyList = class_copyPropertyList([UIDatePicker class], &propertyCount);
for (int index = 0; index < propertyCount; index++) {
  NSString *name = [NSString stringWithCString:property_getName(propertyList[index]) encoding:NSUTF8StringEncoding];
  NSString *attributes = [NSString stringWithCString:property_getAttributes(propertyList[index]) encoding:NSUTF8StringEncoding];
  NSLog(@"name:%@ ==== attributes:%@",name, attributes);
}

021-10-10 23:37:19.695489+0800 TallyBook[28029:1198027] name:locale ==== attributes:T@"NSLocale",&,D,N
2021-10-10 23:37:19.695577+0800 TallyBook[28029:1198027] name:date ==== attributes:T@"NSDate",&,D,N
2021-10-10 23:37:19.695789+0800 TallyBook[28029:1198027] name:countDownDuration ==== attributes:Td,D,N
2021-10-10 23:37:19.695934+0800 TallyBook[28029:1198027] name:datePickerStyle ==== attributes:Tq,R,N
```

发现 attributes 信息比较复杂，对比下表可以看出：T后面代表数据类型，d表示double，q表示NSinteger，不便表示的类型会直接输出具体类型“NSDate”。

!![](/Users/wangpengfei/Pictures/图片资料/20160126194324825.png)

## Runtime

查看 UIDatePicker的定义，apple并没有提供修改颜色的api，遍历其属性，查看所有的属性。发现有三个和颜色相关的属性，分别修改其颜色后观察表现

```objective-c
unsigned int propertyCount;
objc_property_t *propertyList = class_copyPropertyList([UIDatePicker class], &propertyCount);
for (int index = 0; index < propertyCount; index++) {
  NSString *name = [NSString stringWithCString:property_getName(propertyList[index]) encoding:NSUTF8StringEncoding];
  NSString *attributes = [NSString stringWithCString:property_getAttributes(propertyList[index]) encoding:NSUTF8StringEncoding];
  if([name isEqualToString:@"textColor"]) {
    [_datePicker setValue:[UIColor yellowColor] forKey:@"textColor"]; // 字体颜色
  }
  if([name isEqualToString:@"highlightColor"]) {
    [_datePicker setValue:[UIColor greenColor] forKey:@"highlightColor"]; // 当天颜色高亮
  }
  if([name isEqualToString:@"textShadowColor"]) {
    [_datePicker setValue:[UIColor redColor] forKey:@"textShadowColor"]; // 字体阴影颜色
  }
}
```

<img src="/Users/wangpengfei/Library/Application Support/typora-user-images/image-20211010235816347.png" alt="image-20211010235816347" style="zoom:50%;" align = "left"/>

当天的颜色会一直高亮，影响视觉体验。查看所有的属性，并没有取消高亮的属性。查看其实例方法列表，发现有个开关，决定是否高亮当天颜色。对于实例方法，不能再使用上述setValue的形式，可以通过 NSInvocation 来解决。

```objective-c
unsigned int methodCount;
Method *methodList = class_copyMethodList(UIDatePicker.class, &methodCount);
for (int index = 0; index < methodCount; index++) {
  NSString *name = [NSString stringWithCString:method_getName(methodList[index]) encoding:NSUTF8StringEncoding];
  NSLog(@"name:%@",name);
}
2021-10-11 00:07:36.356410+0800 TallyBook[28437:1220974] name:setHighlightsToday:
```

关闭当天高亮后，再次尝试表现正常

```objective-c
SEL selector =  NSSelectorFromString (@"setHighlightsToday:");
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDatePicker instanceMethodSignatureForSelector:selector]];
BOOL no = NO;
[invocation setSelector:selector];
[invocation setArgument:&no atIndex:2];// 设置参数的Index 需要从2开始，因为前两个被selector和target占用
[invocation invokeWithTarget:_datePicker];// 设好的参数 以及方法 赋值 给pickerView
```

<img src="/Users/wangpengfei/Library/Application Support/typora-user-images/image-20211011001449474.png" alt="image-20211011001449474" style="zoom:50%;" align = "left"/>

 **通过Runtime，我们可以修改apple未开放的控件配置信息**

