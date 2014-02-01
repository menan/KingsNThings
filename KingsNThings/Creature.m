//
//  Creature.m
//  KingsNThings
//
//  Created by Mac5 on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Creature.h"

@implementation Creature{
    CGPoint point;
    SKSpriteNode *board;
    NSString* combatType;
    NSString* terrainType;
    int combatValue;
    BOOL special;
    BOOL bluff;
    int position;
    NSString* imageName;
    NSString* name;

}

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCreatureName: (NSString *) cName withCombatValue: (int) value forTerrainType: (NSString *) terrain isSpecial:(BOOL) special andCombatType:(NSString *) cType
{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = image;
        name = cName;
        bluff = NO;
        combatType = cType;
        terrainType = terrain;
        combatValue = value;
    }
    return self;
}

- (void) draw{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    [sprite setName:name];
    sprite.size = CGSizeMake(36,36);
    [sprite setPosition:point];
    [board addChild:sprite];
}
@end
