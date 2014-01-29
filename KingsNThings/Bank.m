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

/*20 of 1golds, 2golds,5golds,10golds
 10 of fifteengold and twentyGold
 
  UIButtonTypeSystem
 UIButtonTypeCustom
 */
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
        [self updateBalance];
        
        
    }
    return self;
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

-(void) updateBalance{
    
    
    balance = oneGold + (twoGold * 2) + (fiveGold * 5) + (tenGold * 10) + (fifteenGold * 15) + (twentyGold * 20);
}

- (NSInteger)getBalance{
    
    return balance;
}



-(SKSpriteNode *) goldsWithImage:(NSString*) imageName{
    
     SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    return sprite;
}


@end
