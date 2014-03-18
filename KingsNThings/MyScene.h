//
//  MyScene.h
//  KingsNThings
//

//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "Creature.h"

@interface MyScene : SKScene

@property (nonatomic, strong) SKSpriteNode *board;
@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) SKLabelNode *myLabel;
@property (nonatomic, strong) UIViewController *controller;

- (void) transitToCombat:(id)attacker andDefender:(id)defender andCombatFunction:(id)combatfun;
- (void) transitToRecruitmentScene: (Creature *) c forPlayer: (Player *) p;
- (void) startSecondCombat;
- (id) getGame;
+ (void) wiggle: (SKSpriteNode *) node;
@end
