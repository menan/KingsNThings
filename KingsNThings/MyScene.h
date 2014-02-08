//
//  MyScene.h
//  KingsNThings
//

//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Army.h"
@interface MyScene : SKScene

@property (nonatomic, strong) SKSpriteNode *board;
@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) SKLabelNode *myLabel;
-(void) transitToCombat:(Army*)attacker andDefender:(Army*)defender;

@end
