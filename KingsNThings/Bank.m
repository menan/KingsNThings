//
//  Bank.m
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Bank.h"
#import <UIKit/UIKit.h>

@implementation Bank



@synthesize oneGold;
@synthesize twoGold;
@synthesize fiveGold;
@synthesize tenGold;
@synthesize fifteenGold;
@synthesize twentyGold;

- (id) init
{
    if ( self = [super init] )
    {
        [self setOneGold:20];
        [self setTwoGold:20];
        [self setFiveGold:20];
        [self setTenGold:20];
        [self setFifteenGold:10];
        [self setTwentyGold:10];
        
        
    }
    return self;
}

- (id) initWithOneGolds: (int) ones twoGolds: (int) twos fivesGolds: (int) fives tenGolds: (int) tens fifteenGolds: (int) fifteens twentyGolds: (int) twentys{
    
    if ( self = [super init] )
    {
        [self setOneGold:ones];
        [self setTwoGold:twos];
        [self setFiveGold:fives];
        [self setTenGold:tens];
        [self setFifteenGold:fifteens];
        [self setTwentyGold:twentys];
        
        
    }
    return self;
}
//deposit only one type of gold at a time please.
- (int) depositGold:(int) type andCount:(int) count{
    switch (type) {
        case 1:
            oneGold += count;
            break;
        case 2:
            twoGold += count;
            break;
        case 5:
            fiveGold += count;
            break;
        case 10:
            tenGold += count;
            break;
        case 15:
            fifteenGold += count;
            break;
        case 20:
            twentyGold += count;
            break;
        default:
            break;
    }
    return [self getBalance];
}

//deposit only one type of gold at a time please.
- (BOOL) withdrawGold:(int) type andCount:(int) count{
    switch (type) {
        case 1:
            oneGold-= count;
            break;
        case 2:
            twoGold-= count;
            break;
        case 5:
            fiveGold-= count;
            break;
        case 10:
            tenGold-= count;
            break;
        case 15:
            fifteenGold-= count;
            break;
        case 20:
            twentyGold-= count;
            break;
        default:
            break;
    }
    return YES;
}


- (int) deposit:(int) amount{
    int income = amount;
    int twentys = 0;
    int fifteens = 0;
    int tens = 0;
    int fives = 0;
    int twos = 0;
    int ones = 0;
    
    if (income <= 20) {
        twentys = income / 20;
        income = income % 20;
    }
    if (income <= 15) {
        fifteens = income / 15;
        income = income % 15;
    }
    if (income <= 10) {
        tens = income / 10;
        income = income % 10;
    }
    
    if (income <= 5) {
        fives = income / 5;
        income = income % 5;
    }
    if (income <= 2) {
        twos = income / 2;
        income = income % 2;
    }
    if (income <= 1) {
        ones = income / 1;
        income = income % 1;
    }
    
    oneGold += ones;
    twoGold += twos;
    fiveGold += fives;
    tenGold += tens;
    fifteenGold += fifteens;
    twentyGold += twentys;
    
    return [self getBalance];
}


- (BOOL) withdraw:(int) amount{
    if ([self getBalance] <= amount){
        
        int income = amount;
        int twentys = 0;
        int fifteens = 0;
        int tens = 0;
        int fives = 0;
        int twos = 0;
        int ones = 0;
        
        if (income <= 20) {
            twentys = income / 20;
            income = income % 20;
        }
        if (income <= 15) {
            fifteens = income / 15;
            income = income % 15;
        }
        if (income <= 10) {
            tens = income / 10;
            income = income % 10;
        }
        
        if (income <= 5) {
            fives = income / 5;
            income = income % 5;
        }
        if (income <= 2) {
            twos = income / 2;
            income = income % 2;
        }
        if (income <= 1) {
            ones = income / 1;
            income = income % 1;
        }
        
        oneGold -= ones;
        twoGold -= twos;
        fiveGold -= fives;
        tenGold -= tens;
        fifteenGold -= fifteens;
        twentyGold -= twentys;
        
        return YES;
    }
    else{
        return NO;
    }
}


/*- (id)initWithBoard:
{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = image;
        type = name;
        flipped = YES;
    }
    return self;
}*/


- (int) getBalance{
    return oneGold + (twoGold * 2) + (fiveGold * 5) + (tenGold * 10) + (fifteenGold * 15) + (twentyGold * 20);
}



-(SKSpriteNode *) goldsWithImage:(NSString*) imageName{
    
     SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    return sprite;
}


@end
