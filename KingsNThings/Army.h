//
//  Army.h
//  KingsNThings
//
//  Created by aob on 2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Terrain.h"

@interface Army : NSObject

@property NSMutableArray* creatures;
@property CGPoint position;
@property BOOL belongsToP1,belongsToP2,belongsToP3,belongsToP4, hasArmyOnIt;
@property BOOL imageIsDrawn;
@property Terrain* terrain;

-(void) addCreatures:(id) creature;
-(id) initWithPoint:(CGPoint) aPoint;
-(NSInteger) getTerrainLocation;

@end
