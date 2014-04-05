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


- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andTerrainName: (NSString *) name
{
    self = [super initWithImageNamed:image];
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
