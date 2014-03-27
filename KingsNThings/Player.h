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
#import "Creature.h"
#import "SpecialIncome.h"


@interface Player : NSObject

@property NSMutableArray* armies; // collection of armies
@property NSMutableArray* rack; // collection of things on rack
@property NSMutableArray* specialIncome;
//@property NSMutableArray* singleArmy; // single armies (eg stack one )
@property NSInteger playingOrder;
//@property NSArray *p1Stack1,*p1Stack2,*p2Stack1,*p3Stack1,*p3Stack2,*p3Stack3,*p4Stack1,*p4Stack2,*p4Stack3;
@property Bank* bank;
@property Army* army;
@property int balance; //to keep track of the paid amount to the bank when paid in 1s
@property int recruitsRemaining;
@property int returnedCreatures;
@property int movementsRemaining;
@property BOOL hasWonCombat;
@property BOOL isWaitingCombat;
@property BOOL playerLeft;
@property BOOL hasBuiltCitadel;
@property BOOL doneInitial;
@property NSMutableDictionary * combat;


- (BOOL) setBuilding: (Building *) building;
- (BOOL) removeBuilding:(Building*) building;
- (BOOL) setTerritory: (Terrain *) territory;
- (NSMutableArray *) getTerritories;
- (int) getBankBalance;
- (id) init;
- (void) justPaid:(int) amount;
- (void) justGotPaid:(int) amount;
- (Bank *) getBank;
- (int) getIncome;
- (Army*) constructNewArmy:(id)creatur atPoint:(CGPoint) aPoint withTerrain:(Terrain*)terrain;
- (BOOL) addCreatureToArmy:(id)creature inArmy:(Army*)army;
- (void) printArmy;
- (Army*) armyByCreature:(id)creature;
- (NSInteger) numberOfArmies;
- (Army *) getArmyAtIndex:(NSInteger)index;
- (Army*) findArmyOnTerrain:(Terrain*)terrain;
- (Building*) getBuildingOnTerrain:(Terrain*)ter;
- (void) hasLeft:(BOOL) left;
- (Creature *) findCreatureOnRackByName:(NSString *) name;
- (BOOL) removeCreatureFromRackByName:(NSString *) name;
- (void) returnedACreature;
- (void) addSpecialIncome:(SpecialIncome*)sp;
- (SpecialIncome *) findSpecialIncomeOnRackByName:(NSString *) name;
- (BOOL) canAdvanceToGold;
@end
