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
- (int) depositGold:(int) type{
    switch (type) {
        case 1:
            oneGold++;
            break;
        case 2:
            twoGold++;
            break;
        case 5:
            fiveGold++;
            break;
        case 10:
            tenGold++;
            break;
        case 15:
            fifteenGold++;
            break;
        case 20:
            twentyGold++;
            break;
        default:
            break;
    }
    return [self getBalance];
}

//deposit only one type of gold at a time please.
- (BOOL) withdrawGold:(int) type{
    switch (type) {
        case 1:
            oneGold--;
            break;
        case 2:
            twoGold--;
            break;
        case 5:
            fiveGold--;
            break;
        case 10:
            tenGold--;
            break;
        case 15:
            fifteenGold--;
            break;
        case 20:
            twentyGold--;
            break;
        default:
            break;
    }
    return YES;
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
