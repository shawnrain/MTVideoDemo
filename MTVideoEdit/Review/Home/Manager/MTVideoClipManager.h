//
//  MTVideoClipManager.h
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTVideoEditManager.h"

@interface MTVideoClipManager : MTVideoEditManager

- (void)clipVideoStartIndex:(CGFloat)start end:(CGFloat)end completion:(completion)completion;
@end
