//
//  UserInfo.m
//  QzoneUp
//
//  Created by melon on 2017/12/22.
//  Copyright © 2017年 melon. All rights reserved.
//

#import "UserModel.h"
#import <objc/runtime.h>
static NSString  *QUserModel = @"New_201803121700_QUserModel";
@implementation UserModel
+ (instancetype)share{
    static UserModel *user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSData *data = [StandardUserDefaults objectForKey:QUserModel];
        user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (!user) {
            user = [[UserModel alloc] init];
        }
    });
    return user;
}
-(void)encodeWithCoder:(NSCoder *)encoder{
    
    unsigned int count = 0;
    //取出Person这个对象的所有属性
    Ivar *ivars = class_copyIvarList([UserModel class], &count);
    //对所有属性进行遍历
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
        
    }
    free(ivars);
}

-(id)initWithCoder:(NSCoder *)decoder{
    
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([UserModel class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:key];
            // 设置到成员变量身上
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}
-(void)save
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [StandardUserDefaults setObject:data forKey:QUserModel];
    [StandardUserDefaults synchronize];
}
-(BOOL)isLogin
{
    return UserInfo.nickname.length > 0 ? YES : NO;
}
-(void)clear
{
    [StandardUserDefaults removeObjectForKey:QUserModel];
    UserInfo.nickname = @"";
    UserInfo.avatar = @"";
    UserInfo.phone = @"";
}
-(BOOL)isVip
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:UserInfo.vip_end];
    NSInteger code = [self compareOneDay:[NSDate date] withAnotherDay:confromTimesp];
    if (code == 1)
    {
        return NO;
    }
    
    else if (code == -1)
    {
        return YES;
    }
    return NO;
}
- (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        return 1;
    }
    
    else if (result == NSOrderedAscending){
        return -1;
    }
    return 0;
}
@end
