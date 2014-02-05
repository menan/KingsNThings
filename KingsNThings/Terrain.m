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
@synthesize type,imageName,flipped,position,node;

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
    node = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    [node setName:type];
    node.size = CGSizeMake(88,88);
    [node setPosition:point];
    [board addChild:node];
}
@end
