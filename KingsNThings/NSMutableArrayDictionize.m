//
//  NSMutableArrayDictionize.m
//  KingsNThings
//
//  Created by Mac5 on 2014-03-27.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "NSMutableArrayDictionize.h"

@implementation NSMutableArray (Dictionizing)

- (NSMutableArray *)dictionize
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id obj in self) {
        [arr addObject:[obj getDict]];
    }
}

@end
