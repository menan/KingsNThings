//
//  SpecialRecruitmentScene.h
//  KingsNThings
//
//  Created by Menan Vadivel on 2014-03-17.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "Creature.h"


@interface SpecialRecruitmentScene : SKScene

@property (nonatomic) Player *player;
@property (nonatomic) Creature *creature;

- (id)initWithSize:(CGSize)size andSender: (id) s;
- (void) drawElements;
@end
