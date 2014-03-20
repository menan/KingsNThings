//
//  Terrain.m
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Terrain.h"

@implementation Terrain{
    CGPoint point;
    SKSpriteNode *board;
   
    
}
@synthesize type,imageName,flipped,position,node,hasOwner,belongsToP1,belongsToP2,belongsToP3,belongsToP4,hasArmyOnIt,location,hasBuilding;

 static NSInteger counter = 0;

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andTerrainName: (NSString *) name
{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = image;
        type = name;
        flipped = YES;
        belongsToP1 = NO;
        belongsToP2 =NO;
        belongsToP3 = NO;
        belongsToP4 = NO;
        hasArmyOnIt = NO;
        counter +=1;
        [self setLocation:counter];
    }
    return self;
}

- (void) draw{
    node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    [node setName:type];
    [node setAccessibilityLabel:@"terrain"];
    node.size = CGSizeMake(88,88);
    [node setPosition:point];
    [board addChild:node];
}


- (float) getAbsoluteX{
    return node.position.x + 25;
}

- (float) getAbsoluteY{
    return node.position.y + 25;
}

@end
