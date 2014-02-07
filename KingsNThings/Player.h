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
#import "Building.h"
#import "Army.h"


@interface Player : NSObject

@property NSMutableArray* armies; // collection of armies
//@property NSMutableArray* singleArmy; // single armies (eg stack one )
@property NSInteger playingOrder;
//@property NSArray *p1Stack1,*p1Stack2,*p2Stack1,*p3Stack1,*p3Stack2,*p3Stack3,*p4Stack1,*p4Stack2,*p4Stack3;
@property Bank* bank;
@property Army* army;


- (BOOL) setBuilding: (Building *) building;
- (BOOL) setTerritory: (Terrain *) territory;
- (NSMutableArray *) getTerritories;
- (int) getBankBalance;
- (id) initWithArmy;
- (NSMutableArray*)constructArmy;
//- (Stage) getStage;
- (Bank *) getBank;
- (int) getIncome;
-(void) constructNewArmy:(id)creatur atPoint:(CGPoint) aPoint withTerrain:(Terrain*)terrain;
-(void) addCreatureToArmy:(id)creature inArmy:(Army*)army;
-(void) printArmy;
@end
