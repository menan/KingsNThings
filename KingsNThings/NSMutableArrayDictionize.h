//
//  NSMutableArrayDictionize.h
//  KingsNThings
//
//  Created by Mac5 on 2014-03-27.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//


#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#include <Cocoa/Cocoa.h>
#endif

// This category enhances NSMutableArray by providing
// methods to randomly shuffle the elements.
@interface NSMutableArray (Dictionizing)
- (NSMutableArray *)dictionize;
@end
