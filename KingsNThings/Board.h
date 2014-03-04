//
//  Board.h
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "GamePlay.h"

@interface Board : NSObject
@property SKLabelNode* textLabel, *recruitLabel;
@property NSInteger dicesClicked,creaturesInBowl;
@property GamePlay *game;
@property NSArray *disabled;
@property NSArray *nonMovables;

- (id)initWithScene: (SKScene *) aScene atPoint: (CGPoint) aPoint withSize: (CGSize) aSize;
- (void)draw;
- (SKSpriteNode *) getBoard;
-(GamePlay*)getGamePlay;
- (void) resetText;
- (NSArray *) getNonMovables;
- (void) rollDiceOne;
-(void) rollDiceTwo;
- (void) nodeTapped:(SKSpriteNode*) node;
- (void) nodeMoved:(SKSpriteNode *)node nodes:(NSArray *)nodes;
- (void) nodeMoving:(SKSpriteNode*) node to:(CGPoint) modTo;
@end
