//
//  Building.h
//  KingsNThings
//
//  Created by Mac5 on 2/6/2014.
//  Copyright (c) 2014 Tinrit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Terrain.h"

@interface Building : NSObject

typedef enum Stage : NSUInteger {
    Tower,
    Keep,
    Castle,
    Citadel
}Stage;

@property Stage stage;
@property Terrain *terrain;
@property NSInteger combatValue ,currentCombatValue;
@property BOOL isMagic,isRanged,isMelee;
@property BOOL isCity,isVillage,isNeutralised;
@property CGPoint point;
@property NSString* imageName;
@property NSString* name;

- (id)initWithStage:(Stage) s andTerrain: (Terrain *) t;



- (id) initWithImage:(NSString*)image atPoint:(CGPoint)aPoint andStage:(Stage) s andTerrain: (Terrain *) t;
@end
