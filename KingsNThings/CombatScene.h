//
//  CombatScene.h
//  KingsNThings
//
//  Created by aob on 2/7/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Army.h"

@interface CombatScene : SKScene

-(id)initWithSize:(CGSize)size withAttacker:(Army*)att andDefender:(Army*)def andSender:(id) sender;
@end
