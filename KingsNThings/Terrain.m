//
//  Terrain.m
//  KingsNThings
//
//  Created by Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import "Terrain.h"

@implementation Terrain{
    CGPoint point;
    SKSpriteNode *board;
}
@synthesize type,imageName,flipped,position;

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andTerrainName: (NSString *) name
{
    self = [super init];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = image;
        type = name;
        flipped = YES;
    }
    return self;
}

- (void) draw{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    [sprite setName:type];
    [sprite setPosition:point];
    [board addChild:sprite];
}
@end
