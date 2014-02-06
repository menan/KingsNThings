//
//  Bank.h
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Bank : NSObject
{
    /*20 of 1golds, 2golds,5golds,10golds
     10 of fifteengold and twentyGold
     */
    
    NSInteger oneGold;
    NSInteger twoGold;
    NSInteger fiveGold;
    NSInteger tenGold;
    NSInteger fifteenGold;
    NSInteger twentyGold;
       
}

@property NSInteger oneGold;
@property NSInteger twoGold;
@property NSInteger fiveGold;
@property NSInteger tenGold;
@property NSInteger fifteenGold;
@property NSInteger twentyGold;



- (int)getBalance;
- (int) depositGold:(int) type;
- (BOOL) withdrawGold:(int) type;

//- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image;
- (id) initWithOneGolds: (int) ones twoGolds: (int) twos fivesGolds: (int) fives tenGolds: (int) tens fifteenGolds: (int) fifteens twentyGolds: (int) twentys;

//- (id)initWithPlayer: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image;

-(SKSpriteNode *) goldsWithImage:(NSString*) imageName;

@end
