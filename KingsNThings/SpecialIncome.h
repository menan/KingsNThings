//
//  specialIncome.h
//  KingsNThings
//
//  Created by Areej Ba Salamah and Menan Vadivel  on 2/3/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Terrain.h"

@interface SpecialIncome : SKSpriteNode

//@property (nonatomic, strong) SKSpriteNode* node;
typedef enum Type : NSUInteger {
    Treasure,
    Event,
    MagicItem,
    Docked, //keyed to the terrain
    Village,
    City
}Type;

@property int goldValue;
@property Type type;
@property BOOL  inBowl;
@property CGPoint initialPoint;

@property NSString* terrainType;
@property Terrain* terrain;


//- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCounterName: (NSString *) cName withGoldValue: (int) value forTerrainType: (NSString *) ter isKeyedToTerrain:(BOOL) keyed;
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string;
//- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string isKeyedToTerrain: (BOOL) keyed;
- (id)initWithImage:(NSString*)image atPoint:(CGPoint)aPoint;

- (void) draw;


@end

