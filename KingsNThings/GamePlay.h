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

@interface GamePlay : NSObject

@property Player *player1;
@property Player *player2;
@property Player *player3;
@property Player *player4;
@property MyScene *scene;
@property NSInteger oneDice;
@property NSInteger secondDice;
@property NSMutableArray *players, *terrains;
@property NSArray *p1Stack1,*p1Stack2,*p2Stack1,*p3Stack1,*p3Stack2,*p3Stack3,*p4Stack1,*p4Stack2,*p4Stack3;

@property BOOL goldCollectionCompleted,goldPhase , isMovementPhase , isThingRecrPahse, isComabtPahse,isMagicRound,isRangedRound,isMeleeRound;
- (void) initiateCombat: (Player*) p;
-(id) initWith4Players;
-(void) combatPhase:(Player *)attacker withArmy:(Army*)attackerArmy andPlayer:(Player*)defender withArmy:(Army*)defenderArmy;
- (Player *) findPlayerByTerrain:(Terrain *) terrain;
-(void)movementPhase:(Player *)player withArmy:(Army*)army;
-(Terrain*) findTerrainAt:(CGPoint)thisPoint;
-(Player*)findPlayerByOrder:(NSInteger)order;
-(void) assignScene:(MyScene*)sce;
@end
