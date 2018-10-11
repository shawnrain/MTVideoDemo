//
//  PaymentModel.h
//  Kmusic
//
//  Created by melon on 2017/12/22.
//  Copyright © 2017年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Ali,Wx,Qq;
@interface PaymentModel : NSObject
@property (nonatomic, strong) Ali *ali;

@property (nonatomic, strong) Wx *wx;

@property (nonatomic, strong) Qq *qq;

@end
@interface Ali : NSObject

@property (nonatomic, assign) BOOL is_h5;

@property (nonatomic, assign) NSInteger category;

@property (nonatomic, copy) NSString *payment_id;

@end

@interface Wx : NSObject

@property (nonatomic, assign) BOOL is_h5;

@property (nonatomic, assign) NSInteger category;

@property (nonatomic, copy) NSString *payment_id;


@end

@interface Qq : NSObject

@property (nonatomic, assign) BOOL is_h5;

@property (nonatomic, assign) NSInteger category;

@property (nonatomic, copy) NSString *payment_id;


@end
