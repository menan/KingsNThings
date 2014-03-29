//
//  ArmyScene.h
//  KingsNThings
//
//  Created by aob on 3/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "Creature.h"
#import "Army.h"

@interface ArmyScene : SKScene

@property (nonatomic) Player *player;
//@property (nonatomic) Creature *creature;
@property (nonatomic) Army *army;

- (id)initWithSize:(CGSize)size andSender: (id) s;
- (void) drawElements;

@end
