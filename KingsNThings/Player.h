//
//  Player.h
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bank.h"
#import "Terrain.h"

@interface Player : NSObject

@property NSMutableArray* armies; // collection of armies
@property NSMutableArray* singleArmy; // single armies (eg stack one )
@property NSInteger playingOrder;
@property NSArray *p1Stack1,*p1Stack2,*p2Stack1,*p3Stack1,*p3Stack2,*p3Stack3,*p4Stack1,*p4Stack2,*p4Stack3;


typedef enum Stage : NSUInteger {
    Tower,
    Keep,
    Castle,
    Citadel
}Stage;
- (void) depositGold:(int) goldType;
- (BOOL) withdrawGold:(int) goldType;
- (BOOL) setTerritory: (Terrain *) territory;
- (int) getBankBalance;
- (id) initWithArmy;
- (void) constructArmy:(NSMutableArray *) army;
- (Stage) getStage;
- (Bank *) getBank;
- (int) getIncome;
@end
