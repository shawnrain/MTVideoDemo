//
//  MTAVPlayerItem.m
//  
//
//  Created by MTShawn on 2018/9/11.
//

#import "MTAVPlayerItem.h"

@implementation MTAVPlayerItem
//实现kvo自动释放
- (void)dealloc {
    if (self.observer) {
        [self removeObserver:self.observer forKeyPath:@"status"];
    }
}
@end
