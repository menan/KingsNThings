//
//  Player.h
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bank.h"
#import "Terrain.h"
#import "Building.h"
#import "Army.h"


@interface Player : NSObject

@property NSMutableArray* armies; // collection of armies
//@property NSMutableArray* singleArmy; // single armies (eg stack one )
@property NSInteger playingOrder;
//@property NSArray *p1Stack1,*p1Stack2,*p2Stack1,*p3Stack1,*p3Stack2,*p3Stack3,*p4Stack1,*p4Stack2,*p4Stack3;
@property Bank* bank;
@property Army* army;
@property int balance; //to keep track of the paid amount to the bank when paid in 1s
@property int recruitsRemaining;
@property BOOL hasWonCombat;
@property BOOL isWaitingCombat;
@property BOOL playerLeft;
@property NSMutableDictionary * combat;


- (BOOL) setBuilding: (Building *) building;
- (BOOL) setTerritory: (Terrain *) territory;
- (NSMutableArray *) getTerritories;
- (int) getBankBalance;
-(id) init;
- (void) justPaid:(int) amount;
- (void) justGotPaid:(int) amount;
//- (Stage) getStage;
-(Bank *) getBank;
-(int) getIncome;
-(Army*) constructNewArmy:(id)creatur atPoint:(CGPoint) aPoint withTerrain:(Terrain*)terrain;
-(BOOL) addCreatureToArmy:(id)creature inArmy:(Army*)army;
-(void) printArmy;
-(Army*) hasCreature:(id)creature;
-(NSInteger) numberOfArmies;
- (Army *) getArmyAtIndex:(NSInteger)index;
-(Army*) findArmyOnTerrain:(Terrain*)terrain;
-(Building*) getBuildingOnTerrain:(Terrain*)ter;
- (void) hasLeft:(BOOL) left;

@end
