//
//  Terrain.h
//  KingsNThings
//
// Created by Areej Ba Salamah and Menan Vadivel on 1/28/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>


@interface Terrain : SKSpriteNode

@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* imageName;
@property BOOL flipped;
@property int location;

- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andTerrainName: (NSString *) name;
-(void) draw;

- (float) getAbsoluteX;
- (float) getAbsoluteY;

@end
