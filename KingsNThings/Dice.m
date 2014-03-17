//
//  Dice.m
//  KingsNThings
//
//  Created by Menan Vadivel on 2014-03-17.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Dice.h"

@implementation Dice

+ (int) roll{
    return (arc4random() % 6) + 1;
}
@end
