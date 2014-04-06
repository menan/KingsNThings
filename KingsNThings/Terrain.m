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
@synthesize type,imageName,flipped,location;

static int TERRAIN_POSITION = -1; //to find the posision for each terrains, so that we can eliminate some for 2 player game

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andTerrainName: (NSString *) name
{
    self = [super initWithImageNamed:image];
    if (self) {
        point = aPoint;
        board = aBoard;
        imageName = image;
        type = name;
        flipped = YES;
        TERRAIN_POSITION++;
        location = TERRAIN_POSITION;
    }
    return self;
}


- (void) draw{
    [self setName:type];
    self.size = CGSizeMake(88,88);
    [self setPosition:point];
    [board addChild:self];
}



- (float) getAbsoluteX{
    return self.position.x;
}

- (float) getAbsoluteY{
    return self.position.y;
}

@end
