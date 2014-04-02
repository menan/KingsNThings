//
//  Army.h
//  KingsNThings
//
//  Created by aob on 2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Terrain.h"
#import "Building.h"

@interface Army : SKSpriteNode

@property NSMutableArray* creatures;
@property BOOL hasArmyOnIt;
@property BOOL imageIsDrawn;
@property Terrain* terrain;
//@property SKSpriteNode *image;
@property NSInteger armyNumber;
@property NSInteger playerNumber;
@property Building* building;
@property int stepsMoved;


-(void) addCreatures:(id) creature;
-(id) initWithPoint:(CGPoint) aPoint;
-(NSInteger) getTerrainLocation;
-(void) removeCreature:(id)creature;
-(void) removeCreatureWithName:(NSString*)name;
-(BOOL) containCreature:(id)creature;
-(NSInteger) creaturesInArmy;
-(void) drawImage:(SKSpriteNode *) aBoard ;
- (NSDictionary *) getDict;
-(void) updateMovingSteps:(NSInteger)steps;
-(NSInteger) getMovedSteps;
-(void) resetMovingSteps;

@end
