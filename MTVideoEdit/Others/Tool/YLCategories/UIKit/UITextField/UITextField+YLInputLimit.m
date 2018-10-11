//
//  UITextField+YLInputLimit.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UITextField+YLInputLimit.h"
#import <objc/runtime.h>
@implementation UITextField (YLInputLimit)
- (NSInteger)yl_maxLength
{
    return [objc_getAssociatedObject(self, @selector(yl_maxLength)) integerValue];
}
- (void)setYl_maxLength:(NSInteger)yl_maxLength
{
    objc_setAssociatedObject(self, @selector(yl_maxLength), @(yl_maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(yl_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)yl_textFieldTextDidChange
{
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.yl_maxLength > 0 && toBeString.length > self.yl_maxLength)){
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.yl_maxLength];
        if (rangeIndex.length == 1){
            self.text = [toBeString substringToIndex:self.yl_maxLength];
        }else{
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.yl_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.yl_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}
@end
