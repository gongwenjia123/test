//
//  NSArray+block.m
//  ConditionTest
//
//  Created by Apple_Gong on 15-1-9.
//  Copyright (c) 2015年 Apple_Gong. All rights reserved.
//

#import "NSArray+block.h"

@implementation NSArray (block)

- (NSArray*)selectWithblock:(arrayBlock)block
{
    return  block();
}
@end
