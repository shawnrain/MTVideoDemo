//
//  UILabel+YLUtils.m
//  OC-YL
//
//  Created by melon on 2018/7/11.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UILabel+YLUtils.h"

@implementation UILabel (YLUtils)
- (void)yl_setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing - (self.font.lineHeight - self.font.pointSize)];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}
@end
