//
//  SPUserInfo.m
//  shipingdiandian
//
//  Created by MTShawn on 2018/7/20.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "SPUserInfo.h"
#import <MJExtension/MJExtension.h>
#import "NSString+Additions.h"
#import "NSDate+Time.h"
#define kUserInfoArchWithOther(number) [[NSString documentPath]stringByAppendingPathComponent:[NSString stringWithFormat:@"user%@.archiver",number]]
#define kUserInfoArchiveDir [[NSString documentPath]stringByAppendingPathComponent:@"user.archiver"]

static SPUserInfo *user;
static dispatch_once_t token;
static NSString *YWUserInstanceClassName;
@implementation SPUserInfo
+(void)load
{
    [[self class] loadSubCalssName];
}
+(NSString*)getStringWithKey:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(void)setString:(NSString*)v withKey:(NSString*)key {
    [[NSUserDefaults standardUserDefaults] setObject:v forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(void)loadSubCalssName
{
    NSString *userInstanceName = [self getStringWithKey:@"userInstanceName"];
    if (userInstanceName==nil || userInstanceName.length == 0) {
        int numClasses;
        Class *classes = NULL;
        numClasses = objc_getClassList(NULL,0);
        
        if (numClasses >0 ){
            classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
            numClasses = objc_getClassList(classes, numClasses);
            for (int i = 0; i < numClasses; i++) {
                if (class_getSuperclass(classes[i]) == [SPUserInfo class]){
                    NSLog(@"%@===%@",classes[i], NSStringFromClass(classes[i]));
                    YWUserInstanceClassName = NSStringFromClass(classes[i]);
                    [self setString:YWUserInstanceClassName withKey:@"userInstanceName"];
                    break;
                }
            }
            free(classes);
        }
        return;
    }
    
    YWUserInstanceClassName = userInstanceName;
}

+(NSString *)getSubCalssName
{
    if (YWUserInstanceClassName == nil || YWUserInstanceClassName.length == 0) {
        [[self class] loadSubCalssName];
    }
    return YWUserInstanceClassName;
}

MJCodingImplementation
+ (instancetype)shareInstance
{
    dispatch_once(&token, ^{
        NSLog(@"===%@",[SPUserInfo archiveRootFile]);
        user = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archiveRootFile]];
        if (!user) {
            user = [[[self class] alloc] init];
        }
    });
    return user;
}

- (void)resetInstance{
    token = 0;
    user = nil;
}
+ (void)archiveUserInstance{
    SPUserInfo *user = [[self class] shareInstance];
    [NSKeyedArchiver archiveRootObject:user toFile:[self archiveRootFile]];
}
- (NSMutableArray *)messageArray{
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}
+(NSString *)archiveRootFile{
    if (![[self getInstancename] isEqualToString:@"0"]) {
        return kUserInfoArchWithOther([SPUserInfo getInstancename]);
    }
    return kUserInfoArchiveDir;
}
+ (void)setUserDefault:(NSString *)lStr{
    [[NSUserDefaults standardUserDefaults] setObject:lStr forKey:@"instance"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getInstancename{
    NSString * lStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"instance"];
    return lStr;
}
@end
