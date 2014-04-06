//
//  Board.h
//  ;
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "GamePlay.h"
#import "MyScene.h"

@interface Board : NSObject
@property SKLabelNode* textLabel, *recruitLabel, *doneButton;
@property NSInteger dicesClicked,creaturesInBowl;
@property GamePlay *game;
@property Bank *bank;
@property NSMutableArray *bowl;
@property NSArray *disabled;
@property NSArray *nonMovables;
@property CGPoint bowlLocaiton;
@property NSMutableArray* terrainsLayout, *terrainsDictionary, *markersArray;
@property BOOL canTapDone;


- (id)initWithScene: (MyScene *) aScene atPoint: (CGPoint) aPoint withSize: (CGSize) aSize;

- (void)draw;
- (void) drawMarkersForPlayer:(int) j;


- (void) updateBank;
- (SKSpriteNode *) getBoard;
- (GamePlay*)getGamePlay;

- (void) resetText;
- (void) updateRecruitLabel:(Player *) p;

- (NSArray *) getNonMovables;

- (void) rollDiceOne;
- (void) rollDiceTwo;

//- (void) nodeTapped:(SKSpriteNode*) node;
- (void) nodeMoved:(SKSpriteNode *)node nodes:(NSArray *)nodes;
- (BOOL) canMoveNode:(SKSpriteNode*) node;
- (BOOL) canSelectNode:(SKSpriteNode*) node;


- (void) captureHex:(Player*) player atTerrain:(Terrain*)terrain;
- (void) creaturesMoved:(Creature *) n AtTerrain:(Terrain *) t;
- (Army*) createRandomArmy:(NSInteger) number atPoint:(CGPoint)aPoint andTerrain:(Terrain*)terrain;
- (void) playTreasure:(SKSpriteNode*)node;
- (void) showArmyCreatures:(Army*)army;


- (void) hideDone;
- (void) showDone;
- (void) hideMarkersExceptCurrentPlayer;


- (void) constructBowlFromDictionary:(NSArray *) bowlArray;
- (void) constructTerrainFromDictionary:(NSArray *) terrains;
- (void) constructStackFromDictionary:(NSArray *) stacks;
- (void) constructRackFromDictionary:(NSArray *) racks;
- (void) constructPlacemarkerFromDictionary:(NSArray *) placemarkers;
- (void) constructBuildingsFromDictionary:(NSArray *) placemarkers;
- (void) setGoldsFromDictionary:(NSArray *) goldsArray;
- (void) returnThingToBowl:(id) thing;

@end
