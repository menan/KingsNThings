//
//  specialIncome.h
//  KingsNThings
//
//  Created by Areej Ba Salamah and Menan Vadivel  on 2/3/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface SpecialIncome : NSObject

@property (nonatomic, strong) SKSpriteNode* node;
typedef enum Type : NSUInteger {
    Treasure,
    Event,
    Magic,
    KeyedToTerrain,
    NONE
}Type;

@property int goldValue;
@property Type type;
@property BOOL isKeyedToTerrain, inBowl ,isTreasure ;
@property NSString* symbol;
@property NSString* name, *imageName;
@property NSString* terrainType;


- (id)initWithBoard: (SKSpriteNode *) aBoard atPoint: (CGPoint) aPoint imageNamed: (NSString *) image andCounterName: (NSString *) cName withGoldValue: (int) value forTerrainType: (NSString *) terrain isKeyedToTerrain:(BOOL) keyed;
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string;
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromString:(NSString *)string isKeyedToTerrain: (BOOL) keyed;
- (void) draw;
- (id)initWithImage:(NSString*)image atPoint:(CGPoint)aPoint;

@end

