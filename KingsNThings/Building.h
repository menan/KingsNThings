//
//  Building.h
//  KingsNThings
//
//Created by Areej Ba Salamah and Menan Vadivel on  2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Terrain.h"

@interface Building : SKSpriteNode

typedef enum Stage : NSUInteger {
    Tower,
    Keep,
    Castle,
    Citadel,
    None
}Stage;

typedef enum CombatType : NSUInteger {
  Magic,
  Ranged,
  Melee
}CombatType;


@property Stage stage;
@property CombatType combat;
@property Terrain *terrain;
@property NSInteger combatValue ,currentCombatValue;
@property BOOL isNeutralised;
@property CGPoint point;
@property NSString* imageName;
@property NSString* name;
@property NSInteger cost;
@property SKNode *imageNode;

- (id)initWithStage:(Stage) s andTerrain: (Terrain *) t;
- (id) initWithBoard:(SKSpriteNode *)aBoard atPoint:(CGPoint)aPoint fromImage:(NSString *)image;
- (id) initWithImage:(NSString*)image atPoint:(CGPoint)aPoint andStage:(Stage) s andTerrain: (Terrain *) t;

-(BOOL)checkIfConstructionPossible:(Building*) newBuilding;


@end
