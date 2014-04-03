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

@property NSMutableArray* stacks, *buildings, *rack, *specialIncome; // collection of things

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

@property BOOL doneTurn;
@property NSMutableDictionary * combat;


- (id) init;


- (BOOL) setBuilding: (Building *) building;
- (BOOL) removeBuilding:(Building*) building;
- (BOOL) setTerritory: (Terrain *) territory;
- (BOOL) addCreatureToArmy:(id)creature inArmy:(Army*)army;
- (BOOL) removeCreatureFromRackByName:(NSString *) name;
- (BOOL) canAdvanceToGold;
- (BOOL) hasSpecialIncomeOnTerrain:(Terrain*)terrain;
- (BOOL) hasBuildingOnTerrain:(Terrain*)terrain;
- (BOOL) hasCitadel;




- (void) justPaid:(int) amount;
- (void) justGotPaid:(int) amount;
- (void) hasLeft:(BOOL) left;
- (void) printArmy;
- (void) returnedACreature;
- (void) addSpecialIncome:(SpecialIncome*)sp;



- (Army*) constructNewStack:(id)creatur atPoint:(CGPoint) aPoint withTerrain:(Terrain*)terrain;
-(void) removeTerrainfromTerritories:(Terrain*)terrain;



/*-------Finders-----*/
- (NSMutableArray *) getTerritories;
- (int) getBankBalance;
- (int) getIncome;
//- (NSInteger) numberOfArmies;
- (Bank *) getBank;
- (Army*) armyByCreature:(id)creature;
- (Army *) getStackAtIndex:(NSInteger)index;
- (Army*) findArmyOnTerrain:(Terrain*)terrain;
- (Building*) getBuildingOnTerrain:(Terrain*)ter;
- (Creature *) findCreatureOnRackByName:(NSString *) name;
- (SpecialIncome *) findSpecialIncomeOnRackByName:(NSString *) name;
-(SpecialIncome *) getSpecialIncomeOnTerrain:(Terrain*)terrain;


@end
