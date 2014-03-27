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

@interface Army : NSObject

@property NSMutableArray* creatures;
@property CGPoint position;
//@property BOOL belongsToP1,belongsToP2,belongsToP3,belongsToP4, hasArmyOnIt;
@property BOOL imageIsDrawn;
@property Terrain* terrain;
@property SKSpriteNode *image;
@property NSInteger armyNumber;
@property NSInteger playerNumber;
@property Building* building;


-(void) addCreatures:(id) creature;
-(id) initWithPoint:(CGPoint) aPoint;
-(NSInteger) getTerrainLocation;
-(void) removeCreature:(id)creature;
-(void) removeCreatureWithName:(NSString*)name;
-(BOOL) containCreature:(id)creature;
-(NSInteger) creaturesInArmy;
-(void) drawImage:(SKSpriteNode *) aBoard ;

@end
