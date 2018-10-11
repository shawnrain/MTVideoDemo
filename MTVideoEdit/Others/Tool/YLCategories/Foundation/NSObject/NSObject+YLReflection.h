//
//  NSObject+YLReflection.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSObject (YLReflection)
/**
实例方法 类名

 @return 类名
 */
- (NSString *)yl_className;
/**
 类方法 类名
 
 @return 类名
 */
+ (NSString *)yl_className;


/**
 实例方法 父类名称
 
 @return 父类名称
 */
- (NSString *)yl_superClassName;
/**
 类方法 父类名称
 
 @return 父类名称
 */
+ (NSString *)yl_superClassName;


/**
 实例属性字典

 @return 实例属性字典
 */
- (NSDictionary *)yl_propertyDictionary;



/**
 实例方法 属性名称列表

 @return 属性名称列表
 */
- (NSArray *)yl_propertyKeys;
/**
 类方法 属性名称列表
 
 @return 属性名称列表
 */
+ (NSArray *)yl_propertyKeys;

//

/**
 实例方法 属性详细信息列表

 @return 属性详细信息列表
 */
- (NSArray *)yl_propertiesInfo;

/**
 类方法 属性详细信息列表

 @return 属性详细信息列表
 */
+ (NSArray *)yl_propertiesInfo;


/**
 格式化后的属性列表

 @return 格式化后的属性列表
 */
+ (NSArray *)yl_propertiesWithCodeFormat;


/**
 实例方法 方法列表

 @return 方法列表
 */
- (NSArray *)yl_methodList;
/**
 类方法 方法列表
 
 @return 方法列表
 */
+ (NSArray *)yl_methodList;



/**
 创建并返回一个指向所有已注册类的指针列表

 @return 指向所有已注册类的指针列表
 */
+ (NSArray *)yl_registedClassList;

//

/**
 类方法 协议列表

 @return 协议列表
 */
-(NSDictionary *)yl_protocolList;

/**
 实例方法 协议列表

 @return 协议列表
 */
+ (NSDictionary *)yl_protocolList;


/**
 是否存在属性

 @param key 属性名
 @return 是否存在
 */
- (BOOL)yl_hasPropertyForKey:(NSString*)key;

/**
 是否存在指针

 @param key 指针名
 @return 是否存在
 */
- (BOOL)yl_hasIvarForKey:(NSString*)key;
@end
