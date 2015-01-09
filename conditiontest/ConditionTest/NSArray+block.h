//
//  NSArray+block.h
//  ConditionTest
//
//  Created by Apple_Gong on 15-1-9.
//  Copyright (c) 2015年 Apple_Gong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSArray*(^arrayBlock)(void);

@interface NSArray (block)

- (NSArray*)selectWithblock:(arrayBlock)block;

@end
