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


typedef enum {
    ClockWise,
    CounterClockWise
    
}PlayingOrder;

@property Player *me;
@property MyScene *scene;

@property NSInteger oneDice;
@property NSInteger secondDice;
@property NSMutableArray *players, *terrains, *battles;

@property Phase phase;
@property PlayingOrder order;



- (id) initWithBoard:(id) b;

//- (void) initiateCombat: (Player*) p;
- (void) combatPhase:(Player *)attacker withArmy:(Army*)attackerArmy andPlayer:(Player*)defender withArmy:(Army*)defenderArmy;
- (void) movementPhase:(Player *)player withArmy:(Army*)army onTerrian:(Terrain*) newTerrain;


- (Player *) currentPlayer;
- (int) currentPlayerId;
- (int) totalPlayers;
- (Player*) checkForWinner;

- (Player *) findPlayerByTerrain:(Terrain *) terrain;
- (NSMutableArray *) findPlayersByTerrain:(Terrain *) terrain; //gets all the players on the terrain
- (Terrain*) findTerrainAt:(CGPoint)thisPoint;
- (Terrain *) locateTerrainAt:(CGPoint)thisPoint;
- (Player*) findPlayerArmy:(Army*) army;
- (Player*)findPlayerByOrder:(NSInteger)order;

- (void) assignScene:(MyScene*)sce;

- (NSString *) advancePhase: (Phase) p;
- (NSString *) advancePhase;


- (void) presentGCTurnViewController:(id)sender;
- (void) checkInitalRecruitmentComplete;
- (BOOL) recruitmentComplete;
- (void) checkBluffForPlayer:(Player *) player;
- (void) endTurn:(id)sender;

- (BOOL) validateHex:(Terrain*)terrain forPlayer:(Player*)player;
- (BOOL) isHexAdjacent:(Terrain*)terrain forPlayer:(Player*)p;
- (NSInteger) buildingCost;
- (void) combatPhase;
- (BOOL) thereAreDefendersOnTerrain:(Terrain *) terrain;
- (BOOL) thereIsArmyOnTerrain:(Terrain *) terrain;


- (NSDictionary *) getBoardAsADictionary;
@end
