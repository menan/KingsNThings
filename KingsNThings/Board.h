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
@property SKLabelNode* textLabel, *recruitLabel;
@property NSInteger dicesClicked,creaturesInBowl;
@property GamePlay *game;
@property NSArray *disabled;
@property NSArray *nonMovables;

- (id)initWithScene: (MyScene *) aScene atPoint: (CGPoint) aPoint withSize: (CGSize) aSize;
- (void)draw;
- (void) drawMarkersForPlayer:(int) j;
- (void) updateBank;
- (SKSpriteNode *) getBoard;
- (GamePlay*)getGamePlay;
- (void) resetText;
- (NSArray *) getNonMovables;
- (void) rollDiceOne;
- (void) rollDiceTwo;
- (void) nodeTapped:(SKSpriteNode*) node;
- (void) nodeMoved:(SKSpriteNode *)node nodes:(NSArray *)nodes;
- (void) updateRecruitLabel:(Player *) p;
- (BOOL) canMoveNode:(SKSpriteNode*) node;
- (BOOL) canSelectNode:(SKSpriteNode*) node;
- (void) captureHex:(Player*) player atTerrain:(Terrain*)terrain;
@end
