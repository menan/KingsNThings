//
//  Bank.h
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Bank : NSObject
{
    
    
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
- (int) depositGold:(int) type andCount:(int) count;
- (BOOL) withdrawGold:(int) type andCount:(int) count;

- (int) deposit:(int) amount;
- (BOOL) withdraw:(int) amount;

//- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image;
- (id) initWithOneGolds: (int) ones twoGolds: (int) twos fivesGolds: (int) fives tenGolds: (int) tens fifteenGolds: (int) fifteens twentyGolds: (int) twentys;

//- (id)initWithPlayer: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image;

-(SKSpriteNode *) goldsWithImage:(NSString*) imageName;

@end
