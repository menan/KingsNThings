//
//  GamePlay.h
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 2/1/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "MyScene.h"
#import "Server.h"

@interface GamePlay : NSObject<ServerDelegate>

@property(nonatomic, retain) Server *server;

@property Player *me;
@property MyScene *scene;

@property NSInteger oneDice;
@property NSInteger secondDice;
@property NSMutableArray *players, *terrains;

@property NSArray *p1Stack1,*p1Stack2,*p2Stack1,*p3Stack1,*p3Stack2,*p3Stack3,*p4Stack1,*p4Stack2,*p4Stack3;

@property BOOL goldCollectionCompleted,goldPhase , isMovementPhase , isThingRecrPahse, isComabtPahse,isMagicRound,isRangedRound,isMeleeRound;
- (void) initiateCombat: (Player*) p;
-(id) initWithBoard:(id) b;
-(void) combatPhase:(Player *)attacker withArmy:(Army*)attackerArmy andPlayer:(Player*)defender withArmy:(Army*)defenderArmy;
- (Player *) findPlayerByTerrain:(Terrain *) terrain;
-(void)movementPhase:(Player *)player withArmy:(Army*)army;
-(Terrain*) findTerrainAt:(CGPoint)thisPoint;
-(Player*)findPlayerByOrder:(NSInteger)order;
-(void) assignScene:(MyScene*)sce;
@end
