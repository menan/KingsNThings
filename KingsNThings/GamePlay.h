//
//  GamePlay.h
//

//
// Created by Areej Ba Salamah and Menan Vadivel on 2/1/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "MyScene.h"

@interface GamePlay : NSObject

typedef enum {
    Initial,
    Construction,
    Movement,
    Recruitment,
    SpecialRecruitment, //special character recruitment
    Combat,
    GoldCollection,
    SpecialPower,
    RandomEvents
} Phase;


@property Player *me;
@property MyScene *scene;

@property NSInteger oneDice;
@property NSInteger secondDice;
@property NSMutableArray *players, *terrains;

@property NSArray *p1Stack1,*p1Stack2,*p2Stack1,*p3Stack1,*p3Stack2,*p3Stack3,*p4Stack1,*p4Stack2,*p4Stack3;

//@property BOOL goldPhase , isMovementPhase , isThingRecrPahse, isComabtPahse,isInitialPhase,isConstructionPhase;
@property Phase phase;

- (void) initiateCombat: (Player*) p;
- (id) initWithBoard:(id) b;
- (void) combatPhase:(Player *)attacker withArmy:(Army*)attackerArmy andPlayer:(Player*)defender withArmy:(Army*)defenderArmy isDefending:(BOOL)t;
- (Player *) currentPlayer;
- (Player *) findPlayerByTerrain:(Terrain *) terrain;
- (NSMutableArray *) findPlayersByTerrain:(Terrain *) terrain; //gets all the players on the terrain

- (void)movementPhase:(Player *)player withArmy:(Army*)army onTerrian:(Terrain*) newTerrain;
- (Terrain*) findTerrainAt:(CGPoint)thisPoint;
- (Player*)findPlayerByOrder:(NSInteger)order;
- (void) assignScene:(MyScene*)sce;
- (void) advancePhase: (Phase) p;
- (void) presentGCTurnViewController:(id)sender;
- (void) checkInitalRecruitmentComplete;
- (BOOL) recruitmentComplete;
- (void) checkBluffForPlayer:(Player *) player;
- (void) endTurn:(id)sender;
-(BOOL) validateHex:(Terrain*)terrain forPlayer:(Player*)player;
-(NSInteger) buildingCost;

@end
